import 'package:dio/dio.dart';

import '../main.dart';

Future<Map<String, dynamic>> updateFormToServer(
  String organization,
  String company,
  String suppliers,
  String productname,
  String size,
  String sp,
  String cp,
  String discount,
  String quantity,
  String minimum_value,
) async {
  final response = await Dio().post(
    '$url/saveinventory',
    data: {
      'organization': organization,
      'company': company,
      'suppliers': suppliers,
      'productname': productname,
      'size': size,
      'sp': sp,
      'cp': cp,
      'discount': discount,
      'quantity': quantity,
      'minimum_value': minimum_value
    },
  );
  return (response.data);
}

// void updateFormToServer(company,suppliers,productname,size, sp,cp,discount){
//
// }