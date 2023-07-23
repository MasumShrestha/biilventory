import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SalesRecord extends StatefulWidget {
  const SalesRecord({Key? key}) : super(key: key);

  @override
  _SalesRecordState createState() => _SalesRecordState();
}

class _SalesRecordState extends State<SalesRecord> {
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;

  double totalSales = 0.0;
  double totalProfit = 0.0;
  Map<String, dynamic>? highestSales;

  Future<void> fetchSales(int year, int month) async {
    try {
      final response = await Dio().get(
        '$url/fetchsalesrecord/',
        queryParameters: {
          "organization": session['userdata']['organization'],
          "year": year,
          "month": month,
        },
      );
      print(response.data);

      if (response.data != null) {
        setState(() {
          totalSales = double.parse(response.data['total_sales'] ?? '0');
          totalProfit = double.parse(response.data['total_profit'] ?? '0');
          highestSales =
              response.data['max_sold_product'] as Map<String, dynamic>?;
        });
      } else {
        setState(() {
          totalSales = 0.0;
          totalProfit = 0.0;
          highestSales = null;
        });
      }
    } catch (error) {
      print("Error: $error");
      setState(() {
        totalSales = 0.0;
        totalProfit = 0.0;
        highestSales = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSales(year, month);
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: const Text('Sales Report'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    height: 0.1 * h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton(
                          alignment: Alignment.center,
                          value: year,
                          items: List<DropdownMenuItem<int>>.generate(
                            100,
                            (index) {
                              int year = DateTime.now().year - index;
                              return DropdownMenuItem<int>(
                                value: year,
                                child: Text(year.toString()),
                              );
                            },
                          ),
                          onChanged: (int? value) {
                            setState(() {
                              year = value!;
                            });
                            fetchSales(year, month); // Fetch updated data
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        DropdownButton(
                          alignment: Alignment.center,
                          value: month,
                          hint: Text('month'),
                          items: List<DropdownMenuItem<int>>.generate(
                            12,
                            (index) {
                              int month = index + 1;
                              return DropdownMenuItem<int>(
                                value: month,
                                child: Text(month.toString()),
                              );
                            },
                          ),
                          onChanged: (int? value) {
                            setState(() {
                              month = value!;
                            });
                            fetchSales(year, month); // Fetch updated data
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  height: 0.21 * h,
                  color: Colors.grey[400],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/sales.png',
                        height: 0.2 * h,
                        width: 0.18 * w,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Total Sales: ${totalSales.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  height: 0.21 * h,
                  color: Colors.grey[400],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/profit.jpg',
                        height: 0.2 * h,
                        width: 0.18 * w,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Total Profit: ${totalProfit.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  height: 0.21 * h,
                  color: Colors.grey[400],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/bestselling.png',
                        height: 0.2 * h,
                        width: 0.18 * w,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (highestSales != null)
                            Text(
                              'Highest Sales: ${highestSales!['productname']}',
                              style: TextStyle(fontSize: 20),
                            ),
                          if (highestSales != null)
                            Text(
                              '${highestSales!['total_quantity']}',
                              style: TextStyle(fontSize: 20),
                            ),
                          if (highestSales == null)
                            Text(
                              'Not available',
                              style: TextStyle(fontSize: 20),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
