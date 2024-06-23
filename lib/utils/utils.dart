import 'package:flutter/material.dart';

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

String mapMemberStatus(int statusId) {
  switch (statusId) {
    case 1:
      return 'Aktif';
    case 2:
      return 'Tidak Aktif';
    default:
      return 'Unknown';
  }
}

void showCustomSnackBar2(BuildContext context, String message, {Color backgroundColor = Colors.red}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ),
  );
}

Future<DateTime?> selectDate(BuildContext context) async {
  DateTime? selectedDate = await showDatePicker(
    context: context, 
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2100)
  );

  return selectedDate;
}