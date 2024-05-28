import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/add_transaction_form.dart';
import '../widgets/bill_Split_Card.dart';
import '../widgets/hero_card.dart';
import '../widgets/transactions_card.dart';
import 'FeriendsAndBillsList.dart';
import 'login.dart';
// ignore_for_file:
class SplitBill extends StatefulWidget {
  const SplitBill({Key? key}) : super(key: key);

  @override
  State<SplitBill> createState() => _SplitBillState();
}

class _SplitBillState extends State<SplitBill> {
  bool isLogoutLoading = false;

  Future<void> logout() async {
    setState(() {
      isLogoutLoading = true;
    });

    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginView(),
      ),
    );
    setState(() {
      isLogoutLoading = false;
    });
  }

  final userId=FirebaseAuth.instance.currentUser!.uid;
  _dailoBuilder(BuildContext context){
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: AddTransactionsForm(),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: ((){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FriendsAndBills(),
            ),
          );
        }),backgroundColor: Colors.deepPurpleAccent,
          child: Icon(Icons.list,color: Colors.white,),
        ),
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text("Split The Bill ",style: TextStyle(color:Colors.white,fontWeight:FontWeight.w800,fontSize: 40),),
          actions: [
            IconButton(
              onPressed: () {
                logout();
              },
              icon: isLogoutLoading
                  ? CircularProgressIndicator()
                  : Icon(Icons.exit_to_app, color: Colors.white),
            ),
          ],
        ),
        body: SingleChildScrollView(

          child: Column(
            children: [
              SplitBillCard(userId: userId,),
            ],
          ),
        )
    );
  }
}


