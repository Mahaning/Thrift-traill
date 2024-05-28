import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeroCard extends StatelessWidget {
    HeroCard({
    super.key, required this.userId,
  });

   final String userId;


  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> _usersStream =
    FirebaseFirestore.instance.collection('users').doc(userId).snapshots();
    return StreamBuilder<DocumentSnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if(!snapshot.hasData || !snapshot.data!.exists){
          return const Text("Document dosen't Exist");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        var data=snapshot.data!.data() as Map<String, dynamic>;


        return Cards(data:data,);
      },
    );
  }
}

class Cards extends StatelessWidget {
  const Cards({
    super.key, required this.data,
  });

  final Map data;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurpleAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Balance",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Text(
                  "₹ ${data['remainingAmount']}",
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top:30,bottom:10,left: 10,right: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
            ),
            child: Row(
                children: [
                  CardOne(color: Colors.green, heading: 'Credit', amount: "${data['totalCredit']}",),
                  SizedBox(
                    width: 10,
                  ),
                  CardOne(color: Colors.red, heading: 'Debit', amount: "${data['totalDebit']}",)
                ]


            ),
          )
        ],
      ),
    );
  }
}

class CardOne extends StatelessWidget{
  const CardOne({super.key, required this.color, required this.heading, required this.amount});
  final Color color;
  final String heading;
  final String amount;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade600,
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 1),
            ),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(heading,style: TextStyle(color: color,fontSize: 14),),
                  Text("₹ ${amount}",style: TextStyle(color: color,fontSize: 30,fontWeight: FontWeight.w600),)
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  heading=="Credit"?
                  Icons.arrow_upward_outlined:Icons.arrow_downward_outlined,
                  color: color,),
              )
            ],

          ),
        ),
      ),);
  }
}

