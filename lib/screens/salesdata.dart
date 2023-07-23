import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:loginpage/main.dart';

class Sale {
  final int id; // Add the id property
  final String customerName;
  final String company;
  final String productName;
  final String size;
  final double sp;
  final double cp;
  final double discount;
  final int quantity;
  final DateTime createdAt;

  Sale({
    required this.id, // Include the id in the constructor
    required this.customerName,
    required this.company,
    required this.productName,
    required this.size,
    required this.sp,
    required this.cp,
    required this.discount,
    required this.quantity,
    required this.createdAt,
  });
}

class SaleTableScreen extends StatefulWidget {
  @override
  _SaleTableScreenState createState() => _SaleTableScreenState();
}

class _SaleTableScreenState extends State<SaleTableScreen> {
  List<Sale> sales = [];
  List<Sale> filteredSales = [];

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchSalesData();
  }

  void fetchSalesData() async {
    try {
      final response = await Dio().get('$url/sales');
      final data = response.data;
      print(data);
      List<Sale> fetchedSales = [];

      for (var saleData in data) {
        final sale = Sale(
          id: saleData['id'], // Assign the id property
          customerName: saleData['customername'],
          company: saleData['company'],
          productName: saleData['productname'],
          size: saleData['size'],
          sp: double.parse(saleData['sp'].toString()),
          cp: double.parse(saleData['cp'].toString()),
          discount: double.parse(saleData['discount'].toString()),
          quantity: saleData['quantity'],
          createdAt: DateTime.parse(saleData['created_at']),
        );

        fetchedSales.add(sale);
      }

      setState(() {
        sales = fetchedSales;
        filteredSales = fetchedSales;
      });
    } catch (error) {
      // Handle error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch sales data. Please try again.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void filterSales(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredSales = sales.where((sale) {
          final String lowerCaseQuery = query.toLowerCase();
          return sale.customerName.toLowerCase().contains(lowerCaseQuery) ||
              sale.company.toLowerCase().contains(lowerCaseQuery) ||
              sale.productName.toLowerCase().contains(lowerCaseQuery) ||
              sale.size.toLowerCase().contains(lowerCaseQuery);
        }).toList();
      } else {
        filteredSales = sales;
      }
    });
  }

  void deleteSale(int saleId) async {
    try {
      final response = await Dio().delete('$url/sales/$saleId');

      if (response.statusCode == 200) {
        setState(() {
          sales.removeWhere((sale) => sale.id == saleId);
          filteredSales.removeWhere((sale) => sale.id == saleId);
        });
      }
    } catch (error) {
      // Handle error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content:
                Text('Failed to delete the sales record. Please try again.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: filterSales,
              decoration: InputDecoration(
                labelText: 'Search',
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Customer Name')),
                  DataColumn(label: Text('Company')),
                  DataColumn(label: Text('Product Name')),
                  DataColumn(label: Text('Size')),
                  DataColumn(label: Text('SP')),
                  DataColumn(label: Text('CP')),
                  DataColumn(label: Text('Discount')),
                  DataColumn(label: Text('Quantity')),
                  DataColumn(label: Text('Created At')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: filteredSales.map((sale) {
                  return DataRow(cells: [
                    DataCell(Text(sale.customerName)),
                    DataCell(Text(sale.company)),
                    DataCell(Text(sale.productName)),
                    DataCell(Text(sale.size)),
                    DataCell(Text(sale.sp.toString())),
                    DataCell(Text(sale.cp.toString())),
                    DataCell(Text(sale.discount.toString())),
                    DataCell(Text(sale.quantity.toString())),
                    DataCell(Text(sale.createdAt.toString())),
                    DataCell(Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Implement edit action
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteSale(sale.id),
                        ),
                      ],
                    )),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
