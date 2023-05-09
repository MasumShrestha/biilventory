import 'package:flutter/material.dart';

import '../widget/NavBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        title: const Center(child: Text('Billventory')),
      ),
      drawer: const NavBar(),
      body: Container(
        child: Center(child: Text('Welcome', style: TextStyle(fontSize: 30))),
      ),

      // endDrawer:Directionality(textDirection: TextDirection.rtl,
      //     child: Drawer(
      //     )) ,
    );
  }
}
