import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:my_app/buttons/Elv_button.dart';
import 'package:my_app/menu/dropdown.dart';
import 'package:my_app/pages/secpage.dart';
import 'package:my_app/pages/selectLocation.dart';
import 'package:my_app/url/builder.dart';

class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final TextEditingController _startSearchFieldController =
      TextEditingController();
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? _debounce;
  int D = 0;
  int A = 0;
  @override
  void initState() {
    D = 0;
    A = 0;
    super.initState();
    String apiKey = 'AIzaSyCEiN_zfOmYirRa2c2gbhumce4S0kz7n9E';
    googlePlace = GooglePlace(apiKey);
  }

  Future<void> fetchPlaceDetails(String placeId) async {
    var result = await googlePlace.details.get(placeId);
    if (result != null && result.result != null && mounted) {
      var lat = result.result!.geometry!.location!.lat;
      var lng = result.result!.geometry!.location!.lng;

      BuilderClass().setLat(lat!);
      BuilderClass().setLng(lng!);

      print('Address: ${BuilderClass().getLng()}, ${BuilderClass().getLat()},');
    }
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeff7f1),
      appBar: AppBar(
        backgroundColor: Color(0xffeff7f1),
        leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Text(
            'Plan your next adventure',
            style: TextStyle(
              fontFamily: "Teachers",
              color: Color(0xff052C47),
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Image.asset("assets/xyz.png"),
          SizedBox(
            height: 25,
          ),
          Text(
            'Where do you want to go?',
            style: TextStyle(
              color: Color(0xff052C47),
              fontFamily: "Teachers",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          MyDropDown(
            text: 'Select number of days',
            list: [
              'One',
              'Two',
              'Three',
              'Four',
              'Five',
              'Six',
              'Seven',
              'Eight',
              'Nine'
            ],
          ),
          SizedBox(height: 20),
          MyDropDown(
            text: 'Select number of activities',
            list: ['One', 'Two', 'Three'],
          ),
          SizedBox(height: 15),
          TextField(
            controller: _startSearchFieldController,
            autofocus: false,
            style: TextStyle(
                fontFamily: "Teachers",
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff052C47)),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    
                    if (MyDropDown.daysSelectedIndex == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please choose number of days'),
                  ),
                );
              } else if (MyDropDown.activitiesSelectedIndex == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please choose number of activities'),
                  ),
                );
              }else {
                
              days = MyDropDown.daysSelectedIndex! + 1;
              act = MyDropDown.activitiesSelectedIndex! + 1;

                print(BuilderClass().buildUrl());
                for (int i = 0; i <= 6; i++) {
                  BuilderClass().setArr(i, false);
                }
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return GoogleMapsPage();
                    }));
              
              }

                    


                    
                  },
                  icon: Icon(Icons.gps_fixed)),
              hintText: 'Type your Location',
              hintStyle: const TextStyle(
                  fontFamily: "Teachers",
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            onChanged: (value) {
              if (_debounce?.isActive ?? false) _debounce!.cancel();
              _debounce = Timer(const Duration(milliseconds: 1000), () {
                if (value.isNotEmpty) {
                  autoCompleteSearch(value);
                } else {
                  setState(() {
                    predictions.clear();
                  });
                }
              });
            },
          ),
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            itemCount: predictions.length,
            itemBuilder: (context, index) {
              final prediction = predictions[index];
              return ListTile(
                title: Text(prediction.description.toString(),
                    style: TextStyle(
                        fontFamily: "Teachers", fontWeight: FontWeight.w600)),
                onTap: () async {
                  _startSearchFieldController.text =
                      prediction.description.toString();
                  await fetchPlaceDetails(prediction.placeId!);
                  setState(() {
                    predictions.clear();
                  });
                },
              );
            },
          ),
          SizedBox(height: 20),
          ElvButtons(
            text: 'Continue',
            onPressed: () {
              int? daysSelectedIndex = MyDropDown.daysSelectedIndex;
              int? activitiesSelectedIndex = MyDropDown.activitiesSelectedIndex;

              if (daysSelectedIndex == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please choose number of days'),
                  ),
                );
              } else if (activitiesSelectedIndex == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please choose number of activities'),
                  ),
                );
              } else if (BuilderClass().getLng() == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please choose Location'),
                  ),
                );
              } else {
                print('Number of days: $daysSelectedIndex');
                print('Number of activities: $activitiesSelectedIndex');
                days = daysSelectedIndex + 1;
                act = activitiesSelectedIndex + 1;

                print(BuilderClass().buildUrl());
                for (int i = 0; i <= 6; i++) {
                  BuilderClass().setArr(i, false);
                }
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SecondPage();
                }));
              }
            },
          ),
        ],
      ),
    );
  }
}
