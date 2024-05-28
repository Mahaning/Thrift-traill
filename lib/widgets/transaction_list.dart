import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:thrift_till/widgets/transaction_card.dart';


class TransactionList extends StatelessWidget {
   TransactionList({super.key, required this.category, required this.type, required this.monthyear});

  final userId=FirebaseAuth.instance.currentUser!.uid;
  final String category;
  final String type;
  final String monthyear;

  @override
  Widget build(BuildContext context) {
    Query query=FirebaseFirestore.
    instance.collection('users').
    doc(userId).collection("transactions")
        .orderBy("timestamp",descending: true)
        .where("monthyear",isEqualTo: monthyear)
    .where("type",isEqualTo: type);

    if(category!='All'){
        query=query.where('category',isEqualTo: category);
    }
    return FutureBuilder<QuerySnapshot>(
        future: query.limit(150).get(),
        // stream: FirebaseFirestore.instance.collection('users').doc(userId).collection("transactions").orderBy("timestamp",descending: true).limit(10).snapshots(),
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


          // return Flexible(

          return  ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var cardData=data[index];
                  return TransactionCard(data: cardData,);
                });
          // );
        });
  }
}
