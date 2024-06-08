import 'package:flutter/material.dart';
import 'package:my_app/pages/custom_drawer.dart';

class FinalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Final Page'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Text('This is the Final Page!'),
      ),
    );
  }
}
