import 'package:flutter/material.dart';

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