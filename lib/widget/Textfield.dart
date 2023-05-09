import 'package:flutter/material.dart';
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class SignInFields extends StatelessWidget {
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
      required this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    return
      ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: TextFormField(
        validator: (value) {
          if(labelText=='Name') {
            if (value!.isEmpty) {
              return 'Enter valid Name';
            }
          }
          if(labelText=='Email') {
            if (value!.isEmpty) {
                return 'Please enter your email';
              } else if (!value.contains('@')) {
                return 'Please enter a valid email';
              }


          }
          if(labelText=='Password') {
            if (value!.isEmpty) {
              return 'Enter valid Password';
            }
          }
          if(labelText=='Mobile Number') {
            if (value!.isEmpty) {
              return 'Enter valid Mobile Number';
            }
          }
          return null;
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
