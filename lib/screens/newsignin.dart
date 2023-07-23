import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/screens/newsignup.dart';
import 'package:loginpage/widget/loginbutton.dart';
import '../functions/signinform.dart';
import '../widget/Textfield.dart';
import 'package:loginpage/main.dart';

import 'home.dart';

class NewSignIn extends StatefulWidget {
  const NewSignIn({Key? key}) : super(key: key);

  @override
  State<NewSignIn> createState() => _NewSignInState();
}

class _NewSignInState extends State<NewSignIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();

  final _accountType = ['User', 'Admin'];
  String _selectedValue = 'User';

  void signInform() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      final accounttype = _selectedValue;
      final company = _companyController.text;
      signInformToServer(company, email, password, accounttype, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    if (w <= 600) {
      w = 2.5 * w;
    }
    return Scaffold(
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 35,
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 0.18 * h,
                      width: 0.4 * w,
                    ),
                    Text(
                      'Welcome',
                      style: TextStyle(
                          fontSize: 0.05 * h, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SignInFields(
                      controller: _companyController,
                      hintText: 'Company',
                      iconData: Icons.abc,
                      isPassword: false,
                      type: 'email',
                      labelText: 'Company',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SignInFields(
                      controller: _emailController,
                      hintText: 'Email',
                      iconData: Icons.email,
                      isPassword: false,
                      type: 'email',
                      labelText: 'Email',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SignInFields(
                      controller: _passwordController,
                      hintText: 'password',
                      iconData: Icons.password,
                      isPassword: true,
                      type: 'password',
                      labelText: 'Password',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 0.3 * w),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            labelText: 'Account Type',
                            hintText: 'Account Type',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        value: _selectedValue,
                        items: _accountType
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value as String;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.purple[300],
                          borderRadius: BorderRadius.circular(15)),
                      child: ElevatedButton(
                        onPressed: signInform,
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(0.3 * w, 0.067 * h),
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent),
                        child: const Text("SignIn",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    RichText(
                        text: TextSpan(
                      text: "Don't have an account?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 0.024 * h,
                          color: Colors.grey),
                      children: [
                        TextSpan(
                          text: "Create an account",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewSignUp()));
                            },
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 0.024 * h,
                              color: Colors.black),
                        )
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
