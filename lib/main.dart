import 'package:flutter/material.dart';
import 'package:loginpage/screens/newsignin.dart';

// import 'package:loginpage/screens/signin.dart';
String url = 'http://192.168.1.72:8000';
// String url='http://127.0.0.1:8000 ';

late Map<String, dynamic> session;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewSignIn(),
    );
  }
}
