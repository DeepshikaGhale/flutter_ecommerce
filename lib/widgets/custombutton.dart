import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String ?createAccountText;
  final VoidCallback onPressed;
  final bool outlineBtn;

  CustomButton({required this.createAccountText, required this.onPressed, required this.outlineBtn});

  @override
  Widget build(BuildContext context) {

    bool _outlineBtn = outlineBtn ?? false;

    return GestureDetector(
      child: Container(
        height: 60.0,
        alignment: Alignment.center,
        width: 300.0,
        decoration: BoxDecoration(
          color: _outlineBtn ? Colors.transparent : Colors.black,
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Text(
          createAccountText ?? 'Create Account Button',
          style: TextStyle(
              fontSize: 16.0, 
              color: _outlineBtn ? Colors.black : Colors.white, 
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
