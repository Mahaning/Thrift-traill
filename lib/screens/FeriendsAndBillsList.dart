import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thrift_till/widgets/category_list.dart';

import '../widgets/friens_and_bills_tabs.dart';
import '../widgets/tab_bar_veiw.dart';
import '../widgets/time_line_month.dart';

class FriendsAndBills extends StatefulWidget {
  FriendsAndBills({Key? key}) : super(key: key);

  @override
  _FriendsAndBillsState createState() => _FriendsAndBillsState();
}

class _FriendsAndBillsState extends State<FriendsAndBills> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Freind and Bills",style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          FreindsAndBillsTabBar(),
        ],
      ),
    );
  }
}
