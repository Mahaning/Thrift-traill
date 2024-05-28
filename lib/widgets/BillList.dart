import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'BillDetailsPage.dart';

class BillsList extends StatefulWidget {
  BillsList({Key? key});

  @override
  State<BillsList> createState() => _BillsListState();
}

class _BillsListState extends State<BillsList> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection("bills")
        .orderBy("timestamp", descending: true);

    return FutureBuilder<QuerySnapshot>(
      future: query.limit(150).get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No Bills Found"));
        }

        var data = snapshot.data!.docs;

        return Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var bill = data[index];
              var peopleDetails = List<Map<String, dynamic>>.from(bill['peopleDetails'] ?? []);
              return GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BillDetailsPage(
                        billId: bill.id,
                        userId: userId,
                        totalBillAmount: bill['totalBillAmount'].toString(),
                        billPerPerson: bill['billPerPerson'].toString(),
                        peopleDetails: peopleDetails,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
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
                  child: Card(
                    color: Colors.yellow.shade50,
                    child: ListTile(
                      title: Text("Total Bill: Rs. ${bill['totalBillAmount']}/-"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Bill ID: ${bill.id}"),
                          Text("Bill Per Person: ${bill['billPerPerson']}"),
                          Text("Created : ${bill['timestamp'].toDate()}"),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}