import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/main.dart';
import 'package:loginpage/widget/loginbutton.dart';

import '../functions/updateinventoryform.dart';
import '../widget/Textfield.dart';

class UpdateForm extends StatefulWidget {
  const UpdateForm({Key? key}) : super(key: key);

  @override
  State<UpdateForm> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _suppliersController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _cpController = TextEditingController();
  final TextEditingController _spController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _minimumQuantityController =
      TextEditingController();

  Future<bool> saveUpdateForm() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final company = _companyController.text;
      final suppliers = _suppliersController.text;
      final productname = _productNameController.text;
      final size = _sizeController.text;
      final cp = _cpController.text;
      final sp = _spController.text;
      final discount = _discountController.text;
      final quantity = _quantityController.text;
      final minimum_value = _minimumQuantityController.text;
      final organization = session['userdata']['organization'];

      final value = await updateFormToServer(
        organization,
        company,
        suppliers,
        productname,
        size,
        sp,
        cp,
        discount,
        quantity,
        minimum_value,
      );

      if (value['status'] == true) {
        return true;
      } else {
        return false;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text("Update")),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SignInFields(
                controller: _suppliersController,
                hintText: 'Suppliers',
                iconData: null,
                isPassword: false,
                type: 'text',
                labelText: 'Suppliers',
              ),
              const SizedBox(
                height: 15,
              ),
              SignInFields(
                controller: _companyController,
                hintText: 'Company',
                iconData: null,
                isPassword: false,
                type: 'text',
                labelText: 'Company',
              ),
              const SizedBox(
                height: 15,
              ),
              SignInFields(
                controller: _productNameController,
                hintText: 'Product Name',
                iconData: null,
                isPassword: false,
                type: 'text',
                labelText: 'Product Name',
              ),
              const SizedBox(
                height: 15,
              ),
              SignInFields(
                controller: _quantityController,
                hintText: 'Quantity',
                iconData: null,
                isPassword: false,
                type: 'text',
                labelText: 'Quantity',
              ),
              const SizedBox(
                height: 15,
              ),
              SignInFields(
                controller: _sizeController,
                hintText: 'Size',
                iconData: null,
                isPassword: false,
                type: 'number',
                labelText: 'Size',
              ),
              const SizedBox(
                height: 15,
              ),
              SignInFields(
                controller: _cpController,
                hintText: 'Cost Price',
                iconData: null,
                isPassword: false,
                type: 'number',
                labelText: 'Cost Price',
              ),
              const SizedBox(
                height: 15,
              ),
              SignInFields(
                controller: _spController,
                hintText: 'Selling Price',
                iconData: null,
                isPassword: false,
                type: 'number',
                labelText: 'Selling Price',
              ),
              const SizedBox(
                height: 15,
              ),
              SignInFields(
                controller: _discountController,
                hintText: 'Discount',
                iconData: null,
                isPassword: false,
                type: 'number',
                labelText: 'Discount',
              ),
              SignInFields(
                controller: _minimumQuantityController,
                hintText: 'Minimum Quantity',
                iconData: null,
                isPassword: false,
                type: 'number',
                labelText: 'Minimum Quantity',
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  var value = await saveUpdateForm();
                  if (value) {
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save'),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
