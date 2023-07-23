import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../screens/home.dart';

void signInformToServer(String company, String email, String password,
    String accounttype, BuildContext context) async {
  final dio = Dio();
  final response = await dio.post(
    '$url/signin/',
    data: {
      'email': email,
      'password': password,
      'accounttype': accounttype,
      'company': company
    },
  );
  session = response.data;
  print(response.data);

  if (response.statusCode == 200 && response.data['status']) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Credentials'),
          content:
              Text('The provided credentials are incorrect. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the alert dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    print('Form submission failed');
  }
}
