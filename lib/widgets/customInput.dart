import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hintText;

  final Function(String) onChanged;
  bool isPassword;

  CustomInput(
      {required this.hintText,
      required this.onChanged,
      required this.isPassword});

  @override
  Widget build(BuildContext context) {
    bool _isPassword = isPassword ?? false;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      decoration: BoxDecoration(
          color: Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(12.0)),
      child: TextField(
        obscureText: _isPassword,
        onChanged: onChanged,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? 'Hint Text',
            contentPadding: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 18.0,
            )),
        style: Constants.regularDarkText,
      ),
    );
  }
}
