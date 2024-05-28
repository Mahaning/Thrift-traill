

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:thrift_till/screens/dashboard.dart';

import '../screens/login.dart';
import 'db.dart';

class AuthService {
  var db=Db();
  Future<void> createUser(Map<String, dynamic> data, BuildContext context ) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data['email'], // Access email from data map
        password: data['password'],
      );
      await db.addUser(data, context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginView(),
        ),
      );
      // Now you can store additional user data in Firestore or any other database
    } catch (e) {
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text("Sign Up Failed"),
          content: Text(e.toString()),
        );

      });
      throw e; // Re-throw the exception to handle it in the UI if needed
    }
  }


  Future<void> login(Map<String, dynamic> data, BuildContext context ) async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data['email'], // Access email from data map
        password: data['password'],
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => dashboard(),
        ),
      );
    }catch(e){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text("Log In Failed"),
          content: Text(e.toString()),
        );
      });
      throw e;
    }
  }
  logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
