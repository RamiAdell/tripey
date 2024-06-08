import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ElvButtons extends StatelessWidget {
  final String text;
   Function() onPressed; // Added onPressed parameter

  ElvButtons({
    required this.text,
    
   required this.onPressed, // Added this line
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xff052C47)),
        ),
        onPressed: onPressed, // Call onPressed when button is pressed
        child: Text(
          text,
          style: TextStyle(color: Colors.white , fontFamily: "Teachers" , fontSize: 18),
        ),
      ),
    );
  }
}
