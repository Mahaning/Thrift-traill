import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thrift_till/widgets/to_do_task_dropdown.dart';
// import 'package:thrift_till/widgets/to_do_task_dropdown.dart';


import '../utils/appValidator.dart';
import 'category_dropdown.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({Key? key});

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  var priority = "high";
  var category = "Genral";
  var isLoader = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var appValidator = AppValidator();
  var descriptionEditController = TextEditingController();
  var titleEditController = TextEditingController();
  var uid = Uuid();
  var isCompleted=false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });

      final user = FirebaseAuth.instance.currentUser;
      int timestamp=DateTime.now().millisecondsSinceEpoch;
      var description=descriptionEditController.text;
      DateTime date=DateTime.now();
      // Your logic for adding transaction here...

      var id=uid.v4();
      String monthyear=DateFormat('MMM y').format(date);
      final userDoc= await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

      // await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      //   // "remainingAmount":remainingAmount,
      //   // "totalCredit":totalCredit,
      //   // "totalDebit":totalDebit,
      //   "updatedAt":timestamp
      // });
      var data={
        "id":id,
        "title":titleEditController.text,
        "description":description,
        "priority":priority,
        "timestamp":timestamp,
        "monthyear":monthyear,
        "category":category,
        "isCompleted":isCompleted,
      };
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).collection("toDoListTasks").doc(id).set(data);
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
                labelText: 'Task Title',
              ),
            ),
            TextFormField(

              controller: descriptionEditController,
              validator: appValidator.isEmptyCheck,
              keyboardType: TextInputType.multiline,
              // expands: true,
              decoration: InputDecoration(labelText: 'Task Description',),
            ),
            TaskCategoryDropDown(
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
              value: 'medium',
              items: [
                DropdownMenuItem(child: Text("High"), value: 'high'),
                DropdownMenuItem(child: Text("Medium"), value: 'medium'),
                DropdownMenuItem(child: Text("Low"), value: 'low'),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    priority = value.toString();
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
                  : Text("Add Task"),
            ),
          ],
        ),
      ),
    );
  }
}
