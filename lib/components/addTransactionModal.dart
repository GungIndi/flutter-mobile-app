import 'package:flutter/material.dart';
import 'package:project_1/components/components.dart';
import 'package:project_1/data/services/transaction_service.dart';

class AddTransactionModal extends StatefulWidget {
  final int id;
  final Function onTransactionAdded;

  AddTransactionModal({required this.id, required this.onTransactionAdded});

  @override
  _AddTransactionModalState createState() => _AddTransactionModalState();

  static void addTransaction(BuildContext context) {}
}

class _AddTransactionModalState extends State<AddTransactionModal> {
  final TransactionService transactionService = TransactionService();
  final TextEditingController trxNominalController = TextEditingController();

  String dropDownValue = '1';
  var items = {
    '1': 'Saldo awal',
    '2': 'Simpanan',
    '3': 'Penarikan',
    '5': 'Koreksi Penambahan',
    '6': 'Koreksi Pengurangan',
  };

  Future<void> addTransaction(int id) async {
    try {
      await transactionService.addTransaction(context, id, dropDownValue, trxNominalController.text);
      widget.onTransactionAdded();
    } catch (error) {
      print('Error fetching transaction: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomModalBottomSheet(
      content: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
          mainAxisAlignment: MainAxisAlignment.start,
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
          mainAxisAlignment: MainAxisAlignment.start,
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
          onChanged: (String? value) {
            setState(() {
              dropDownValue = value!;
            });
          },
        ),
        SizedBox(height: 20),
        CustomButton(
          text: 'Tambah',
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          onPressed: () {
            addTransaction(widget.id);
          }
        )
      ],
    );
  }
}