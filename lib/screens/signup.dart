import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15,),
            Container(child: Text('CREATE', style: TextStyle(color: Colors.white),),
              height: 0.35 * h,
              width: w,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/logo.png'))),
            ),
            Center(
              child: Container(
                height: 0.5 * h,
                margin: EdgeInsets.only(left: 20, right: 20),
                width: w*0.6,
                child: Column(

                  children: [
                    Text(
                      'Create your account.',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    TextField(
                        decoration: InputDecoration(
                            hintText: 'Company Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ))),
                    SizedBox(height: 10),
                    TextField(
                        decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ))),
                    SizedBox(height: 10),
                    TextField(
                        decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: const Icon(Icons.password),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ))),
                    SizedBox(height: 10)
                  ],
                ),
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
                      'Create', style: TextStyle(fontSize: 20 ,
                        fontWeight: FontWeight.bold), ),
                  ),

                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
