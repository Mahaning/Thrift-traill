import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thrift_till/widgets/transaction_list.dart';

import 'BillList.dart';
import 'FriendList.dart';


class FreindsAndBillsTabBar extends StatelessWidget {
  const FreindsAndBillsTabBar({super.key,});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(tabs: [
              Tab(text: "Bills",),
              Tab(text: "Friends",)
            ]),
            Expanded(
                child: TabBarView(
                  children: [
                    BillsList(),
                    FriendList(),
                  ],))
          ],)
    ));
  }
}
