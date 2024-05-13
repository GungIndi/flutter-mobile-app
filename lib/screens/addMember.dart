import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_1/components/components.dart';

class AddMemberScreen extends StatelessWidget {
  AddMemberScreen({Key? key}) : super(key: key);

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
    }
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
                    labelStyle: TextStyle(
                      color: Color(0xff7A869A),
                      fontWeight: FontWeight.w300,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),    
                      borderRadius: BorderRadius.circular(12),                              
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),    
                      borderRadius: BorderRadius.circular(12),                              
                    ),
                  ), 
                ),
                SizedBox(height: 10),
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                    labelText: 'Masukan Nama',
                    labelStyle: TextStyle(
                      color: Color(0xff7A869A),
                      fontWeight: FontWeight.w300,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),    
                      borderRadius: BorderRadius.circular(12),                              
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),    
                      borderRadius: BorderRadius.circular(12),                              
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: alamatController,
                  decoration: InputDecoration(
                    labelText: 'Masukan Alamat',
                    labelStyle: TextStyle(
                      color: Color(0xff7A869A),
                      fontWeight: FontWeight.w300,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),    
                      borderRadius: BorderRadius.circular(12),                              
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),    
                      borderRadius: BorderRadius.circular(12),                              
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: tglLahirController,
                  decoration: InputDecoration(
                    hintText: '2000-03-31',
                    labelText: 'Masukan Tanggal Lahir',
                    labelStyle: TextStyle(
                      color: Color(0xff7A869A),
                      fontWeight: FontWeight.w300,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),    
                      borderRadius: BorderRadius.circular(12),                              
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),    
                      borderRadius: BorderRadius.circular(12),                              
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: teleponController,
                  decoration: InputDecoration(labelText: 'Masukan Telepon',
                  labelStyle: TextStyle(
                      color: Color(0xff7A869A),
                      fontWeight: FontWeight.w300,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),    
                      borderRadius: BorderRadius.circular(12),                              
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),    
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
