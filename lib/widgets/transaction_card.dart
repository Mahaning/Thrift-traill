import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../utils/icons_list.dart';

class TransactionCard extends StatelessWidget {
  TransactionCard({
    super.key, required this.data,
    // required this.appIcon,
  });
  final dynamic data;
  var appIcon=AppIcons();

  @override
  Widget build(BuildContext context) {
    DateTime date=DateTime.fromMillisecondsSinceEpoch(data['timestamp']);
    String formatedDate=DateFormat('d MMM y  hh:mma').format(date);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow:[
              BoxShadow(
                offset: Offset(0,10),
                color: Colors.grey.withOpacity(0.09),
                // blurRadius: 10,
                spreadRadius: 4.0,)
            ]),
        child: ListTile(
          minVerticalPadding: 10,
          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),

          leading: Container(
            child: Container(
              width: 70,
              height: 100,


              child: Container(

                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),

                  color: data['type']=="credit" ? Colors.green.withOpacity(0.3):Colors.red.withOpacity(0.3),),
                child: Center(child: FaIcon(appIcon.getexpenseCategoryIcons('${data['category']}'),color: data['type']=="credit" ? Colors.green:Colors.red,)),
              ),
            ),
          ),
          title: Row(
            children: [
              Expanded(child: Text("${data['title']} ${data['monthyear']}",style: TextStyle(),)),
              Text("₹ ${data['amount']}",style: TextStyle(color: data['type']=="credit" ? Colors.green:Colors.red),)
            ],
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Balance",style: TextStyle(color: Colors.grey,fontSize: 13),),
                  Spacer(),
                  Text("₹ ${data['remainingAmount']}",style: TextStyle(color: Colors.grey,fontSize: 13),)
                ],
              ),
              Text(formatedDate,style: TextStyle(color: Colors.grey),),
            ],),
        ),
      ),
    );
  }
}