import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_1/components/components.dart';
import 'package:project_1/screens/editMember.dart';


class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

   @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State{
  final apiUrl = 'https://mobileapis.manpits.xyz/api';
  final dio = Dio();
  final storage = GetStorage();
  List<Anggota>? anggotaList; 

  Future<void> fetchData() async {
    try {
      Response response = await Dio().get(
        "$apiUrl/anggota",
        options: Options(
          headers: {'Authorization': 'Bearer ${storage.read('token')}'},
        ),
      );
      print('Response: $response');
      if (response.data['success'] == true) {
        List<dynamic> anggotaData = response.data['data']['anggotas'];
        anggotaList = anggotaData.map((data) => Anggota.fromJson(data)).toList();
        setState(() {});
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }
 
  void deleteAnggota(context, id) async {
  final dio = Dio();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';
  final storage = GetStorage();

  try{
    final response = await dio.delete(
      "$apiUrl/anggota/$id",
      options: Options(
        headers: {'Authorization' : 'Bearer ${storage.read('token')}'}
      )
    );
    setState(() {});
    print(response.data);
    if (response.data['success'] == true) {
      Navigator.pushReplacementNamed(context, '/buttom');
    }
  } on DioException catch (e){
    print(e.message);
  }
  
}

  @override
  void initState() {
    super.initState();
    fetchData();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'List Anggota',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        toolbarHeight: 75,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
          child: anggotaList != null
              ? ListView.builder(
                  itemCount: anggotaList!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: ListTile(
                            title: Text(
                              anggotaList![index].nama,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text('${anggotaList![index].alamat}\n${anggotaList![index].telepon}'),
                            trailing: Wrap(
                              spacing: 15, // space between two icons
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditMemberScreen(id: anggotaList![index].id),
                                      ),
                                    );
                                  },
                                  child: Icon(Icons.edit)
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        title: const Text('Are you sure?'),
                                        content: const Text('you cannot restore this member'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, 'No'),
                                            child: const Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () => deleteAnggota(context, anggotaList![index].id),
                                            child: const Text('Yes'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Icon(Icons.delete)
                                ),
                              ],
                            ),
                            
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 17.0, 17.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/addMember'
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

void logout(context) async {
  final dio = Dio();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';
  final storage = GetStorage();
  try{
    final response = await dio.get(
      "$apiUrl/logout", 
      options : Options(
        headers: {'Authorization' : 'Bearer ${storage.read('token')}'})
    );
    print(response.data);
    storage.remove('token');

    if (response.data['success'] == true) {
      Navigator.pushNamed(
        context,
        '/login'
      );
    }
  } on DioException catch (e){
    print(e.response);
  }
}