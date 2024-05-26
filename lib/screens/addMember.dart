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
        showDialog<String>(
          context: context, 
          builder: (BuildContext context) => AlertDialog(
            title: const Text('An Error Occured!'),
            content: Text('${errorMessage}'),
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
        // automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                TextField(
                  controller: nomorIndukController,
                  decoration: InputDecoration(
                    labelText: 'Masukan Nomor Induk',
                    floatingLabelStyle: TextStyle(color: Colors.blue),
                    labelStyle: TextStyle(
                      color: Color(0xff7A869A),
                      fontWeight: FontWeight.w300,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),    
                      borderRadius: BorderRadius.circular(12),                              
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),    
                      borderRadius: BorderRadius.circular(12),                              
                    ),
                  ), 
                ),
                SizedBox(height: 10),
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                    labelText: 'Masukan Nama',
                    floatingLabelStyle: TextStyle(color: Colors.blue),
                    labelStyle: TextStyle(
                      color: Color(0xff7A869A),
                      fontWeight: FontWeight.w300,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),    
                      borderRadius: BorderRadius.circular(12),                              
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),    
                      borderRadius: BorderRadius.circular(12),                              
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: alamatController,
                  decoration: InputDecoration(
                    labelText: 'Masukan Alamat',
                    floatingLabelStyle: TextStyle(color: Colors.blue),
                    labelStyle: TextStyle(
                      color: Color(0xff7A869A),
                      fontWeight: FontWeight.w300,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),    
                      borderRadius: BorderRadius.circular(12),                              
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),    
                      borderRadius: BorderRadius.circular(12),                              
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: tglLahirController,
                  decoration: InputDecoration(
                    labelText: 'Masukan Tanggal Lahir',
                    floatingLabelStyle: TextStyle(color: Colors.blue),
                    prefixIcon: Icon(Icons.calendar_today),
                    labelStyle: TextStyle(
                      color: Color(0xff7A869A),
                      fontWeight: FontWeight.w300,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),    
                      borderRadius: BorderRadius.circular(12),                              
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),    
                      borderRadius: BorderRadius.circular(12),                              
                    ),
                  ),
                  readOnly: true,
                  onTap: () => _selectDate(context),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: teleponController,
                  decoration: InputDecoration(
                    labelText: 'Masukan Telepon',
                    floatingLabelStyle: TextStyle(color: Colors.blue),
                    labelStyle: TextStyle(
                      color: Color(0xff7A869A),
                      fontWeight: FontWeight.w300,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),    
                      borderRadius: BorderRadius.circular(12),                              
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),    
                      borderRadius: BorderRadius.circular(12),                              
                    ),
                  ),
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
