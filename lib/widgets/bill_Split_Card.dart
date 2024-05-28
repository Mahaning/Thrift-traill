import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/appValidator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class Bill {
  final String billUid;
  final double totalBillAmount;
  final double numberOfPeople;
  final String description;
  final List<Map<String, dynamic>> peopleDetails;
  // DocumentReference billDoc = bills.doc();

  var billPerPerson;

  var timestamp;

  Bill({
    required this.billUid,
    required this.totalBillAmount,
    required this.numberOfPeople,
    required this.description,
    required this.peopleDetails,
    required this.billPerPerson,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'billUid': Uuid().v4(),
      'totalBillAmount': totalBillAmount,
      'numberOfPeople': numberOfPeople,
      'description': description,
      'peopleDetails': peopleDetails,
      'billPerPerson': billPerPerson,
      'timestamp':timestamp
    };
  }
}

class Person {
  final String phoneNumber;
  final double totalAmountToPay;
  final String name;

  Person({
    required this.phoneNumber,
    required this.totalAmountToPay,
  required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'name':name,
      'phoneNumber': phoneNumber,
      'totalAmountToPay': totalAmountToPay,
    };
  }
}




class SplitBillCard extends StatelessWidget {
  SplitBillCard({
    super.key,
    required this.userId,
  });

  final String userId;
  final _totalBillAmountController = TextEditingController();
  final _totalNumberOfPepoleController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // final Stream<DocumentSnapshot> _usersStream =
    // FirebaseFirestore.instance.collection('users').doc(userId).snapshots();
    return Cards();
  }
}

class Cards extends StatefulWidget {
  Cards({
    super.key,
  });

  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  final _totalBillAmountController = TextEditingController();
  final _totalNumberOfPepoleController = TextEditingController();
  final _splitBillController = TextEditingController();
  final _descriptionController=TextEditingController();
  var appValidator = AppValidator();
  List<Contact> _selectedContacts = [];

  double calculateSplitBill() {
    double totalBillAmount = double.parse(_totalBillAmountController.text);
    int totalNumberOfPeople = int.parse(_totalNumberOfPepoleController.text);
    return totalBillAmount / totalNumberOfPeople;
  }

  Future<void> openContactList() async {
    if (_selectedContacts.length >= int.parse(_totalNumberOfPepoleController.text)) {
      _showWarningDialog();
      return;
    }
    if (await Permission.contacts.request().isGranted) {
      Contact? contact = await ContactsService.openDeviceContactPicker();
      if (contact != null) {
        bool contactExists = _selectedContacts.any((existingContact) => existingContact.identifier == contact.identifier);
        if (!contactExists) {
          setState(() {
            _selectedContacts.add(contact);
          });
        }
      }
    }
  }



  Future<void> _showAddContactDialog() async {
    if (_selectedContacts.length >= int.parse(_totalNumberOfPepoleController.text)) {
      _showWarningDialog();
      return;
    }
    final _contactNameController = TextEditingController();
    final _phoneNumberController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Contact'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: _contactNameController,
                  decoration: InputDecoration(hintText: "Contact Name"),
                ),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(hintText: "Phone Number"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                setState(() {
                  _selectedContacts.add(Contact(
                    displayName: _contactNameController.text,
                    phones: [Item(label: "mobile", value: _phoneNumberController.text)],
                  ));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> saveBill() async {

    final bill = Bill(

      billUid: Uuid().v4(),
      totalBillAmount: double.parse(_totalBillAmountController.text),
      numberOfPeople: double.parse(_totalNumberOfPepoleController.text),
      billPerPerson: double.parse(_splitBillController.text),
      description: _descriptionController.text,
      timestamp: DateTime.now(),
      peopleDetails: _selectedContacts.map((contact) => {
        'name': contact.displayName,
        'phoneNumber': contact.phones!.elementAt(0).value,
        'amount': double.parse(_splitBillController.text),
        'paid':false
      }).toList(),
    );

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('bills')
          .doc(bill.billUid)
          .set(bill.toMap());
    }
  }

  Future<void> savePersonDetails() async {
    for (var contact in _selectedContacts) {
      final person = Person(
        name:contact.displayName?? '',
        phoneNumber: contact.phones!.elementAt(0).value ?? '',
        totalAmountToPay: double.parse(_splitBillController.text),
      );

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final docRef = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('people')
            .doc(person.phoneNumber);

        await docRef.get().then((docSnapshot) => {
          if (docSnapshot.exists) {
            docRef.update({
              'totalAmountToPay': docSnapshot['totalAmountToPay'] + person.totalAmountToPay
            })
          } else {
            docRef.set(person.toMap())
          }
        });
      }
    }
  }


  Future<void> _showWarningDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You have reached the maximum number of people.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showSplitBillDialog(Contact contact, double billPerPerson) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Split Bill Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Total Amount: \$${_totalBillAmountController.text}'),
                Text('Number of People: ${_totalNumberOfPepoleController.text}'),
                Text('Bill per Person: ${_splitBillController.text}'),
                Text('Description: ${_descriptionController.text}'),
                Text('Splited Amoung: '),
                Column(
                  children: _selectedContacts.map((contact) => Text('${contact.displayName}')).toList(),
                )
          ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurpleAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            child: Container(
              padding:
              EdgeInsets.only(top: 20, left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),

              child: Container(
                child: Column(children: [
                  Row(children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade600,
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),

                      ),
                    ),

                  ]),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      // height: 60,
                      padding: EdgeInsets.only(left: 10,top: 10,bottom: 12,right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade600,
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Container(
                        child: Column(
                          children: [
                            Row(

                              children: [
                                Container(
                                  height: 50,
                                  width: 160,
                                  child: TextFormField(
                                    controller: _totalBillAmountController,
                                    style: TextStyle(color: Colors.black),
                                    keyboardType: TextInputType.text,
                                    autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                    decoration:
                                    _buildInputDecoration("Total Amount"),
                                    validator: appValidator.validateUserName,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: 50,
                                  width: 160,
                                  child: TextFormField(
                                    controller: _totalNumberOfPepoleController,
                                    style: TextStyle(color: Colors.black),
                                    keyboardType: TextInputType.text,
                                    autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                    decoration: _buildInputDecoration(
                                        "Number of People"),
                                    validator: appValidator.validateUserName,
                                  ),
                                ),


                            ]),
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 160,
                                  child: TextFormField(
                                    controller: _descriptionController,
                                    style: TextStyle(color: Colors.black),
                                    keyboardType: TextInputType.text,
                                    autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                    decoration: _buildInputDecoration(
                                        "Bill Description"),
                                    validator: appValidator.validateUserName,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: 50,
                                  width: 160,
                                  child: TextFormField(
                                    controller: _splitBillController,
                                    style: TextStyle(color: Colors.black),
                                    keyboardType: TextInputType.text,
                                    decoration: _buildInputDecoration("Bill Per Person"),
                                    readOnly: true,
                                  ),
                                ),
                                SizedBox(height: 40,)
                            ]),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade600,
                                        spreadRadius: 1,
                                        blurRadius: 8,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(onPressed: () {
                                    double splitBill = calculateSplitBill();
                                    setState(() {
                                      _splitBillController.text = splitBill.toStringAsFixed(2);
                                    });
                                  },icon:Tooltip(
                                    message: "Calculate Split Bill",
                                      child: FaIcon(FontAwesomeIcons.calculator,color: Colors.green,))
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade600,
                                        spreadRadius: 1,
                                        blurRadius: 8,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(onPressed: () {
                                    setState(() {
                                      _splitBillController.clear();
                                      _totalBillAmountController.clear();
                                      _totalNumberOfPepoleController.clear();
                                      _descriptionController.clear();
                                    });
                                  },
                                      icon: Tooltip(
                                          message: "Clear Fields",
                                          child: FaIcon(FontAwesomeIcons.deleteLeft,color: Colors.red,))),
                                ),
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade600,
                                        spreadRadius: 1,
                                        blurRadius: 8,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(onPressed: openContactList,
                                      icon: Tooltip(
                                          message: "Open Contact List",
                                          child: FaIcon(FontAwesomeIcons.addressBook,color: Colors.indigoAccent,))
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade600,
                                        spreadRadius: 1,
                                        blurRadius: 8,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(onPressed: (){
                                    setState(() {
                                      _showAddContactDialog();
                                    });
                                  },
                                      icon: Tooltip(
                                          message: "Add Contact",
                                          child: FaIcon(FontAwesomeIcons.personCirclePlus,color: Colors.black54,))
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade600,
                                        spreadRadius: 1,
                                        blurRadius: 8,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(onPressed: (){
                                    setState(() {
                                      _selectedContacts.clear();
                                    });
                                  },
                                      icon: Tooltip(
                                          message: "Remove Contacts",
                                          child: FaIcon(FontAwesomeIcons.remove,color: Colors.amber,))
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade600,
                                        spreadRadius: 1,
                                        blurRadius: 8,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(onPressed: () async {
                                    await saveBill();
                                    await savePersonDetails();
                                  },
                                      icon: Tooltip(
                                          message: "Save Bill",
                                          child: FaIcon(FontAwesomeIcons.paperPlane,color: Colors.blue,))
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade600,
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: ListView.builder(

                      itemCount: _selectedContacts.length,
                      itemBuilder: (context, index) {
                        Contact contact = _selectedContacts[index];
                        double billPerPerson = calculateSplitBill();
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),

                            boxShadow: [
                              BoxShadow(

                                color: Colors.grey.shade600,
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: ListTile(
                           onTap: () {
                        double billPerPerson = calculateSplitBill();
                        _showSplitBillDialog(contact, billPerPerson);
                        },

                            leading: (contact.avatar != null && contact.avatar!.isNotEmpty)
                                ? CircleAvatar(
                              backgroundImage: MemoryImage(contact.avatar!),
                            )
                                : Icon(Icons.account_circle, size: 40.0),
                            title: Text('${contact.displayName}'),
                            subtitle: Container(

                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: ,
                                  children: [
                                    Row(

                                      children: [
                                        Icon(Icons.phone),
                                        Text('${contact.phones!.elementAt(0).value}'),
                                        Spacer(),Spacer(),SizedBox(width: 100,),
                                        IconButton(onPressed: (){
                                          setState(() {
                                            _selectedContacts.removeAt(index);
                                          });
                                        }, icon: Icon(Icons.delete),color: Colors.red,),
                                        Spacer(),
                                        // IconButton(onPressed: (){}, icon: Icon(Icons.))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text('Bill : \$${billPerPerson.toStringAsFixed(2)} /-'),
                                        Spacer(),
                                        IconButton(onPressed: (){}, icon: Icon(Icons.send),color: Colors.blue,)
                                      ],
                                    )
                                  ],
                                )),
                          ),
                        );
                      },
                    ),
                  ),
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }



  InputDecoration _buildInputDecoration(String textlabel) {
    return InputDecoration(
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
      ),
      labelStyle: TextStyle(color: Colors.green),
      labelText: textlabel,
      filled: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
