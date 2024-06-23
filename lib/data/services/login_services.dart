import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_1/components/components.dart';

class LoginService {
  final Dio dio = Dio();
  final String apiUrl = 'https://mobileapis.manpits.xyz/api';
  final GetStorage storage = GetStorage();

  Future<void> login(TextEditingController emailController, TextEditingController passwordController, BuildContext context) async {
    try {
      final response = await dio.post(
        "$apiUrl/login",
        data: {
          "email": emailController.text,
          "password": passwordController.text
        }
      );

      print(response.data['data']['token']);
      storage.write('token', response.data['data']['token']);

      if (response.data['success'] == true) {
        Navigator.pushNamed(context, '/landingPage');
        showCustomSnackBar(
          context,
          'Logged succesfully',
          backgroundColor: Colors.green
        );
      }
    } on DioException catch (error) {
      print(" Error : ${error.response?.statusCode} - ${error.response?.data} ");
      String errorMessage = "";
      if (error.response != null && error.response!.data is Map<String, dynamic>) {
        if (error.response!.data.containsKey('data')) {
          var e = error.response!.data['data']['errors'];
          if (e.isNotEmpty) {
            errorMessage = e.values.first[0].toString();
          }
        } else {
          errorMessage = error.response!.data['message'];
        }
      }
      print(error.response!.data);
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('An Error Occurred!'),
          content: Text('$errorMessage'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'No'),
              child: Text('Ok')
            )
          ],
        )
      );
    }
  }
}