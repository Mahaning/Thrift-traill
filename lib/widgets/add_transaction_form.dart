import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/appValidator.dart';
import 'category_dropdown.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class AddTransactionsForm extends StatefulWidget {
  const AddTransactionsForm({Key? key});

  @override
  State<AddTransactionsForm> createState() => _AddTransactionsFormState();
}

class _AddTransactionsFormState extends State<AddTransactionsForm> {
  var type = "credit";
  var category = "Others";
  var isLoader = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var appValidator = AppValidator();
  var amountEditController = TextEditingController();
  var titleEditController = TextEditingController();
  var uid = Uuid();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });

      final user = FirebaseAuth.instance.currentUser;
      int timestamp=DateTime.now().millisecondsSinceEpoch;
      var amount=int.parse(amountEditController.text);
      DateTime date=DateTime.now();
      // Your logic for adding transaction here...

      var id=uid.v4();
      String monthyear=DateFormat('MMM y').format(date);
      final userDoc= await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
      int remainingAmount=userDoc['remainingAmount'];
      int totalCredit=userDoc['totalCredit'];
      int totalDebit=userDoc['totalDebit'];

      if(type =='credit'){
          remainingAmount+=amount;
          totalCredit+=amount;
      }else{
        remainingAmount-=amount;
        totalDebit+=amount;
      }
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
        "remainingAmount":remainingAmount,
        "totalCredit":totalCredit,
        "totalDebit":totalDebit,
        "updatedAt":timestamp
      });
      var data={
        "id":id,
        "title":titleEditController.text,
        "amount":amount,
        "type":type,
        "timestamp":timestamp,
        "remainingAmount":remainingAmount,
        "totalCredit":totalCredit,
        "totalDebit":totalDebit,
        "monthyear":monthyear,
        "category":category,
      };
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).collection("transactions").doc(id).set(data);
      Navigator.pop(context);
      setState(() {
        isLoader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: titleEditController,
              validator: appValidator.isEmptyCheck,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextFormField(
              controller: amountEditController,
              validator: appValidator.isEmptyCheck,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            CategoryDropDown(
              cattype: category,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    category = value;
                  });
                }
              },
            ),
            DropdownButtonFormField(
              value: 'credit',
              items: [
                DropdownMenuItem(child: Text("Credit"), value: 'credit'),
                DropdownMenuItem(child: Text("Debit"), value: 'debit'),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    type = value.toString();
                  });
                }
              },
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                if (!isLoader) {
                  _submitForm();
                }
              },
              child: isLoader
                  ? Center(child: CircularProgressIndicator())
                  : Text("Add Transaction"),
            ),
          ],
        ),
      ),
    );
  }
}
