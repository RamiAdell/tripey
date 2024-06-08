import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_app/pages/custom_drawer.dart';
import 'package:my_app/buttons/Elv_button.dart';
import 'package:my_app/pages/secpage.dart';
import 'package:my_app/url/builder.dart';

class GoogleMapsPage extends StatefulWidget {
  @override
  _GoogleMapsPageState createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  final places = GoogleMapsPlaces(apiKey: 'AIzaSyDWZMm53Euuzmg7H0UGbY5TFN-O7LBmf8Y');
  GoogleMapController? _controller;
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation().then((value) {
      _moveToCurrentLocation(value);
    }).catchError((error) {
      print(error);
    });
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions are denied.");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are permanently denied.");
    }
    return await Geolocator.getCurrentPosition();
  }

  void _moveToCurrentLocation(Position position) {
    final LatLng currentLatLng = LatLng(position.latitude, position.longitude);
    _controller?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: currentLatLng, zoom: 14.0),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search for places...',
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Implement search functionality here
              },
            ),
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
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194), // Default location: San Francisco
          zoom: 10.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_searching),
        onPressed: () async {
          try {
            Position position = await _getCurrentLocation();
            _moveToCurrentLocation(position);
          } catch (error) {
            print(error);
          }
        },
      ),
    );
  }
}
