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
