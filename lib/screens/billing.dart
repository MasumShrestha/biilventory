import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BillingPage extends StatefulWidget {
  const BillingPage({Key? key}) : super(key: key);

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Billing Section' ),backgroundColor: Colors.purple[300]),
      body: Center(child: Text("Here lies the billing format", style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),)),
    );
  }
}
