import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:loginpage/screens/updateForm.dart';
import '../functions/EditPage.dart';
import '../functions/salesedit.dart';
import '../main.dart';
import '../widget/searchBar.dart';

final GlobalKey<_SalesInfoState> myWidgetKey = GlobalKey<_SalesInfoState>();

class SalesInfo extends StatefulWidget {
  @override
  _SalesInfoState createState() => _SalesInfoState();
}

class _SalesInfoState extends State<SalesInfo> {
  List<Map<String, dynamic>> _inventoryData = [];
  List<Map<String, dynamic>> _filteredInventoryData = [];
  String searchQuery = '';

  void navigateToEditPage(Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SalesEdit(item: item),
      ),
    ).then((value) {
      if (value == true) {
        fetchInventoryData();
      }
    });
    myWidgetKey.currentState?.build(context);
  }

  void deleteItem(Map<String, dynamic> item) async {
    // String urll = ;

    // final dio = Dio();
    print(item);

    try {
      final response = await Dio().post(
        '$url/delete_sale/',
        data: {
          'id': item['id'], // Assuming there is an 'id' field in the item data
        },
      );
      print(response.data());
      if (response.statusCode == 200) {
        // Item deleted successfully
        // You can update the inventory list or refresh the table
        setState(() {
          _inventoryData.remove(item);
          _filteredInventoryData.remove(item);
        });
        print('Item deleted successfully!');
      } else {
        // Handle other status codes
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle Dio request error
      print('Error: $e');
    }
    setState(() {
      _filteredInventoryData = _filteredInventoryData.where((element) {
        return element['id'] != item['id'];
      }).toList();
    });
  }

  Future<void> fetchInventoryData() async {
    // String urll = ;

    try {
      final response = await Dio().get(
        '$url/sales_list',
        queryParameters: {
          "organization": session['userdata']['organization'],
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _inventoryData = List<Map<String, dynamic>>.from(response.data);
          _filteredInventoryData =
              List<Map<String, dynamic>>.from(response.data);
        });
      } else {
        // Handle other status codes
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle Dio request error
      print('Error: $e');
    }
  }

  void filterInventoryData() {
    setState(() {
      _filteredInventoryData = _inventoryData
          .where((item) =>
              item['company']
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              item['size'].toLowerCase().contains(searchQuery.toLowerCase()) ||
              item['customername']
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              item['productname']
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchInventoryData();
  }

  @override
  void didUpdateWidget(covariant SalesInfo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_inventoryData.isEmpty) {
      fetchInventoryData();
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Record'),
        backgroundColor: Colors.purple[300],
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: axisDirectionToAxis(AxisDirection.left),
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: Platform.isWindows
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 0.4 * w),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                              filterInventoryData();
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Search',
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Customer Name')),
                      DataColumn(label: Text('Company')),
                      DataColumn(label: Text('Product Name')),
                      DataColumn(label: Text('Size')),
                      DataColumn(label: Text('Cost Price')),
                      DataColumn(label: Text('Selling Price')),
                      DataColumn(label: Text('Discount')),
                      DataColumn(label: Text('Quantity')),
                      DataColumn(label: Text('Date')),
                      if (session['userdata']['accounttype'] == "Admin")
                        DataColumn(label: Text('Actions')),
                    ],
                    rows: _filteredInventoryData.map((item) {
                      return DataRow(cells: [
                        DataCell(Text(item['customername'])),
                        DataCell(Text(item['company'])),
                        DataCell(Text(item['productname'])),
                        DataCell(Text(item['size'].toString())),
                        DataCell(Text(item['cp'].toString())),
                        DataCell(Text(item['sp'].toString())),
                        DataCell(Text(item['discount'].toString())),
                        DataCell(Text(item['quantity'].toString())),
                        DataCell(Text(item['created_at'].toString())),
                        if (session['userdata']['accounttype'] == "Admin")
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    navigateToEditPage(item);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Confirmation'),
                                        content: const Text(
                                            'Are you sure you want to delete this item?'),
                                        actions: [
                                          TextButton(
                                            child: const Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('Delete'),
                                            onPressed: () {
                                              deleteItem(item);
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                      ]);
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
