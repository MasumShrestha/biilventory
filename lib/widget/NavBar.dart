import 'package:flutter/material.dart';
import 'package:loginpage/screens/home.dart';
import 'package:loginpage/screens/newsignin.dart';
import 'package:loginpage/screens/newsignup.dart';

import '../screens/billing.dart';
import '../screens/inventoryDataTable.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        const UserAccountsDrawerHeader(
            // currentAccountPicture: Image.asset('dsad'),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/navbg.png'))),
            accountName: Text(
              'MasumShrestha',
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text('MasumShrestha@gmail.com',
                style: TextStyle(color: Colors.black))),
        ListTile(
          leading: Icon(Icons.home),
          title: Text("Home"),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ));
          },
        ),
        ListTile(
          leading: Icon(Icons.inventory),
          title: Text("Inventory"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => InventoryDataTable(),));
          },
        ),
        ListTile(
          leading: Icon(Icons.receipt),
          title: Text("Billing"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => BillingPage(),));
          },
        ),
        ListTile(
            leading: Icon(Icons.notifications),
            onTap: () {},
            title: Text("Notification"),
            trailing: ClipOval(
                child: Container(
              height: 20,
              width: 20,
              child: Center(
                  child: Text(
                '10',
                style: TextStyle(fontSize: 10),
              )),
              color: Colors.orange,
            ))),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewSignIn(),
                ));
          },
        )
        // onTap: () {},
        // ),
      ]),
    );
  }
}
