import 'package:flutter/material.dart';
import 'package:project_1/components/addTransactionModal.dart';
import 'package:project_1/components/components.dart';
import 'package:project_1/data/model/member_model.dart';
import 'package:project_1/data/model/transaction_model.dart';
import 'package:project_1/data/services/member_service.dart';
import 'package:project_1/data/services/transaction_service.dart';
import 'package:project_1/screens/memberProfileScreen.dart';
import 'package:project_1/utils/utils.dart';

class TransactionScreen extends StatefulWidget {
  final int id;
  TransactionScreen({Key? key, required this.id}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState(id: id);
}

class _TransactionScreenState extends State<TransactionScreen> {
  final int id;
  _TransactionScreenState({required this.id});
  
  final TextEditingController trxNominalController = TextEditingController();
  final TransactionService transactionService = TransactionService();

  final MemberService memberService = MemberService(); 

  String dropDownValue = '1';
  List<Transaction>? tabungan;
  int? saldoData;
  Member? member;

  Future<void> fetchData(int id) async {
    try {
      List<Transaction> transactions = await transactionService.fetchData(context, id);
      int? saldo = await transactionService.fetchDataSaldo(context, id);
      Member? member = await memberService.fetchMember(context, id);
      setState(() {
        tabungan = transactions;
        saldoData = saldo;
        this.member = member;
      });
    } catch (error) {
      print('Error fetching transaction: $error');
    }
  }

  // Future<void> fetchDataMember(id) async {
  //   try {
  //     Member? member = await memberService.fetchMember(context, id);
  //     setState(() {
  //       this.member = member;
  //     });
  //   } catch (error) {
  //     print('Error fetching members: $error');
  //   }
  // }

  Future<void> addTransaction(int id) async {
    try {
      await transactionService.addTransaction(context, id, dropDownValue, trxNominalController.text);
      fetchData(id);
      
    } catch (error) {
      print('Error fetching transaction: $error');
    }
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AddTransactionModal(
          id: id,
          onTransactionAdded: () {
            fetchData(id);
          },
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
          member == null ? 'Tabungan' : 'Tabungan ${member!.nama}',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        toolbarHeight: 75,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
           Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MemberProfileScreen(id: id),
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: tabungan == null || saldoData == null || member == null
            ? Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        )
            : SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
              child: tabungan!.length != 0 ? Column(
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
                        '${FormatCurrency.convertToIdr(saldoData!, 2)}',
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
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: tabungan!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: ListTile(
                              leading: tabungan![index].transactionId == 3 ? Icon(Icons.money_off_csred) : Icon(Icons.payment_sharp),
                              title: Text(
                                getTransactionType(tabungan![index].transactionId),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                '${tabungan![index].date.toString()}',
                                style: TextStyle(
                                  color: Colors.grey[800]
                                  )
                                ),
                              trailing: tabungan![index].transactionId == 3 || tabungan![index].transactionId == 6
                                  ? Text(
                                  ' -${FormatCurrency.convertToIdr(tabungan![index].transactionNominal, 0)}',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600
                                  ))
                                  : Text(
                                  ' +${FormatCurrency.convertToIdr(tabungan![index].transactionNominal, 0)}',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600
                                  )),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ) 
              : Container(
                  width: 400,
                  height: 600,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Icon(Icons.search, size: 300, color: Colors.blue[300])
                      ),
                      Text(
                        'Tidak ada transaksi',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Silahkan tambah transaksi baru.',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
          ), 
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
