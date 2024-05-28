import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thrift_till/screens/splitBill.dart';
import 'package:thrift_till/screens/to_do_list.dart';
import 'package:thrift_till/screens/transactions.dart';

import '../widgets/add_transaction_form.dart';
import '../widgets/navBar.dart';
// import 'ackage:triftt_trill/screens/homescreen.dart';
import 'homescreen.dart';
import 'login.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  var isLogoutoading=false;
  int currentIndex=0;
  var pageViewList=[
    HomeScreen(),
    TransactionsScreen(),
    AddTransactionsForm(),
    ToDOList(),
    SplitBill(),

  ];
  logout() async {
    setState(() {
      isLogoutoading=true;
    });
    await FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginView(),
      ),
    );
    setState(() {
      isLogoutoading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(selectedIndex: currentIndex, onDestinationSelected: (int value) {
        setState(() {
          currentIndex=value;
        });
      },),

      body: pageViewList[currentIndex],
    );
  }
}
