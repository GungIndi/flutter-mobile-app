import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_1/components/components.dart';
import 'package:project_1/data/model/transaction_model.dart';

class TransactionService {
  final Dio dio = Dio();
  final GetStorage storage = GetStorage();
  final String apiUrl = 'https://mobileapis.manpits.xyz/api';

   Future<List<Transaction>> fetchData(BuildContext context, int id) async {
    try {
      Response response = await dio.get(
        "$apiUrl/tabungan/$id",
        options: Options(
          headers: {'Authorization': 'Bearer ${storage.read('token')}'},
        ),
      );
      print(response.data);
      if (response.data['success'] == true) {
        TransactionData tabungan = TransactionData.fromJson(response.data);
        return tabungan.data;
      }
    } on DioException catch (error) {
      String errorMessage = error.response?.data['message'] ?? 'An unexpected error occurred';
      if (error.response?.data['message'] != null && error.response!.data['message'].contains('Token is Expired')) {
        errorMessage = 'Your Session is Over';
      }
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(errorMessage),
          content: Text('Please Login'),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                child: Text('Ok')
            )
          ],
        ),
      );
    } return [];
  }

  Future<int?> fetchDataSaldo(BuildContext context, int id) async {
    try {
      Response response = await dio.get(
        "$apiUrl/saldo/$id",
        options: Options(
          headers: {'Authorization': 'Bearer ${storage.read('token')}'},
        ),
      );
      if (response.data['success'] == true) {
        print(response.data['data']['saldo']);
        return response.data['data']['saldo'];
      } else {
        print('failed to fetch saldo');
      }
    } on DioException catch (error) {
      String errorMessage = error.response?.data['message'] ?? 'An unexpected error occurred';
      if (error.response?.data['message'] != null && error.response!.data['message'].contains('Token is Expired')) {
        errorMessage = 'Your Session is Over';
      }
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(errorMessage),
          content: Text('Please Login'),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                child: Text('Ok')
            )
          ],
        ),
      );
    }
    return null;
  }

  Future<void> addTransaction(BuildContext context, int id, String trxId, String trxNominal) async {
    try {
      final response = await dio.post(
        '$apiUrl/tabungan',
        data: {
          "anggota_id": id,
          "trx_id": trxId,
          "trx_nominal": trxNominal
        },
        options: Options(
            headers: {'Authorization': 'Bearer ${storage.read('token')}'}
        ),
      );
      if (response.data['success'] == true) {
        Navigator.pop(context);
        showCustomSnackBar(
          context,
          'Transaction add succesfully',
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
        if (error.response!.data['message'] != null && error.response!.data['message'].contains('trx nominal field is required')) {
          errorMessage = 'Nominal Field is Required';
        } else if (error.response!.data['message'].contains('must be a number')) {
          errorMessage = 'Nominal field must be a number!';
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