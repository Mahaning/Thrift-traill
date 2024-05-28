import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:thrift_till/widgets/auth_gate.dart';


import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized first
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thrift Trail',
      builder: (context,child){
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!);
      },
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
      // home: ToDOList(),
    );
  }
}
