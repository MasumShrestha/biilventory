import 'package:flutter/material.dart';
import 'package:loginpage/screens/home.dart';
import 'package:loginpage/screens/newsignin.dart';
import 'package:loginpage/screens/newsignup.dart';
import 'package:loginpage/screens/signin.dart';
import 'package:loginpage/screens/signup.dart';
// import 'package:loginpage/screens/signin.dart';

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
