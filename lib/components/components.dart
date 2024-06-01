import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor; 
  final VoidCallback onPressed;

  const CustomButton({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor, 
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        side: BorderSide(color: borderColor ?? Colors.transparent), 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        minimumSize: Size(double.infinity, 56),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class DisplayImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const DisplayImage({
    Key? key,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage(imagePath),
          ),
          Container(
            child: 
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
          )
        ]
      )
    );
  }
}

class UserProfileData extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onPressed;

  const UserProfileData({
    Key? key,
    required this.title,
    required this.value,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Container(
            width: 350,
            height: 40,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 1,
                )
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: null,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 16, 
                      height: 1.4,
                      color: Colors.black
                    ),
                  )
                ),
                GestureDetector(
                  onTap: onPressed,
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                    size: 40.0,
                  ),
                )
              ]
            )
          )
        ],
      )
    );
  }
}


class Anggota {
  final int id;
  final int nomorInduk;
  final String nama;
  final String alamat;
  final String tglLahir;
  final String telepon;
  final String imageUrl;
  final int statusAktif;

  Anggota({
    required this.id,
    required this.nomorInduk,
    required this.nama,
    required this.alamat,
    required this.tglLahir,
    required this.telepon,
    required this.imageUrl,
    required this.statusAktif,
  });

  factory Anggota.fromJson(Map<String, dynamic> json) {
    return Anggota(
      id: json['id'],
      nomorInduk: json['nomor_induk'],
      nama: json['nama'],
      alamat: json['alamat'],
      tglLahir: json['tgl_lahir'],
      telepon: json['telepon'],
      imageUrl: json['image_url'] ?? '',
      statusAktif: json['status_aktif'],
    );
  }
}

class ShowDialog{
  final String text;
  final VoidCallback onPressedYes;
  final VoidCallback onPressedNo;

  const ShowDialog({
    required this.text,
    required this.onPressedYes,
    required this.onPressedNo
  });

  Future<String?> build(BuildContext context){
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[],
        ),
      );
  }
}


class CustomInputField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final bool readOnly;
  final Icon? prefixIcon;

  const CustomInputField({
    Key? key,
    this.labelText,
    this.hintText,
    required this.controller,
    this.onTap,
    this.readOnly = false,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        floatingLabelStyle: TextStyle(color: Colors.blue),
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[600],
          fontWeight: FontWeight.w300,
          fontSize: 16
        ),
        labelStyle: TextStyle(
          color: Color(0xff7A869A),
          fontWeight: FontWeight.w300,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      readOnly: readOnly,
      onTap: onTap,
    );
  }
}

class FormatCurrency {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}

class FieldHeader extends StatelessWidget {
  final String text;

  const FieldHeader({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 1.5),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w500
            ),
          ),
        )
      ],
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String value;
  final Map<String, dynamic> items;
  final ValueChanged<String?> onChanged;
  final InputDecoration? decoration;
  final Icon? icon;

  CustomDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
    this.decoration,
    this.icon = const Icon(Icons.keyboard_arrow_down),
  });
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      icon: icon,
      decoration: decoration ?? InputDecoration(
        floatingLabelStyle: TextStyle(color: Colors.blue),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      items: items.entries.map((entry) {
        return DropdownMenuItem<String>(
          value: entry.key,
          child: Text(entry.value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

class CustomModalBottomSheet extends StatelessWidget {
  final List<Widget> content;

  CustomModalBottomSheet({required this.content});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            ...content,
          ],
        ),
      ),
    );
  }
}
