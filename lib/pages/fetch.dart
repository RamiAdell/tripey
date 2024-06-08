import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_app/buttons/Elv_button.dart';
import 'package:my_app/pages/thirdPage.dart';
import 'package:my_app/url/builder.dart';
import 'package:dio/dio.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class MyAppa extends StatefulWidget {
  const MyAppa({Key? key}) : super(key: key);

  @override
  State<MyAppa> createState() => _MyAppState();
}

class _MyAppState extends State<MyAppa> {
  bool isLoading = false;
  late Map<String, dynamic> responseData;
  String? x;
  var xxx = [
    'Making your itinrary',
    'Getting all Places around',
    'Almost Finished'
  ];
  @override
  void initState() {
    super.initState();
    responseData = {};
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await Dio().get(BuilderClass().buildUrl());

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        x = jsonEncode(response.data);
        BuilderClass().setFinal(x);

        setState(() {
          responseData = data;
          BuilderClass().setFinal(x);
          isLoading = false;
          xxx = ['Finished'];
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
        setState(() {
          final Map<String, dynamic> data = response.data;
          responseData = data;
          isLoading = false;
          xxx = ['Finished'];
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        isLoading = false;
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff052C47), // Start color
              Color(0xff1CB78D), // End color
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/J1AwNg6goR.json', // Replace with your animation file path
                  width: 300,
                  height: 300,
                ),
                SizedBox(height: 20),
                AnimatedTextKit(
                  isRepeatingAnimation: true,
                  animatedTexts: [
                    for (var text in xxx)
                      TyperAnimatedText(text,
                          textStyle: TextStyle(
                            fontFamily: "Teachers",
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          speed: const Duration(milliseconds: 150)),
                  ],
                ),
                SizedBox(height: 20),
                if (isLoading) ...[
                  CircularProgressIndicator(),
                  SizedBox(height: 50),
                ],
                if (!isLoading) ...[
                  ElvButtons(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return FinalPage(title: '');
                        }),
                      );
                    },
                    text: "Go to your itinerary",
                  ),
                  
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
