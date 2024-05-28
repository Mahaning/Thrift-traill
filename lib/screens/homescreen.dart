import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/add_transaction_form.dart';
import '../widgets/hero_card.dart';
import '../widgets/transactions_card.dart';
import 'login.dart';
// ignore_for_file:
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        _dailoBuilder(context);
      }),backgroundColor: Colors.deepPurpleAccent,
      child: Icon(Icons.add,color: Colors.white,),
      ),
      appBar: AppBar(

        backgroundColor: Colors.deepPurpleAccent,

        title: Text("Hello "),
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
      body: Container(

        child: Column(
          children: [
            HeroCard(userId: userId,),
            SizedBox(
              height: 20,
            ),
            Expanded( // Add this
              child: TransactionsCard(),
            ),
            SizedBox(
              height: 20,
            ),

          ],
        ),
      )
          );
  }
}


