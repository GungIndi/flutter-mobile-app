import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_1/components/components.dart';

class InterestService {
  final Dio dio = Dio();
  final GetStorage storage = GetStorage();
  final String apiUrl = 'https://mobileapis.manpits.xyz/api';

  Future<dynamic> fetchInterest(BuildContext context) async {
    try {
      Response response = await dio.get(
        "$apiUrl/settingbunga",
        options: Options(
          headers: {'Authorization': 'Bearer ${storage.read('token')}'},
        ),
      );
      print('Response: ${response.data}');
      if (response.data['success'] == true) {
        return response.data['data'];
      } else {
        String errorMessage = response.data['message'] ?? 'Unknown error occurred';
        showCustomSnackBar(
          context, 
          errorMessage,
        );
        return [];
      }
    } on DioException catch (error) {
      print('Error occurred: ${error.response}');
      String errorMessage = error.response?.data['message'] ?? 'Unknown error occurred';
      if (errorMessage.contains('Token is Expired')) {
        errorMessage = 'Your Session is Over';
      }
      showDialog<String>(
        context: context, 
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            '${errorMessage}',
            style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),
          ),
          content: Text('Please Login', style: TextStyle(color: Colors.grey, fontSize: 18)),
          actions: <Widget>[
            TextButton(
              onPressed: () =>  Navigator.pushReplacementNamed(context, '/login'),
              child: Text(
                'Ok',
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              )
            )
          ],
        )    
      );
      return [];
    }
  }

  Future<void> addInterest(BuildContext context, double persen) async {
    try {
      final response = await dio.post(
        '$apiUrl/addsettingbunga',
        data: {
          "persen": persen,
          "isaktif": 1,
        },
        options: Options(
            headers: {'Authorization': 'Bearer ${storage.read('token')}'}
        ),
      );
      if (response.data['success'] == true) {
        Navigator.pop(context);
        showCustomSnackBar(
          context,
          'Interest add succesfully',
          backgroundColor: Colors.green
        );
      } else {
        String errorMessage = response.data['message'];
        print(errorMessage);
        Navigator.pop(context);
        showCustomSnackBar(
          context,
          errorMessage,
          backgroundColor: Colors.red
        );
      }
    } on DioException catch (error) {
      String errorMessage = error.response?.data['message'].toString() ?? 'An unexpected error occurred';
      if (error.response != null && error.response!.data is Map<String, dynamic>) {
        if (error.response!.data['message'] != null && error.response!.data['message'].contains('The persen field is required')) {
          errorMessage = 'Persen Field is Required';
        } else if (error.response!.data['message'].contains('must be a number')) {
          errorMessage = 'Persen field must be a number!';
        }
      }
      Navigator.pop(context);
      showCustomSnackBar(
        context,
        errorMessage,
        backgroundColor: Colors.red
      );
    }
  }

}