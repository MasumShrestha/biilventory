import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/screens/newsignup.dart';
import 'package:loginpage/widget/loginbutton.dart';
import '../widget/Textfield.dart';

class NewSignIn extends StatefulWidget {
  const NewSignIn({Key? key}) : super(key: key);

  @override
  State<NewSignIn> createState() => _NewSignInState();
}
class _NewSignInState extends State<NewSignIn> {
  final _formKey = GlobalKey<FormState>();
  // void _goToSignUpPage() {
  //   Navigator.of(context).pushNamed('');
  // }


  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
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
                const Text(
                  'Welcome',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                  hintText: 'password',
                  iconData: Icons.password,
                  isPassword: true,
                  type: 'password',
                  labelText: 'Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                 LoginButton(
                  data: 'Login', formKey: _formKey,
                ),
                const SizedBox(
                  height: 15,
                ),
                // GestureDetector(onTap:_goToSignUpPage,
                //   child: RichText(text: TextSpan(
                //     text: "Don't have an account?",
                //     style:TextStyle(fontWeight: FontWeight.bold, fontSize:14,color: Colors.grey),
                //     children: [TextSpan(text: "Create an account",
                //         style:TextStyle(fontWeight: FontWeight.bold, fontSize:14,color: Colors.black))],
                //   )),
                // )
                RichText(
                    text: TextSpan(
                  text: "Don't have an account?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
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
                            fontSize: 14,
                            color: Colors.black))
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
