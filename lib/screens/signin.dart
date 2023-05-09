import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 0.06*h,),
            Container(
              height: h * 0.3,
              width: w,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"),),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w*0.6,
              height: 0.4 * h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Sign into your account",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'E-mail',
                        // focusedBorder: OutlineInputBorder(
                        //     borderSide: BorderSide(
                        //   color: Colors.blue,
                        // )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration( prefixIcon: Icon(Icons.password),
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Forgot your Password? ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: InkWell(onTap: (){
                print("pressed");

              },
                child: Container(
                  height: 0.08*h, width: 0.3*w, color: Colors.purple[300],
                  child: Center(
                    child: Text(
                      'Sign in', style: TextStyle(fontSize: 20 ,
                        fontWeight: FontWeight.bold), ),
                  ),

                ),
              ),
            ),
            SizedBox(height: 40),
            RichText(
                text: TextSpan(
                    text: "Don't have an account?",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  children: [
                    TextSpan( text: 'Create account',
                    style: TextStyle(fontWeight: FontWeight.bold,
                    color: Colors.black),
                    // recognizer: TapGestureRecognizer()..onTap=()=>Get.to((=>)SignUp()),
            )
                  ]
                    )),

            Center(
              child: Container(
                width: w * 0.4,
                height: 0.08,

                decoration: const BoxDecoration(shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("assets/images/signinbutton.png"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
