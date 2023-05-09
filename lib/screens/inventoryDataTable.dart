
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/inventorytable.dart';
import '../widget/searchBar.dart';

class InventoryDataTable extends StatelessWidget {
  const InventoryDataTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  SearchBar(),
      backgroundColor: Colors.purple[300],
      centerTitle: true,),
      body: const InventoryTable(),
      // Center(child: Text('Table', style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),))
    );
  }

}
