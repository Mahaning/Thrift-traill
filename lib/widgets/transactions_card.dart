import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thrift_till/widgets/transaction_card.dart';
import 'package:thrift_till/utils/icons_list.dart';
import 'package:thrift_till/widgets/transaction_card.dart';

class TransactionsCard extends StatelessWidget {
   TransactionsCard({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(

      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [

                  Text("Recent Transactions",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
                  )
                ],
              ),
              RecentTransactionLists()
            ],
          ),
      ),
    );

  }
}

class RecentTransactionLists extends StatelessWidget {
   RecentTransactionLists({
    super.key,
  });
  final userId=FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(userId).collection("transactions").orderBy("timestamp",descending: true).limit(10).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }else if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
            return const Center(child: Text("No Transaction Found"),);
          }
          var data=snapshot.data!.docs;
          // return );


          return Container(

            child: Flexible(
              child: ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var cardData=data[index];
                    return Container(

                        child: TransactionCard(data: cardData,));
                  }),
            ),
          );
        });
    }
}


