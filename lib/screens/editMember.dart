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
  }

  void editMember(BuildContext context, id) async {
    try {
      final response = await dio.put(
        "$apiUrl/anggota/$id",
        data: {
          "nomor_induk": nomorIndukController.text.isNotEmpty ? nomorIndukController.text : anggota!['nomor_induk'],
          "nama": namaController.text.isNotEmpty ? namaController.text : anggota!['nama'],
          "alamat": alamatController.text.isNotEmpty ? alamatController.text : anggota!['alamat'],
          "tgl_lahir": tglLahirController.text.isNotEmpty ? tglLahirController.text : anggota!['tgl_lahir'],
          "telepon": teleponController.text.isNotEmpty ? teleponController.text : anggota!['telepon'],
        },
        options: Options(
          headers: {'Authorization': 'Bearer ${storage.read('token')}'},
        ),
      );
      print(response.data);
      if (response.data['success'] == true) {
        setState(() {});
        Navigator.pushReplacementNamed(context, '/buttom');
      }
    } on DioException catch (error) {
      print('Error occurred: ${error.response}');

      if (error.response != null && error.response!.data is Map<String, dynamic>) {
        String errorMessage = error.response!.data['message'];
        if (error.response!.data['message'] != null && error.response!.data['message'].contains('Invalid datetime format')) {
          if(error.response!.data['message'].contains('Incorrect integer value')){
            errorMessage = 'Nomor Induk must be an integer';
          } else {
            errorMessage = 'Tanggal lahir must be a date';
          }
        }
        if (error.response!.data['message'] != null && error.response!.data['message'].contains('Integrity constraint violation')) {
          errorMessage = 'Nomor Induk Already Registered!';
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
                        hintText: anggota!['nomor_induk'].toString(),
                        hintStyle: TextStyle(
                          color: Colors.grey[800],
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
                    TextFormField(
                      controller: namaController,
                      decoration: InputDecoration(
                        hintText: anggota!['nama'],
                        hintStyle: TextStyle(
                          color: Colors.grey[800],
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
                        hintText: anggota!['alamat'].toString(),
                        hintStyle: TextStyle(
                          color: Colors.grey[800],
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
                        labelText: anggota!['tgl_lahir'].toString(),
                        floatingLabelStyle: TextStyle(color: Colors.blue),
                        prefixIcon: Icon(Icons.calendar_today),
                        labelStyle: TextStyle(
                          color: Colors.grey[800],
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
                        hintText: anggota!['telepon'].toString(),
                        hintStyle: TextStyle(
                          color: Colors.grey[800],
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
                      text: 'Edit Member', 
                      backgroundColor: Colors.blue, 
                      textColor: Colors.white, 
                      onPressed: (){
                        editMember(context, id);
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
