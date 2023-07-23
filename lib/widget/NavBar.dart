// import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/screens/home.dart';
import 'package:loginpage/screens/newsignin.dart';
import 'package:loginpage/screens/notification.dart';
import 'package:loginpage/screens/salesdata.dart';
import 'package:loginpage/screens/salesdata2.dart';
import '../main.dart';
import '../screens/billing.dart';
import '../screens/inventory.dart';
import '../screens/loginuser.dart';
import '../screens/salesrecord.dart';
import '../screens/salesrecord2.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String companyName = session['userdata']['organization'];
    String currentEmail = session['userdata']['email'];

    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        UserAccountsDrawerHeader(
            // currentAccountPicture: Image.asset('dsad'),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/navbg.png'))),
            accountName: Text(
              companyName,
              style: TextStyle(color: Colors.black),
            ),
            accountEmail:
                Text(currentEmail, style: TextStyle(color: Colors.black))),
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
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InventoryPage(),
                ));
          },
        ),
        ListTile(
          leading: Icon(Icons.receipt),
          title: Text("Billing"),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BillingPage(),
                ));
          },
        ),
        ListTile(
            leading: Icon(Icons.notifications),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Notificationn()));
            },
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
          leading: Icon(Icons.insert_drive_file_rounded),
          title: Text('Sales Report'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SalesRecord(),
                ));
          },
        ),
        if (session['userdata']['accounttype'] == "Admin")
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Create Account'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginUser(),
                  ));
            },
          ),
        ListTile(
          leading: Icon(Icons.insert_drive_file_rounded),
          title: Text('Sales Record'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SalesInfo(),
                ));
          },
        ),
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
        ),
        // onTap: () {},
        // ),
      ]),
    );
  }
}
