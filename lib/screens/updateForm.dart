import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/widget/loginbutton.dart';

import '../widget/Textfield.dart';

class UpdateForm extends StatefulWidget {
  const UpdateForm({Key? key}) : super(key: key);

  @override
  State<UpdateForm> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Update"),
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            const SignInFields(
              hintText: 'Company',
              iconData: null,
              isPassword: false,
              type: 'text',
              labelText: 'Company',
            ),
            const SizedBox(
              height: 15,
            ),
            const SignInFields(
              hintText: 'Product Name',
              iconData: null,
              isPassword: false,
              type: 'text',
              labelText: 'Product Name',
            ),
            const SizedBox(
              height: 15,
            ),
            const SignInFields(
              hintText: 'Size',
              iconData: null,
              isPassword: false,
              type: 'number',
              labelText: 'Size',
            ),
            const SizedBox(
              height: 15,
            ),
            const SignInFields(
              hintText: 'Cost Price',
              iconData: null,
              isPassword: false,
              type: 'number',
              labelText: 'Cost Price',
            ),
            const SizedBox(
              height: 15,
            ),
            const SignInFields(
              hintText: 'Selling Price',
              iconData: null,
              isPassword: false,
              type: 'number',
              labelText: 'Selling Price',
            ),
            const SizedBox(
              height: 15,
            ),
            const SignInFields(
              hintText: 'Discount',
              iconData: null,
              isPassword: false,
              type: 'number',
              labelText: 'Discount',
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                key: _formKey,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //save code
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Save')),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel')),
          ],

        ),
      ),
    );
  }
}
