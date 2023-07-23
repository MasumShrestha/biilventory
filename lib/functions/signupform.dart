import 'package:dio/dio.dart';

import '../main.dart';

Future<Map<String, dynamic>> signUpFormToServer(
    String email,
    String password,
    String mobileNumber,
    String name,
    String company,
    String accounttype) async {
  try {
    final response = await Dio().post(
      '$url/save_user/',
      data: {
        'password': password,
        'email': email,
        'mobilenumber': mobileNumber,
        'name': name,
        'organization': company,
        'accounttype': accounttype,
      },
    );

    print(response.data);
    return response.data;
  } catch (error) {
    print(error.toString());
    // Handle the error based on its type
    if (error is DioError) {
      final dioError = error as DioError;
      if (dioError.response != null) {
        // The request was made and the server responded with an error status code
        print('Server responded with error ${dioError.response!.statusCode}');
        print('Error message: ${dioError.response!.statusMessage}');
      } else {
        // Something went wrong during the request sending
        print('Request failed due to network problems');
      }
    } else {
      // Handle other types of errors
      print('Unexpected error occurred');
    }
    // Return null or an empty map to indicate the failure
    return {};
  }
}
