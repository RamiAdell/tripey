import 'package:flutter/material.dart';
import 'package:my_app/buttons/Elv_button.dart';
import 'package:my_app/menu/slider.dart';
import 'package:my_app/pages/fetch.dart';
import 'package:my_app/url/builder.dart';

class fourthPage extends StatefulWidget {
  const fourthPage({Key? key}) : super(key: key); // Fix the constructor

  @override
  State<fourthPage> createState() => _fourthPageState();
}

class _fourthPageState extends State<fourthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeff7f1),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xff052C47)),
        backgroundColor: Color(0xffeff7f1),
        title: Text(
          'Your Meal Preferences',
          style: TextStyle(
              color: Color(0xff052C47),
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: "Teachers"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Meals preferences',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Teachers",
                        color: Color(0xff052C47)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Select your budget for your food you prefer.',
                    style: TextStyle(
                      color: Color(0xff052C47),
                      fontSize: 18,
                      fontFamily: "Teachers",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Budget level',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Teachers",
                        color: Color(0xff052C47)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Depending on the budget level, ',
                        style: TextStyle(
                          color: Color(0xff052C47),
                          fontSize: 18,
                          fontFamily: "Teachers",
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'We will select least or more expensive',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Teachers",
                          color: Color(0xff052C47),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'restaurants.',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Teachers",
                          color: Color(0xff052C47),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            SliderExample(),
            SizedBox(
              height: 50,
            ),
            ElvButtons(
              text: 'Done',
              onPressed: () {
                print("objectobjectobjectobjectobjectobjectobject");
                print(BuilderClass().buildUrl());

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyAppa();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
