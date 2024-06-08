import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_1/components/components.dart';


class AddMemberScreen extends StatefulWidget {
  AddMemberScreen({Key? key}) : super(key: key);

  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State{
  final TextEditingController nomorIndukController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController tglLahirController = TextEditingController();
  final TextEditingController teleponController = TextEditingController();
  
  final apiUrl = 'https://mobileapis.manpits.xyz/api';
  final dio = Dio();
  final storage = GetStorage();

  void addMember(BuildContext context) async {
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
        Navigator.pushReplacementNamed(context, '/buttom');
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
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? _selected = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100)
    ); 
    if(_selected != null ){
      setState((){
        tglLahirController.text = _selected.toString().split(" ")[0];
      });
    }
  }   

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Member',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        toolbarHeight: 75,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                CustomInputField(
                  labelText: 'Masukan Nomor Induk', 
                  controller: nomorIndukController,
                ),
                SizedBox(height: 20),
                CustomInputField(
                  labelText: 'Masukan Nama', 
                  controller: namaController,
                ),
                SizedBox(height: 20),
                CustomInputField(
                  labelText: 'Masukan Alamat', 
                  controller: alamatController,
                ),
                SizedBox(height: 20),
                CustomInputField(
                  labelText: 'Masukan Tanggal Lahir', 
                  controller: tglLahirController,
                  readOnly: true,
                  prefixIcon: Icon(Icons.calendar_today),
                  onTap: ()=>_selectDate(context),
                ),
                SizedBox(height: 20),
                CustomInputField(
                  labelText: 'Masukan Nomor Telepon', 
                  controller: teleponController,
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: 'Add Member', 
                  backgroundColor: Colors.blue, 
                  textColor: Colors.white, 
                  onPressed: (){
                    addMember(context);
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
