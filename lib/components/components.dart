import 'package:flutter/material.dart';
import 'package:project_1/constants.dart';

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


class InputField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final bool suffixIcon;

  const InputField({
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon = false,
  });

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: inputField,
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          suffixIcon: widget.suffixIcon
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}

class CustomCheckbox extends StatefulWidget {
  final String text;
  final Color activeColor;
  final Color inactiveColor;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const CustomCheckbox({
    required this.activeColor,
    required this.inactiveColor,
    this.text = '',
    this.value = false,
    this.onChanged,
  });

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _value = !_value;
              if (widget.onChanged != null) {
                widget.onChanged!(_value);
              }
            });
          },
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: _value ? widget.activeColor : widget.inactiveColor,
              border: Border.all(color: Colors.grey),
            ),
            child: _value
                ? Icon(
                    Icons.check,
                    size: 17,
                    color: Colors.white,
                  )
                : null,
          ),
        ),
        SizedBox(width: 8),
        Text(widget.text, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}    

class SocialMediaIcon extends StatelessWidget {
  const SocialMediaIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: CircleAvatar(
            radius: 22,
            child: Image.asset('assets/images/icons/facebook.png'),
          ),
        ),
        SizedBox(width: 12),
        IconButton(
          onPressed: () {},
          icon: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.transparent,
            child: Image.asset('assets/images/icons/google.png'),
          ),
        ),
        SizedBox(width: 12),
        IconButton(
          onPressed: () {},
          icon: CircleAvatar(
            radius: 22,
            child: Image.asset('assets/images/icons/linkedin.png'),
          ),
        ),
      ]
    );
  }
}