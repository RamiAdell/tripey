import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Text_Button extends StatelessWidget {
  Text_Button({required this.text1, required this.text2, required this.onTap});

  String text1;
  String text2;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: TextStyle(
            fontFamily: "Teachers",
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            text2,
            style: TextStyle(
              fontFamily: "Teachers",
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xff1CB78D),
            ),
          ),
        ),
      ],
    );
  }
}
