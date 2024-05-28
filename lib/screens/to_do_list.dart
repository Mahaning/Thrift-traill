import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/add_task_form.dart';

class ToDOList extends StatefulWidget {
  const ToDOList({Key? key});

  @override
  State<ToDOList> createState() => _ToDOListState();
}

class _ToDOListState extends State<ToDOList> {
  @override
  Widget build(BuildContext context) {
    final String userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Tasks ",style: TextStyle(color: Colors.white,fontSize:25,fontWeight: FontWeight.w600 ),),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection("toDoListTasks")
            .orderBy("timestamp", descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No tasks found"));
          }

          
          return Container(
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot document = snapshot.data!.docs[index];
                final taskData = document.data() as Map<String, dynamic>;
                DateTime date = DateTime.fromMillisecondsSinceEpoch(taskData['timestamp']);
                String formattedDate = DateFormat('d MMM y  hh:mma').format(date);
                return GestureDetector(
                  onTap: () {
                    _showTaskDetails(context, taskData);
                  },
                  child: Card(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    margin: EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade600,
                            spreadRadius: 1,
                            blurRadius: 15,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text("${taskData['title']}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Created: $formattedDate'),
                            Text(
                              taskData['completedDate'] != null
                                  ? 'Completed: ${DateFormat('d MMM y  hh:mma').format(DateTime.fromMillisecondsSinceEpoch(taskData['completedDate']))}'
                                  : 'Completed: Pending',
                            ),
                            Row(
                              children: [
                                Text(
                                  taskData['isCompleted'] == true ? "Status: Completed" : "Status: Pending",
                                  style: TextStyle(color: taskData['isCompleted'] == true ? Colors.green : Colors.amber),
                                ),
                                Spacer(),
                                _buildPriorityContainer(taskData['priority']),

                              ],

                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Spacer(),
                                if (taskData['isCompleted'] != true)
                                  Container(
                                    width: 80,
                                    height: 40,
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


                                    child: IconButton(
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.green,
                                        side: const BorderSide(color: Colors.green, width: 2),
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      ),

                                      onPressed: () {
                                        int completedDate = DateTime.now().millisecondsSinceEpoch;
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(userId)
                                            .collection("toDoListTasks")
                                            .doc(document.id)
                                            .update({
                                          'isCompleted': true,
                                          'completedDate': completedDate,
                                        })
                                            .then((value) {
                                          print('Task marked as completed');
                                        })
                                            .catchError((error) {
                                          print('Failed to mark task as completed: $error');
                                        });
                                      },
                                      icon: Icon(Icons.check),
                                    ),
                                  ),
                                Spacer(),
                                Container(
                                  width: 80,
                                  height: 40,
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
                                  child: IconButton(
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.yellow,
                                      side: const BorderSide(color: Colors.yellow, width: 2),
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    ),
                                    onPressed: () {
                                      _editTask(context, document, userId);
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: 80,
                                  height: 40,
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
                                  child: IconButton(
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.red,
                                      side: const BorderSide(color: Colors.red, width: 2),
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    ),
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(userId)
                                          .collection("toDoListTasks")
                                          .doc(document.id)
                                          .delete()
                                          .then((value) {
                                        print('Task deleted successfully');
                                      })
                                          .catchError((error) {
                                        print('Failed to delete task: $error');
                                      });
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _dailoBuilder(context);
        },
        child: Icon(Icons.add_task),
      ),
    );
  }

  Widget _buildPriorityContainer(String priority) {
    BorderRadius borderRadius = BorderRadius.circular(10);
    Color color;
    if (priority.toLowerCase() == 'high') {
      color = Colors.red;
    } else if (priority.toLowerCase() == 'medium') {
      color = Colors.yellow.shade700;
    } else if (priority.toLowerCase() == 'low') {
      color = Colors.green;
    } else {
      color = Colors.transparent; // Default color
    }

    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(

        borderRadius: borderRadius,
      ),
      child: Text("Priority: $priority",style: TextStyle(color: color,),),
      
    );
  }

  void _dailoBuilder(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: AddTaskForm(),

        );
      },
    );
  }

  void _showTaskDetails(BuildContext context, taskData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(taskData['title']),
          content: Text(taskData['description']),
          actions: [
            TextButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blueAccent,
                side: const BorderSide(color: Colors.blueAccent, width: 2),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
          backgroundColor: Colors.white,

        );
      },
    );
  }

  void _editTask(BuildContext context, DocumentSnapshot document, String userId) {
    TextEditingController titleController = TextEditingController(text: document['title']);
    TextEditingController descriptionController = TextEditingController(text: document['description']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String newTitle = titleController.text;
                String newDescription = descriptionController.text;

                FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .collection("toDoListTasks")
                    .doc(document.id)
                    .update({
                  'title': newTitle,
                  'description': newDescription,
                })
                    .then((value) {
                  print('Task updated successfully');
                  Navigator.pop(context);
                })
                    .catchError((error) {
                  print('Failed to update task: $error');
                });
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
