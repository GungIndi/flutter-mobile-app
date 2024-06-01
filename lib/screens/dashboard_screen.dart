import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_1/components/components.dart';
import 'package:project_1/screens/editMember.dart';
import 'package:project_1/screens/transaction.dart';


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
  Map<String, dynamic> saldoDataMap = {};

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
        for (var anggota in anggotaList!) {
          String id = anggota.id.toString();
          // fetch saldo
          Response response2 = await Dio().get(
            "$apiUrl/saldo/$id",
            options: Options(
              headers: {'Authorization': 'Bearer ${storage.read('token')}'},
            )
          );
          print('Response 2: $response2');
          if (response2.data['success'] == true) {
            dynamic saldoData = response2.data['data'];
            // Store saldo data in the map
            saldoDataMap[id] = FormatCurrency.convertToIdr(saldoData['saldo'],2);
          }
        }
        setState(() {
          this.anggotaList = anggotaList;
          this.saldoDataMap = saldoDataMap;
        });
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
  } on DioException catch (error) {
    print('Error occurred: ${error.response}');
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
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 20),
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
                        child: ListTile(
                          title: Text(
                            anggotaList![index].nama,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: 
                            Text(
                              '${anggotaList![index].telepon}\nSaldo: ${saldoDataMap['${anggotaList![index].id}']}'
                            ),
                            subtitleTextStyle: TextStyle(color: Colors.grey[800]),
                          trailing: Wrap(
                            spacing: 10,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TransactionScreen(id: anggotaList![index].id),
                                    ),
                                  );
                                },
                                child: Icon(Icons.attach_money_sharp)
                              ),
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
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
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