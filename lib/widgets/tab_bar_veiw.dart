import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thrift_till/widgets/transaction_list.dart';


class TypeTabBar extends StatelessWidget {
  const TypeTabBar({super.key, required this.category, required this.monthyear});

  final String category;
  final String monthyear;
  @override
  Widget build(BuildContext context) {
    return Expanded(child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(tabs: [
              Tab(text: "Credit",),
              Tab(text: "Debit",)
            ]),
            Expanded(
                child: TabBarView(
                  children: [
                    TransactionList(category: category, type: 'credit', monthyear: monthyear,),
                    TransactionList(category: category, type: 'debit', monthyear: monthyear,),
            ],))
          ],)
    ));
  }
}
