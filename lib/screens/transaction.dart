import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_1/components/components.dart';

class TransactionScreen extends StatefulWidget {
  final int id;
  TransactionScreen({Key? key, required this.id}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState(id: id);
}

class _TransactionScreenState extends State{
  final int id;
  _TransactionScreenState({required this.id});

  final apiUrl = 'https://mobileapis.manpits.xyz/api';
  final dio = Dio();
  final storage = GetStorage();
  List<Map<String, dynamic>>? tabungan;

  String dropDownValue = '1';
  var items = [
    '1',
    '2',
    '3',
  ];

   String getTransactionType(int trxId) {
    switch (trxId) {
      case 1:
        return 'Saldo Awal';
      case 2:
        return 'Simpanan';
      case 3:
        return 'Penarikan';
      default:
        return 'Unknown';
    }
  }
  final TextEditingController nomorIndukController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController tglLahirController = TextEditingController();
  final TextEditingController teleponController = TextEditingController();

  Future<void> fetchData(id) async {
    try {
      Response response = await Dio().get(
        "$apiUrl/tabungan/$id",
        options: Options(
          headers: {'Authorization': 'Bearer ${storage.read('token')}'},
        ),
      );
      print('Response: $response');
      if (response.data['success'] == true) {
        tabungan = List<Map<String, dynamic>>.from(response.data['data']['tabungan']);
        print('TABUNGAN: $tabungan');
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

  @override
  void initState() {
    super.initState();
    fetchData(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Tabungan',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        toolbarHeight: 75,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: tabungan == null
          ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          )
          : SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
              child: ListView.builder(
                itemCount: tabungan!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: ListTile(
                          title: Text(
                            getTransactionType(tabungan![index]['trx_id']),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: 
                            Text(
                              '${tabungan![index]['trx_tanggal'].toString()}'
                            ),  
                            subtitleTextStyle: TextStyle(color: Colors.grey[800]),
                          trailing: tabungan![index]['trx_id'] == 3
                            ? Text(
                                ' -${FormatCurrency.convertToIdr(tabungan![index]['trx_nominal'], 0)}',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600
                                )
                            ) : Text(
                                  ' +${FormatCurrency.convertToIdr(tabungan![index]['trx_nominal'], 0)}',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600
                                  )
                            ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ),
          ),
        ),
      );
  }
}
