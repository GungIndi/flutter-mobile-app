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
  dynamic saldoData;

  String dropDownValue = '1';
  var items = {
    '1' : 'Saldo awal',
    '2' : 'Simpanan',
    '3' : 'Penarikan',
    // '4' : 'Bunga Simpanan',
    '5' : 'Koreksi Penambahan',
    '6' : 'Koreksi Pengurangan',
  };

  String getTransactionType(int trxId) {
    switch (trxId) {
      case 1:
        return 'Saldo Awal';
      case 2:
        return 'Simpanan';
      case 3:
        return 'Penarikan';
      case 4:
        return 'Bunga Simpanan';
      case 5:
        return 'Koreksi Penambahan';
      case 6:
        return 'Koreksi Pengurangan';
      default:
        return 'Unknown';
    }
  }

  void addTransaction(BuildContext context) async {
    try{
      final response = await dio.post(
        '$apiUrl/tabungan',
        data: {
          "anggota_id" : id,
          "trx_id" : dropDownValue,
          "trx_nominal" : trxNominalController.text
        },
        options: Options(
          headers: {'Authorization' : 'Bearer ${storage.read('token')}'}
        )
      );
      if (response.data['success'] == true) {
        Navigator.pop(context);
        fetchData(id);
      }
      if(response.data['success'] ==  false){
        String errorMessage = response.data['message'];
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
    } on DioException catch (error){
      // print(error.response!.data['message']);
      String errorMessage = error.response!.data['message'].toString();
      print('asdjaldjlsa: $errorMessage');
      if (error.response != null && error.response!.data is Map<String, dynamic>) {
        print('halooii');
        if (error.response!.data['message'] != null && error.response!.data['message'].contains('trx nominal field is required')) {
          errorMessage = 'Nominal Field is Required';
        } else if (error.response!.data['message'].contains('must be a number')){
          errorMessage = 'Nominal field must be a number!';
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

  final TextEditingController trxNominalController = TextEditingController();
  final TextEditingController trxIdController = TextEditingController();

  Future<void> fetchData(id) async {
    try {
      // Fetch tabungan
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
      }
      // Fetch saldo
      Response response2 = await Dio().get(
        "$apiUrl/saldo/$id",
        options: Options(
          headers: {'Authorization': 'Bearer ${storage.read('token')}'},
        )
      );
      print('Response 2: $response2');
      if (response2.data['success'] == true) {
        saldoData = response2.data['data']['saldo'];
      }
      setState(() {});

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
  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CustomModalBottomSheet(
          content: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center  ,
              children: [
                Text(
                  'Tambah Transaksi',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.start  ,
              children: [
                Text(
                  'Nominal',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            CustomInputField(
              hintText: 'Masukan Nominal', 
              controller: trxNominalController,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start  ,
              children: [
                Text(
                  'Jenis Transaksi',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            CustomDropdown(
              value: '1',
              items: items,
              onChanged: (String?  value) {
                setState(() {
                  dropDownValue = value!;
                  print(dropDownValue);
                });
              },
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Tambah', 
              backgroundColor: Colors.blue, 
              textColor: Colors.white, 
              onPressed: () {
                addTransaction(context);
              }
            )
          ],
        );
      },
    );
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
          : Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Total Saldo',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${FormatCurrency.convertToIdr(saldoData, 2)}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Histori',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: tabungan!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: ListTile(
                                leading: tabungan![index]['trx_id'] == 3 ? Icon(Icons.money_off_csred) : Icon(Icons.payments_sharp),
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
                                      ))
                                  : Text(
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
                    ),
                  ),
                ],
              )
          ),
        ),
        floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 17.0, 17.0),
        child: FloatingActionButton(
          foregroundColor: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          onPressed: () {
            _showModalBottomSheet(context);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blue[400],
        ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
  }
}
