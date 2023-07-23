import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:loginpage/screens/billing2.dart';
import 'package:loginpage/widget/Textfield.dart';
import 'dart:convert';
import 'dart:core';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../main.dart';

class BillingPage extends StatefulWidget {
  @override
  _BillingPageState createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  TextEditingController searchController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  TextEditingController custommername = TextEditingController();

  String discountAmount = '0';
  List<dynamic> searchResults = [];
  List<dynamic> selectedProducts = [];

  // Future<void> searchProducts() async {
  //   final dio = Dio();
  //   try {
  //     final response =
  //         await dio.get('$url/search?product=${searchController.text}');
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         searchResults = jsonDecode(response.data);
  //       });
  //     }
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }

  void addToCart(Map product) {
    List idmap = selectedProducts
        .map(
          (e) => e['id'],
        )
        .toList();
    setState(() {
      if (!idmap.contains(product['id'])) {
        selectedProducts.add({
          ...product,
          "quantity": 0,
        });
      }
    });
  }

  double calculateTotalAmount() {
    List<dynamic> values = selectedProducts.map((e) {
      return {
        'sp': double.parse(e['sp']),
        'discount': double.parse(e['discount']),
        'quantity': e['quantity'],
      };
    }).toList();
    double total = 0;
    for (var value in values) {
      total +=
          (value['sp'] * value['quantity'] * (1 - value['discount'] / 100));
    }
    return total;
  }

  void _printDialogContents(BuildContext context) async {
    String name = custommername.text;
    DateTime now = DateTime.now();
    String formattedDate = '${now.day}-${now.month}-${now.year}';

    final products = selectedProducts;

    // Create a PDF document
    final pdf = pw.Document();

    // Add content to the PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Container(
                  child: pw.Column(
                    children: [
                      pw.Text(
                        session['userdata']['organization'],
                        style: pw.TextStyle(
                            fontSize: 20, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        'Receipt',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              pw.Row(
                children: [
                  pw.Text(
                    'Customer: ${name.toUpperCase()}',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(width: 240),
                  pw.Text(
                    'Date: $formattedDate',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ],
              ),
              pw.Divider(),
              pw.Table.fromTextArray(
                context: context,
                data: [
                  [
                    'Product name',
                    'Company',
                    'Size',
                    'Quantity',
                    'Subtotal',
                  ],
                  ...products.map((product) {
                    final subtotal = double.parse(product['sp']) *
                        product['quantity'] *
                        (1 - double.parse(product['discount']) / 100);
                    return [
                      product['productname'],
                      product['company'],
                      product['size'],
                      product['quantity'].toString(),
                      'Rs. ${subtotal.toStringAsFixed(2)}',
                    ];
                  }).toList(),
                ],
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                cellStyle: const pw.TextStyle(),
                cellAlignments: {
                  0: pw.Alignment.centerLeft,
                  1: pw.Alignment.centerLeft,
                  2: pw.Alignment.center,
                  3: pw.Alignment.center,
                  4: pw.Alignment.center,
                },
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Total Amount: \Rs. ${calculateTotalAmount().toStringAsFixed(2)}',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );

    // Print the PDF
    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
      name: 'Receipt.pdf',
    );
  }

  void saveSales() async {
    final dio = Dio();
    try {
      print('salessave');
      for (var product in selectedProducts) {
        final response = await dio.post('$url/save_sales/', data: {
          'organization': session['userdata']['organization'],
          'company': product['company'],
          'customername': custommername.text,
          'productname': product['productname'],
          'size': product['size'],
          'sp': product['sp'].toString(),
          'cp': product['cp'].toString(),
          'discount': product['discount'].toString(),
          'quantity': product['quantity'].toString(),
        });
        if (response.statusCode == 200) {
          print('Sale saved successfully');
        }
      }
    } catch (error) {
      print('ram');
      print(error.toString());
    }
  }

  // void saveSales() async {
  //   final organization = session['userdata']['organization'];
  //   final dio = Dio();
  //   try {
  //     for (var product in selectedProducts) {
  //       final response = await dio.post('$url/sales/', data: {
  //         'organization': organization,
  //         'company': product['company'],
  //         'customername': custommername.text,
  //         // 'suppliers': product['suppliers'],
  //         'productname': product['productname'],
  //         'size': product['size'],
  //         'sp': product['sp'],
  //         'cp': product['cp'],
  //         'discount': product['discount'],
  //         'quantity': product['quantity'],
  //         "id": product['id'],
  //       });
  //       if (response.statusCode == 200) {
  //         print('Inventory updated successfully');
  //       }
  //     }
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }

  void updateInventoryQuantity() async {
    final organization = session['userdata']['organization'];

    final dio = Dio();
    try {
      for (var product in selectedProducts) {
        final response = await dio.post('$url/updateInventoryQuantity/', data: {
          'organization': organization,
          'company': product['company'],
          'suppliers': product['suppliers'],
          'productname': product['productname'],
          'size': product['size'],
          'sp': product['sp'],
          'cp': product['cp'],
          'discount': product['discount'],
          'quantity': product['quantity'],
          "id": product['id'],
        });
        if (response.statusCode == 200) {
          print('Inventory updated successfully');
        }
      }
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    if (w <= 600) {
      w = 2 * w;
    }
    DateTime now = DateTime.now();

    String formattedDate = '${now.day}-${now.month}-${now.year}';
    print(formattedDate);
    return Scaffold(
      appBar: AppBar(
        title: Text('Billing'),
      ),
      body: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: h * 0.28),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BillingSearch(ontap: addToCart),
              ),
            ),
          ),
          // Row(
          //   children: [
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      'Selected Products:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(maxWidth: 0.5 * w),
                      child: TextFormField(
                        controller: custommername,
                        decoration: InputDecoration(
                            labelText: 'Customer Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: selectedProducts.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = selectedProducts[index];
                        return SingleChildScrollView(
                          scrollDirection:
                              axisDirectionToAxis(AxisDirection.right),
                          child: Row(
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                    maxWidth: w * 0.5, maxHeight: 0.4 * h),
                                child: ListTile(
                                  title: Text(product['productname']),
                                  subtitle: Text(
                                      '${product['company']} - ${product['size']}'),
                                  trailing: Container(
                                    constraints: BoxConstraints(
                                        maxWidth: 0.3 * w, maxHeight: 0.1 * h),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 0.3 * w / 2,
                                          child: TextField(
                                            onChanged: (value) {
                                              for (int i = 0;
                                                  i < selectedProducts.length;
                                                  i++) {
                                                if (selectedProducts[i]['id'] ==
                                                    product['id']) {
                                                  setState(() {
                                                    selectedProducts[i]
                                                            ['quantity'] =
                                                        double.parse(value);
                                                  });
                                                }
                                              }
                                            },
                                            // controller: _quantityController,
                                            decoration: InputDecoration(
                                                hintText: 'Quantity',
                                                labelText: 'Quantity',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10))),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 0.3 * w / 2,
                                          child: TextFormField(
                                            initialValue:
                                                product['discount'].toString(),
                                            onChanged: (value) {
                                              for (int i = 0;
                                                  i < selectedProducts.length;
                                                  i++) {
                                                if (selectedProducts[i]['id'] ==
                                                    product['id']) {
                                                  setState(() {
                                                    selectedProducts[i]
                                                            ['discount'] =
                                                        double.parse(value);
                                                  });
                                                }
                                              }
                                            },
                                            // controller: _quantityController,
                                            decoration: InputDecoration(
                                                hintText: 'Discount',
                                                labelText: 'Discount',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectedProducts = selectedProducts
                                        .where((element) => element != product)
                                        .toList();
                                  });
                                },
                                icon: Icon(Icons.delete),
                              ),
                              SubTotal(data: selectedProducts[index]),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Total Amount: \Rs. ${calculateTotalAmount().toStringAsFixed(2)}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        updateInventoryQuantity();
                        saveSales();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Column(
                                children: [
                                  Text(session['userdata']['organization']),
                                  Text('Receipt'),
                                  ListTile(
                                    title: Text(
                                        'Customer: ${custommername.text}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    trailing: Text('Date: $formattedDate',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ...selectedProducts.map((product) {
                                    double subtotal = double.parse(
                                            product['sp']) *
                                        product['quantity'] *
                                        (1 -
                                            double.parse(product['discount']) /
                                                100);
                                    return Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            '${product['productname']} Company: ${product['company']}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Size: ${product['size']}  Quantity: ${product['quantity']}',
                                              ),
                                            ],
                                          ),
                                          trailing: Text(
                                            'Subtotal: \Rs. ${subtotal.toStringAsFixed(2)}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                  SizedBox(height: 16),
                                  Text(
                                    'Total Amount: \Rs. ${calculateTotalAmount().toStringAsFixed(2)}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    _printDialogContents(context);
                                  },
                                  child: Text('Print'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Close'),
                                ),
                              ],
                            );
                            ;
                          },
                        );
                      },
                      child: Text('Generate Receipt'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Expanded(
          //     child: Container(
          //   child: Text('the bill'),
          // ))
          //   ],
          // ),
        ],
      ),
    );
  }
}

class SubTotal extends StatelessWidget {
  SubTotal({super.key, required data}) {
    subtotalvalue = double.parse(data['sp']) *
        data['quantity'] *
        (1 - double.parse(data['discount']) / 100);
  }

  double subtotalvalue = 0;

  @override
  Widget build(BuildContext context) {
    return Text(subtotalvalue.toString());
  }
}

void main() {
  runApp(MaterialApp(
    home: BillingPage(),
  ));
}
