import 'package:flutter/material.dart';
import 'package:my_app/pages/custom_drawer.dart';
import 'package:my_app/buttons/Elv_button.dart';
import 'package:my_app/buttons/toggle_button.dart';
import 'package:my_app/pages/fetch.dart';
import 'package:my_app/pages/fourthPage.dart';
import 'package:my_app/url/builder.dart';

class SecondPage extends StatefulWidget {
  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List<bool> toggledStates =
      List.generate(7, (index) => false); // List to store toggle states

  void toggleButtonState(int index, bool newState) {
    setState(() {
      toggledStates[index] = newState; // Update toggle state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeff7f1),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xff052C47)),
        backgroundColor: Color(0xffeff7f1),
        title: Text(
          'Add your Preferences',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Teachers",
            fontSize: 22,
            color: Color(0xff052C47),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Text(
                '   What kind of activities ',
                style: TextStyle(
                  color: Color(0xff052C47),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Teachers",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '   are you looking for?',
                style: TextStyle(
                  color: Color(0xff052C47),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Teachers",
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleButtonExample(
                    text: 'Restaurants',
                    icon: Icons.restaurant,
                    index: 0,
                    onToggle: toggleButtonState,
                    initialState: toggledStates[0],
                  ),
                  ToggleButtonExample(
                    text: 'Historical',
                    icon: Icons.history,
                    index: 1,
                    onToggle: toggleButtonState,
                    initialState: toggledStates[1],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleButtonExample(
                    text: 'Shopping',
                    icon: Icons.shopping_bag,
                    index: 2,
                    onToggle: toggleButtonState,
                    initialState: toggledStates[2],
                  ),
                  ToggleButtonExample(
                    text: 'Museums',
                    icon: Icons.museum,
                    index: 3,
                    onToggle: toggleButtonState,
                    initialState: toggledStates[3],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleButtonExample(
                    text: 'Amusement Parks',
                    icon: Icons.games,
                    index: 4,
                    onToggle: toggleButtonState,
                    initialState: toggledStates[4],
                  ),
                  ToggleButtonExample(
                    text: 'Parks',
                    icon: Icons.park,
                    index: 5,
                    onToggle: toggleButtonState,
                    initialState: toggledStates[5],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ToggleButtonExample(
                text: 'Natural Features',
                icon: Icons.grass,
                index: 6,
                onToggle: toggleButtonState,
                initialState: toggledStates[6],
              ),
              SizedBox(
                height: 70,
              ),
              ElvButtons(
                text: '    Continue    ',
                onPressed: () {
                  if (BuilderClass().getVal() == 1) {
                    if (BuilderClass().get() == 1) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return fourthPage();
                      }));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MyAppa();
                      }));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Please choose more categories to continue'),
                      ),
                    );
                  }
                  // Output the toggled indexes
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
