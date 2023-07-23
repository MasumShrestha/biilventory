import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SalesEdit extends StatefulWidget {
  final Map<String, dynamic> item;

  const SalesEdit({Key? key, required this.item}) : super(key: key);

  @override
  _SalesEditState createState() => _SalesEditState();
}

class _SalesEditState extends State<SalesEdit> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _customernameController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _cpController = TextEditingController();
  final TextEditingController _spController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set initial values in the text fields based on the item data
    _companyController.text = widget.item['company'];
    _customernameController.text = widget.item['customername'];
    _productNameController.text = widget.item['productname'];
    _sizeController.text = widget.item['size'].toString();
    _cpController.text = widget.item['cp'].toString();
    _spController.text = widget.item['sp'].toString();
    _discountController.text = widget.item['discount'].toString();
    _quantityController.text = widget.item['quantity'].toString();
    _dateController.text = widget.item['created_at'].toString();

    print(widget.item);
  }

  void updateItem() {
    if (_formKey.currentState!.validate()) {
      final company = _companyController.text;
      final customername = _customernameController.text;
      final productname = _productNameController.text;
      final size = _sizeController.text;
      final cp = _cpController.text;
      final sp = _spController.text;
      final discount = _discountController.text;
      final quantity = _quantityController.text;
      final created_at = _dateController.text;
      final organization = session['userdata']['organization'];

      Dio dio = Dio();
      dio.post('$url/updateSale/', data: {
        'organization': organization,
        'company': company,
        'customername': customername,
        'productname': productname,
        'size': size,
        'sp': sp,
        'cp': cp,
        'discount': discount,
        'quantity': quantity,
        'created_at': created_at,
        "id": widget.item['id'],
      });

      // Perform the update operation using Dio or any other method
      // Pass the updated data to the backend API

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Text fields for editing the item data
                TextFormField(
                  controller: _companyController,
                  decoration: InputDecoration(labelText: 'Company'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a company';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _customernameController,
                  decoration: InputDecoration(labelText: 'customername'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter customername';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _cpController,
                  decoration: InputDecoration(labelText: 'Cost Price'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Cost Price';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _sizeController,
                  decoration: InputDecoration(labelText: 'size'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter size';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _spController,
                  decoration: InputDecoration(labelText: 'Selling Price'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Selling Price';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _discountController,
                  decoration: InputDecoration(labelText: 'Discount'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter discount';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _quantityController,
                  decoration: InputDecoration(labelText: 'Quantity'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Quantity';
                    }
                    return null;
                  },
                ),
                // Rest of the text fields...

                SizedBox(height: 16),

                ElevatedButton(
                  onPressed: updateItem,
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
