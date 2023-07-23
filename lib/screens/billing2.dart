import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:loginpage/screens/updateForm.dart';
import '../functions/EditPage.dart';
import '../main.dart';
import '../widget/searchBar.dart';

class BillingSearch extends StatefulWidget {
  BillingSearch({super.key, required this.ontap});

  void Function(Map) ontap;

  @override
  _BillingSearchState createState() => _BillingSearchState();
}

class _BillingSearchState extends State<BillingSearch> {
  List<Map<String, dynamic>> _inventoryData = [];
  List<Map<String, dynamic>> _filteredInventoryData = [];
  String searchQuery = '';

  void navigateToEditPage(Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPage(item: item),
      ),
    ).then((value) {
      if (value == true) {
        fetchInventoryData();
      }
    });
  }

  void deleteItem(Map<String, dynamic> item) async {
    // String urll = ;

    // final dio = Dio();
    print(item);

    try {
      final response = await Dio().post(
        '$url/delete_inventory/',
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
        return element != item;
      }).toList();
    });
  }

  Future<void> fetchInventoryData() async {
    // String urll = ;

    try {
      final response = await Dio().get(
        '$url/get_inventory',
        queryParameters: {
          "organization": session['userdata']['organization'],
        },
      );

      if (response.statusCode == 200) {
        print(response.data);
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
              item['suppliers']
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
  void didUpdateWidget(covariant BillingSearch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_inventoryData.isEmpty) {
      fetchInventoryData();
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: Platform.isWindows
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: axisDirectionToAxis(AxisDirection.right),
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
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('Actions')),
              DataColumn(label: Text('Company')),
              DataColumn(label: Text('Product Name')),
              DataColumn(label: Text('Quantity')),
              DataColumn(label: Text('Size')),
              DataColumn(label: Text('Cost Price')),
              DataColumn(label: Text('Selling Price')),
              DataColumn(label: Text('Discount')),
              DataColumn(label: Text('Suppliers')),
              // if (session['userdata']['accounttype'] == "Admin")
            ],
            rows: _filteredInventoryData.map((item) {
              return DataRow(cells: [
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          widget.ontap(item);
                        },
                      ),
                    ],
                  ),
                ),
                DataCell(Text(item['company'])),
                DataCell(Text(item['productname'])),
                DataCell(Text(item['quantity'].toString())),
                DataCell(Text(item['size'].toString())),
                DataCell(Text(item['cp'].toString())),
                DataCell(Text(item['sp'].toString())),
                DataCell(Text(item['discount'].toString())),
                // if (session['userdata']['accounttype'] == "Admin")
                DataCell(Text(item['suppliers'])),
              ]);
            }).toList(),
          ),
        ),
      ],
    );
  }
}
