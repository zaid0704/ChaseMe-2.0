import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position _currentPosition = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentPosition != null)
              Text(
                  "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
            FlatButton(
              child: Text("Get location"),
              onPressed: () {
                _getCurrentLocation();
              },
            ),
          ],
        ),
      ),
    );
  }

  _getCurrentLocation()async {
    // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    // print("1");
    // geolocator
    //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
    //     .then((Position position) {
    //       print("2");
    //   setState(() {
    //     _currentPosition = position;
    //   });
    // }).catchError((e) {
    //   print(e);
    // });
    var location = new Location();
    var currentLocation = LocationData;
    // currentLocation = await location.getLocation();
  location.onLocationChanged().listen((LocationData currentLocation) {
  print(currentLocation.latitude);
  print(currentLocation.longitude);
  print(currentLocation.accuracy);
});
  }
}