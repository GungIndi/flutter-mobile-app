import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_1/components/components.dart';

class EditMemberScreen extends StatefulWidget {
  final int id;
  EditMemberScreen({Key? key, required this.id}) : super(key: key);

  @override
  _EditMemberScreenState createState() => _EditMemberScreenState(id: id);
}

class _EditMemberScreenState extends State{
  final int id;
  _EditMemberScreenState({required this.id});

  final apiUrl = 'https://mobileapis.manpits.xyz/api';
  final dio = Dio();
  final storage = GetStorage();
  Map<String, dynamic>? anggota; 

  final TextEditingController nomorIndukController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController tglLahirController = TextEditingController();
  final TextEditingController teleponController = TextEditingController();

  Future<void> fetchData(id) async {
    try {
      Response response = await Dio().get(
        "$apiUrl/anggota/$id",
        options: Options(
          headers: {'Authorization': 'Bearer ${storage.read('token')}'},
        ),
      );
      print('Response: $response');
      if (response.data['success'] == true) {
        Map<String, dynamic> data = response.data;
        anggota = data['data']['anggota'];
        print('Anggota: $anggota');
        setState(() {});
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Member',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        toolbarHeight: 75,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        // automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: anggota == null
          ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          )
          : SingleChildScrollView(
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
                        labelText: anggota!['nomor_induk'].toString(),
                        labelStyle: TextStyle(
                          color: Colors.black,
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
                        labelText: anggota!['nama'],
                        labelStyle: TextStyle(
                          color: Colors.black,
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
                        labelText: anggota!['alamat'],
                        labelStyle: TextStyle(
                          color: Colors.black,
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
                        labelText: anggota!['tgl_lahir'],
                        labelStyle: TextStyle(
                          color: Colors.black,
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
                      decoration: InputDecoration(
                          labelText: anggota!['telepon'],
                        labelStyle: TextStyle(
                          color: Colors.black,
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
                      text: 'Edit Member', 
                      backgroundColor: Colors.blue, 
                      textColor: Colors.white, 
                      onPressed: (){
                        // getMemberById(context,1);
                      }
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}
