import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_1/components/components.dart';

class RegisterService {
  final Dio dio = Dio();
  final String apiUrl = 'https://mobileapis.manpits.xyz/api';

  Future<void> register(usernameController, emailController, passwordController, context) async {
    try{
      final response = await dio.post("$apiUrl/register", data: {
        "name" : usernameController.text,
        "email": emailController.text,
        "password": passwordController.text
      });
      print (response.data);
    
      if (response.data['success'] == true) {
        Navigator.pushNamed(
          context,
          '/login'
        );
        showCustomSnackBar(
          context,
          'User Registered succesfully',
          backgroundColor: Colors.green
        );
      }
    } on DioException catch (error) {
      print(" Error ${error.response?.statusCode} - ${error.response?.data} ");
      String errorMessage = "" ;
      if (error.response != null && error.response!.data is Map<String, dynamic>) {
        if (error.response!.data.containsKey('message')){
          var e = error.response!.data['message'];
          if(e.isNotEmpty){
            errorMessage = e.values.first[0].toString();
          }
        }
      }
      print(error.response!.data);
      showCustomSnackBar(
        context,
        errorMessage,
        backgroundColor: Colors.red
      );
    }
  }
}