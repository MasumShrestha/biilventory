import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';

class SalesReportPage extends StatefulWidget {
  @override
  _SalesReportPageState createState() => _SalesReportPageState();
}

class _SalesReportPageState extends State<SalesReportPage> {
  List<dynamic> salesData = [];
  double totalSales = 0;
  double totalProfit = 0;

  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  @override
  void initState() {
    super.initState();
    fetchSalesReport(selectedYear, selectedMonth);
  }

  void fetchSalesReport(int year, int month) async {
    final urll = '$url/sales_report/?year=$year&month=$month';
    final response = await http.get(Uri.parse(urll));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        salesData = data['sales_data'];
        totalSales = data['total_sales'];
        totalProfit = data['total_profit'];
      });
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Report'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<int>(
                value: selectedYear,
                onChanged: (int? newValue) {
                  setState(() {
                    selectedYear = newValue!;
                  });
                  fetchSalesReport(selectedYear, selectedMonth);
                },
                items: List<DropdownMenuItem<int>>.generate(
                  10, // Change this to the number of years you want to include in the dropdown
                  (index) {
                    int year = DateTime.now().year - index;
                    return DropdownMenuItem<int>(
                      value: year,
                      child: Text(year.toString()),
                    );
                  },
                ),
              ),
              SizedBox(width: 16),
              DropdownButton<int>(
                value: selectedMonth,
                onChanged: (int? newValue) {
                  setState(() {
                    selectedMonth = newValue!;
                  });
                  fetchSalesReport(selectedYear, selectedMonth);
                },
                items: List<DropdownMenuItem<int>>.generate(
                  12,
                  (index) {
                    int month = index + 1;
                    return DropdownMenuItem<int>(
                      value: month,
                      child:
                          Text(DateTime(2023, month).toString().split(' ')[0]),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text('Total Sales: $totalSales'),
          Text('Total Profit: $totalProfit'),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: salesData.length,
              itemBuilder: (BuildContext context, int index) {
                final sale = salesData[index];
                return ListTile(
                  title: Text('Month: ${sale['created_at__month']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Sales: ${sale['total_sales']}'),
                      Text('Total Profit: ${sale['total_profit']}'),
                      Text(
                          'Max Product Purchased: ${sale['max_product_purchased']}'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
