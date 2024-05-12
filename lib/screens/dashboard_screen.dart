import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_1/components/components.dart';


class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

   @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State{
  final apiUrl = 'https://mobileapis.manpits.xyz/api';
  final dio = Dio();
  final storage = GetStorage();
  List<Anggota>? anggotaList; // Change to List<Anggota>?

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
                                    Navigator.pushReplacementNamed(context, '/register');
                                  },
                                  child: Icon(Icons.edit)
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(context, '/register');
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
    );
  }
}
