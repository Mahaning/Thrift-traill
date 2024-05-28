import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thrift_till/widgets/transaction_card.dart';

class FriendList extends StatefulWidget {
  FriendList({Key? key});

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection("people")
          // .orderBy("timestamp", descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No People Found"));
        }

        var data = snapshot.data!.docs;

        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            var person = data[index];

            return GestureDetector(
              onTap: () {
                // Implement onTap logic
              },
              child: Card(
                child: ListTile(
                  title: Container(
                      width:60,
                      child: Row(
                        children: [
                          SizedBox(width: 60,),
                          Text('Name:${person['name'] ?? ''}'),
                        ],
                      )),

                  subtitle: Row(
                    children: [
                      Container(
                        width: 60,
                          // color: Colors.blue,

                          child: Icon(Icons.person,color: Colors.yellow.shade900,)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text('Contact No:${person['phoneNumber'] ?? ''}'),
                          Text('Total Remaining Amount:${person['totalAmountToPay'] ?? ''}'),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      await person.reference.delete();
                    },
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
