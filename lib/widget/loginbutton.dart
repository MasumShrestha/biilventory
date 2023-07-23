import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../screens/home.dart';
import 'package:loginpage/main.dart';


class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String data;
  const LoginButton({Key? key, required this.formKey, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.purple[300], borderRadius: BorderRadius.circular(15)),
      child: ElevatedButton(
        onPressed: () async{
          if (formKey.currentState!.validate()) {
            Dio dio=Dio();
            final response= await dio.get("$url/signin");
            print("response.data");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }

        },
        style: ElevatedButton.styleFrom(
            fixedSize: Size(400, 55),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        child: Text(data,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
