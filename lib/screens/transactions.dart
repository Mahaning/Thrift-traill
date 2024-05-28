import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thrift_till/widgets/category_list.dart';

import '../widgets/tab_bar_veiw.dart';
import '../widgets/time_line_month.dart';

class TransactionsScreen extends StatefulWidget {
  TransactionsScreen({Key? key}) : super(key: key);

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  late String category = "All";
  late String monthyear;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    monthyear = DateFormat('MMM y').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses"),
      ),
      body: Column(
        children: [
          TimeLineMonth(
            onChanged: (String? value) {
              if (value != null) {
                setState(() {
                  monthyear = value;
                });
              }
            },
          ),
          CategoryList(
            onChanged: (String? value) {
              if (value != null) {
                setState(() {
                  category = value;
                });
              }
            },
          ),
          TypeTabBar(category: category, monthyear: monthyear),
        ],
      ),
    );
  }
}
