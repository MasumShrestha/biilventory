import 'package:flutter/material.dart';
import '../widget/Textfield.dart';
import '../widget/loginbutton.dart';

class NewSignUp extends StatefulWidget {
  const NewSignUp({Key? key}) : super(key: key);

  @override
  State<NewSignUp> createState() => _NewSignUpState();
}

class _NewSignUpState extends State<NewSignUp> {
  final _formKey = GlobalKey<FormState>();
  void _goToSignUpPage() {
    Navigator.of(context).pushNamed('');
  }
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
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
                const Text(
                  'Welcome',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                const SignInFields(
                  hintText: 'Name',
                  iconData: Icons.account_box_outlined,
                  isPassword: false,
                  type: 'text',
                  labelText: 'Name',
                ),
                const SizedBox(
                  height: 15,
                ),
                const SignInFields(
                  hintText: 'Mobile Number',
                  iconData: Icons.phone,
                  isPassword: false,
                  type: 'number',
                  labelText: 'Mobile Number',
                ),
                const SizedBox(
                  height: 15,
                ),
                const SignInFields(
                  hintText: 'Email',
                  iconData: Icons.email,
                  isPassword: false,
                  type: 'email',
                  labelText: 'Email',
                ),
                const SizedBox(
                  height: 15,
                ),
                const SignInFields(
                  hintText: 'Password',
                  iconData: Icons.password,
                  isPassword: true,
                  type: 'password',
                  labelText: 'Password',
                ),
                const SizedBox(
                  height: 15,
                ),
                const SignInFields(
                  hintText: 'Confirm Password',
                  iconData: Icons.password,
                  isPassword: true,
                  type: 'password',
                  labelText: 'Confirm Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                LoginButton(data: 'Create', formKey: _formKey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
