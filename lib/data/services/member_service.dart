import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_1/components/components.dart';
import 'package:project_1/data/model/member_model.dart';

class MemberService {
  final Dio dio = Dio();
  final GetStorage storage = GetStorage();
  final String apiUrl = 'https://mobileapis.manpits.xyz/api';

  Future<List<Member>> fetchMembers(BuildContext context) async {
    try {
      Response response = await dio.get(
        "$apiUrl/anggota",
        options: Options(
          headers: {'Authorization': 'Bearer ${storage.read('token')}'},
        ),
      );
      print('Response: $response');
      if (response.data['success'] == true) {
        MemberData memberData = MemberData.fromJson(response.data);
        return memberData.data;
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
          title: Text('${errorMessage}'),
          content: Text('Please Login'),
          actions: <Widget>[
            TextButton(
              onPressed: () =>  Navigator.pushReplacementNamed(context, '/login'),
              child: Text('Ok')
            )
          ],
        )    
      );
      return [];
    }
  }

  Future<Member?> fetchMember(BuildContext context, int id) async {
    try {
      Response response = await Dio().get(
        "$apiUrl/anggota/$id",
        options: Options(
          headers: {'Authorization': 'Bearer ${storage.read('token')}'},
        ),
      );
      print('Response: $response');
      if (response.data['success'] == true) {
        Member memberData = Member.fromModel(response.data['data']['anggota']);
        print('Anggota: $memberData');
        return memberData;
      }
    } on DioException catch (error) {
      print('Error occurred: ${error.response}');
      String errorMessage = error.response!.data['message'];
      if (error.response!.data['message'] != null && error.response!.data['message'].contains('Token is Expired')) {
         errorMessage = 'Your Session is Over';
      }
      showDialog<String>(
        context: context, 
        builder: (BuildContext context) => AlertDialog(
          title: Text('${errorMessage}'),
          content: Text('Please Login'),
          actions: <Widget>[
            TextButton(
              onPressed: () =>  Navigator.pushReplacementNamed(context, '/login'),
              child: Text('Ok')
            )
          ],
        )    
      );
    }
    return null;
  }

  Future<void> deleteMember(BuildContext context, int id) async {
    try {
      final response = await dio.delete(
        "$apiUrl/anggota/$id",
        options: Options(
          headers: {'Authorization': 'Bearer ${storage.read('token')}'},
        ),
      );
      print(response.data);
      if (response.data['success'] == true) {
        Navigator.pushReplacementNamed(context, '/landingPage');
        showCustomSnackBar(
          context,
          'Member deleted succesfully',
          backgroundColor: Colors.green
        );
      } else {
        String errorMessage = response.data['message'] ?? 'Unknown error occurred';
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Ok'),
              ),
            ],
          ),
        );
      }
    } on DioException catch (error) {
      print('Error occurred: ${error.response}');
      String errorMessage = error.response?.data['message'] ?? 'Unknown error occurred';
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Ok'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> addMember(BuildContext context, TextEditingController nomorIndukController, TextEditingController namaController, TextEditingController alamatController, TextEditingController tglLahirController, TextEditingController teleponController) async {
    try {
      final response = await dio.post(
        "$apiUrl/anggota",
        data: {
          "nomor_induk": nomorIndukController.text,
          "nama": namaController.text,
          "alamat": alamatController.text,
          "tgl_lahir": tglLahirController.text,
          "telepon": teleponController.text,
        },
        options: Options(
          headers: {'Authorization': 'Bearer ${storage.read('token')}'},
        ),
      );
      print(response.data);
      if (response.data['success'] == true) {
        Navigator.pushReplacementNamed(context, '/landingPage');
        showCustomSnackBar(
          context,
          'Member add succesfully',
          backgroundColor: Colors.green
        );
      }
    } on DioException catch (error) {
      print('Error occurred: ${error.response}');

      if (error.response != null && error.response!.data is Map<String, dynamic>) {
        String errorMessage = error.response!.data['message'];
        if (error.response!.data['message'] != null && error.response!.data['message'].contains('Invalid datetime format')) {
          if(error.response!.data['message'].contains('Incorrect integer value')){
            errorMessage = 'Nomor Induk must be an integer';
          }
        }
        if (error.response!.data['message'] != null && error.response!.data['message'].contains('Integrity constraint violation')) {
          if(error.response!.data['message'].contains('Duplicate entry')){
            errorMessage = 'Nomor Induk Already Registered!';
          } else {
            errorMessage = 'Please fill all the fields';
          }
        }
        showCustomSnackBar(
          context,
          errorMessage,
          backgroundColor: Colors.red
        );     
      } else {
        showCustomSnackBar(
          context,
          'Failed to add member. Please try again.',
          backgroundColor: Colors.red,
        );
      }
    }
  }

  Future<void> editMember( BuildContext context, int id, Map<String, dynamic> formData) async {
    try {
      final response = await dio.put(
        "$apiUrl/anggota/$id",
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer ${storage.read('token')}'},
        ),
      );
      print(response.data);
      if (response.data['success'] == true) {
        Navigator.pushReplacementNamed(context, '/landingPage');
        showCustomSnackBar(
          context,
          'Member edited successfully',
          backgroundColor: Colors.green,
        );
      }
    } on DioException catch (error) {
      print('Error occurred: $error');

      if (error.response != null && error.response!.data is Map<String, dynamic>) {
        String errorMessage = error.response!.data['message'] ?? 'An unexpected error occurred';
        if (errorMessage.contains('Invalid datetime format')) {
          if (errorMessage.contains('Incorrect integer value')) {
            errorMessage = 'Nomor Induk must be an integer';
          } else {
            errorMessage = 'Tanggal lahir must be a date';
          }
        }
        if (errorMessage.contains('Integrity constraint violation')) {
          errorMessage = 'Nomor Induk Already Registered!';
        }
        showCustomSnackBar(
          context,
          errorMessage,
          backgroundColor: Colors.red,
        );
      }
    }
  }
}