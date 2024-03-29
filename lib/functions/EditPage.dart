import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class EditPage extends StatefulWidget {
  final Map<String, dynamic> item;

  const EditPage({Key? key, required this.item}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _suppliersController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _cpController = TextEditingController();
  final TextEditingController _spController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set initial values in the text fields based on the item data
    _companyController.text = widget.item['company'];
    _suppliersController.text = widget.item['suppliers'];
    _productNameController.text = widget.item['productname'];
    _sizeController.text = widget.item['size'].toString();
    _cpController.text = widget.item['cp'].toString();
    _spController.text = widget.item['sp'].toString();
    _discountController.text = widget.item['discount'].toString();
    _quantityController.text = widget.item['quantity'].toString();
    print(widget.item);
  }

  void updateItem() {
    if (_formKey.currentState!.validate()) {
      final company = _companyController.text;
      final suppliers = _suppliersController.text;
      final productname = _productNameController.text;
      final size = _sizeController.text;
      final cp = _cpController.text;
      final sp = _spController.text;
      final discount = _discountController.text;
      final quantity = _quantityController.text;
      final organization = session['userdata']['organization'];

      Dio dio = Dio();
      dio.post('$url/updateInventory/', data: {
        'organization': organization,
        'company': company,
        'suppliers': suppliers,
        'productname': productname,
        'size': size,
        'sp': sp,
        'cp': cp,
        'discount': discount,
        'quantity': quantity,
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
                  controller: _suppliersController,
                  decoration: InputDecoration(labelText: 'Suppliers'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter suppliers';
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
