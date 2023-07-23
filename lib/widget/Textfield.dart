import 'package:flutter/material.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class SignInFields extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData? iconData;
  final bool isPassword;
  final String type;
  final String labelText;
  const SignInFields(
      {Key? key,
      required this.hintText,
      this.iconData,
      required this.isPassword,
      required this.type,
      required this.labelText,
      required this.controller})
      : super(key: key);

  bool isNumeric(String? str) {
    if (str == null) {
      return false;
    }

    final number = num.tryParse(str);
    return number != null;
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    if (w <= 600) {
      w = 2.5 * w;
    }

    TextInputType? inputType;
    switch (type) {
      case 'text':
        inputType = TextInputType.text;
        break;
      case 'password':
        inputType = TextInputType.visiblePassword;
        break;
      case 'email':
        inputType = TextInputType.text;
        break;
      case 'number':
        inputType = TextInputType.number;
        break;
    }
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 0.3 * w, maxHeight: 0.1 * h),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (labelText == 'Name' ||
              labelText == 'Company' ||
              labelText == 'Product Name') {
            if (value!.isEmpty) {
              return 'Enter valid $labelText';
            }
          }
          if (labelText == 'Email') {
            if (value!.isEmpty) {
              return '$labelText is empty';
            } else if (!RegExp(
                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                .hasMatch(value)) {
              return 'Please enter a valid  $labelText';
            }
            return null;
          }
          if (labelText == 'Password') {
            if (value!.isEmpty) {
              return '$labelText is empty';
            } else if (!RegExp(
                    r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
                .hasMatch(value)) {
              return 'Please enter a valid $labelText';
            }
            return null;
          }
          if (labelText == 'Confirm Password') {
            if (value!.isEmpty) {
              return '$labelText is empty';
            } else if (!RegExp(
                    r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
                .hasMatch(value)) {
              return 'Please enter a valid $labelText';
            }

            return null;
          }
          if (labelText == 'Mobile Number') {
            if (value!.isEmpty) {
              return 'Enter valid Mobile Number';
            } else if (!RegExp(r"^[6-9]\d{9}$").hasMatch(value)) {
              return 'Please enter a valid $labelText';
            }
          }
          if (labelText == 'Size' ||
              labelText == 'Cost Price' ||
              labelText == 'Selling Price' ||
              labelText == 'Discount' ||
              labelText == 'Quantity') {
            if (!isNumeric(value)) {
              return '$labelText is not a number';
            }
          }
          if (labelText == 'Company' ||
              labelText == 'Product Name' ||
              labelText == 'Suppliers' ||
              labelText == 'Selling Price' ||
              labelText == 'Discount' ||
              labelText == 'Cost Price' ||
              labelText == 'Size') {
            if (value!.isEmpty) {
              return ' enter valid $labelText ';
            }
          }
        },
        keyboardType: inputType,
        obscureText: isPassword,
        enableSuggestions: !isPassword,
        autocorrect: !isPassword,
        decoration: InputDecoration(
            prefixIcon: Icon(iconData ?? Icons.email),
            hintText: hintText,
            labelText: labelText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
