import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_app/pages/firstPage.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/pages/secpage.dart';
import 'package:my_app/pages/fourthPage.dart';
import 'package:my_app/pages/selectLocation.dart';
import 'package:my_app/pages/FinalPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'loginPage',
      routes: {
        'firstPage': (context) => FirstPage(),
        'loginPage': (context) => loginPage(),
        'secondPage': (context) => SecondPage(),
        'googleMapsPage': (context) => GoogleMapsPage(),
        'finalPage': (context) => FinalPage(),
      },
    );
  }
}
