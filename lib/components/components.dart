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
  final double radius;

  const DisplayImage({
    Key? key,
    required this.imagePath,
    required this.onPressed,
    required this.radius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: radius,
            backgroundImage: AssetImage(imagePath),
          ),
          // Container(
          //   child: 
          //     Container(
          //       padding: EdgeInsets.all(4),
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(20),
          //       ),
          //       child: Icon(
          //         Icons.edit,
          //         color: Colors.blue,
          //       ),
          //     ),
          // )
        ]
      )
    );
  }
}

class UserProfileData extends StatelessWidget {
  final String title;
  final String value;

  const UserProfileData({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
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
                // GestureDetector(
                //   onTap: onPressed,
                //   child: Icon(
                //     Icons.keyboard_arrow_right,
                //     color: Colors.grey,
                //     size: 40.0,
                //   ),
                // )
              ]
            )
          )
        ],
      )
    );
  }
}

class CustomShowDialog {
  final String text;
  final String? yesText;
  final String? noText;
  final VoidCallback onPressedYes;
  final VoidCallback onPressedNo;

  CustomShowDialog({
    required this.text,
    required this.onPressedYes,
    required this.onPressedNo,
    this.noText,
    this.yesText
  });

  Future<void> show(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Confirmation'),
        content: Text(text),
        actions: <Widget>[
          TextButton(
            onPressed: onPressedNo,
            child: Text(noText!)
          ),
          TextButton(
            onPressed: onPressedYes,
            child: Text(yesText!)
          ),
        ],
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
  final double? height;

  CustomModalBottomSheet({
    required this.content,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height == null ? 400 : height,
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

void showCustomSnackBar(BuildContext context, String message, {Color backgroundColor = Colors.black}) {
  final snackBar = CustomSnackBar(
    content: Text(message),
    backgroundColor: backgroundColor,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    Key? key,
    required Widget content,
    Color? backgroundColor,
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? width,
    ShapeBorder? shape,
    SnackBarBehavior? behavior,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 3),
    Animation<double>? animation,
    VoidCallback? onVisible,
  }) : super(
          key: key,
          content: content,
          backgroundColor: backgroundColor,
          elevation: elevation,
          margin: margin,
          padding: padding,
          width: width,
          shape: shape,
          behavior: behavior,
          action: action,
          duration: duration,
          animation: animation,
          onVisible: onVisible,
        );
}
