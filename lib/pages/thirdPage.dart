import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_app/url/builder.dart';

class FinalPage extends StatefulWidget {
  const FinalPage({super.key, required this.title});

  final String title;

  @override
  State<FinalPage> createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage> {
  late List<Day> days;
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  Map<String, BitmapDescriptor> markerIcons = {};
  void _initializeMarkerIcons() {
    markerIcons["Day 1"] =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    markerIcons["Day 2"] =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
    markerIcons["Day 3"] =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    markerIcons["Day 4"] =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
    markerIcons["Day 5"] =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
    markerIcons["Day 6"] =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
    markerIcons["Day 7"] =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan);
    markerIcons["Day 8"] =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);
    markerIcons["Day 9"] =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);
  }

  void _initializeMarkers() {
    for (var day in days) {
      for (var activity in day.activities) {
        BitmapDescriptor markerIcon =
            markerIcons[day.title] ?? BitmapDescriptor.defaultMarker;
        markers.add(Marker(
          markerId: MarkerId(activity.id.toString()),
          position: LatLng(activity.lat, activity.lng),
          icon: markerIcon,
          infoWindow:
              InfoWindow(title: activity.name, snippet: activity.content),
        ));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    days = []; // Initialize days list
    _initializeMarkerIcons();
    _initializeMarkers();

    String jsonData = BuilderClass().getFinalTest();

    Map<String, dynamic> jsonMap = jsonDecode(jsonData);
    days = jsonMap.entries
        .map((entry) => Day(
              title: entry.key,
              activities: (entry.value as List)
                  .map((activityJson) => Activity.fromJson(activityJson))
                  .toList(),
            ))
        .toList();

    // Initialize markers
    _initializeMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeff7f1),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xff052C47)),
        title: const Text(
          'Your itinerary',
          style: TextStyle(
              color: Color(0xff052C47),
              fontFamily: "Teachers",
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xffeff7f1),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
               
              myLocationButtonEnabled: true,
              padding: EdgeInsets.symmetric(horizontal: 10),
              onMapCreated: (controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: const LatLng(30.05029979999999, 31.2643175),
                zoom: 12,
              ),
              markers: markers,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: days.length,
              itemBuilder: (context, index) {
                final day = days[index];
                return ExpandableItem(
                    day: day, onLocationSelected: _onLocationSelected);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onLocationSelected(double lat, double lng) {
    mapController.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
  }
}

class ExpandableItem extends StatefulWidget {
  final Day day;
  final Function(double, double) onLocationSelected;

  const ExpandableItem({
    required this.day,
    required this.onLocationSelected,
  });

  @override
  _ExpandableItemState createState() => _ExpandableItemState();
}

class _ExpandableItemState extends State<ExpandableItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(20),
        curve: Curves.fastLinearToSlowEaseIn,
        duration: const Duration(milliseconds: 1000),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: isExpanded
                  ? Color(0xff1CB78D).withOpacity(0.7)
                  : Color(0xff052C47).withOpacity(0.8),
              blurRadius: 20,
              offset: const Offset(5, 10),
            ),
          ],
          color: isExpanded ? Color(0xff1CB78D) : Color(0xff052C47),
          borderRadius: BorderRadius.circular(isExpanded ? 15 : 25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.day.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "Teachers",
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            if (isExpanded)
              Column(
                children: widget.day.activities.map((activity) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 9),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                activity.name,
                                style: const TextStyle(
                                    fontFamily: "Teachers",
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                activity.content,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 13),
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            widget.onLocationSelected(
                                activity.lat, activity.lng);
                          },
                          child: Text(
                            'Show on Map',
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Colors.white,
              size: 27,
            ),
          ],
        ),
      ),
    );
  }
}

class Day {
  final String title;
  final List<Activity> activities;

  Day({
    required this.title,
    required this.activities,
  });
}

class Activity {
  final String name;
  final double id;
  final String content;
  final String imgUrl;
  final double lat;
  final double lng;

  Activity({
    required this.name,
    required this.id,
    required this.content,
    required this.imgUrl,
    required this.lat,
    required this.lng,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    final geometry = json['geometry'];
    final location = geometry?['location'];
    final lat = location?['lat'] as double?;
    final lng = location?['lng'] as double?;

    return Activity(
      name: json['name'] ?? '',
      id: json['id'] is int
          ? (json['id'] as int).toDouble()
          : json['id'] ?? 0.0,
      content: json['vicinity'] ?? '',
      imgUrl: json['img_url'] ?? '',
      lat: lat ?? 0.0,
      lng: lng ?? 0.0,
    );
  }
}
