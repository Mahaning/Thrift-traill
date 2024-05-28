// BillDetailsPage.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BillDetailsPage extends StatefulWidget {
  final String billId;
  final String userId;
  final String totalBillAmount;
  final String billPerPerson;
  final List<Map<String, dynamic>> peopleDetails;

  BillDetailsPage({
    required this.billId,
    required this.userId,
    required this.totalBillAmount,
    required this.billPerPerson,
    required this.peopleDetails,
  });

  @override
  _BillDetailsPageState createState() => _BillDetailsPageState();
}

class _BillDetailsPageState extends State<BillDetailsPage> {
  List<Map<String, dynamic>> peopleDetails = [];

  @override
  void initState() {
    super.initState();
    peopleDetails = List<Map<String, dynamic>>.from(widget.peopleDetails);
  }

  Future<void> updatePersonPaidStatus(int index) async {
    var person = peopleDetails[index];

    // Update the paid status to true
    person['paid'] = true;

    // Fetch the entire array from Firestore
    final billDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('bills')
        .doc(widget.billId);

    final peopleDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('people')
        .doc(person['phoneNumber']);
    final peopleSnapshot = await peopleDoc.get();
    final billSnapshot = await billDoc.get();
    final List<dynamic> peopleDetailsFromFirestore = billSnapshot.data()?['peopleDetails'];

    // Update the person's details in the fetched array
    peopleDetailsFromFirestore[index] = person;

    // Update the array in Firestore
    await billDoc.update({'peopleDetails': peopleDetailsFromFirestore});

    final totalAmountToPay = peopleSnapshot.data()?['totalAmountToPay'] ?? 0; // Default to 0 if totalAmountToPay is not set
    final amountPaid = person['amount']; // Assuming amount is the amount paid by the person
    final newTotalAmountToPay = totalAmountToPay - amountPaid;
    await peopleDoc.update({'totalAmountToPay': newTotalAmountToPay});


    // Update the UI
    setState(() {
      peopleDetails[index] = person;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill Details'),
      ),
      body: ListView.builder(
        itemCount: peopleDetails.length,
        itemBuilder: (context, index) {
          var person = peopleDetails[index];
          return Card(
            child: Container(
              padding: EdgeInsets.all(10),
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
              child: Row(
                children: [
                  Container(
                      width: 80,
                      child: Icon(Icons.person,color: Colors.deepPurpleAccent,size: 60,)),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: ${person['name']}'),
                        Text('Phone Number: ${person['phoneNumber']}'),
                        Text('Amount: ${person['amount']}'),
                        Row(
                          children: [
                            Text('Paid: ${person['paid'] ? 'Yes' : 'No'}'),
                            // Spacer(),
                            SizedBox(width: 100,),
                            IconButton(
                              onPressed: () => updatePersonPaidStatus(index),
                              icon: Icon(person['paid'] ? Icons.thumb_up : Icons.check, color: person['paid'] ? Colors.green : Colors.red,),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
