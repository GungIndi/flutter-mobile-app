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
      return 'Non Aktif';
    default:
      return 'Unknown';
  }
}

String mapInterestStatus(int statusId) {
  switch (statusId) {
    case 0:
      return 'Non Aktif';
    case 1:
      return 'Aktif';
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
    lastDate: DateTime.now(),
    builder:(context , child){
      return Theme(
        data: Theme.of(context).copyWith(  // override MaterialApp ThemeData
          colorScheme: ColorScheme.light(
            primary: Colors.white,  //header and selced day background color
            onPrimary: Colors.blue, // titles and 
            onSurface: Colors.black, // Month days , years 
          ),
          dialogBackgroundColor:Colors.blue,
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black, // ok , cancel    buttons
            ),
          ),
        ),
        child: child!   
      );
    }
    );

  return selectedDate;
}