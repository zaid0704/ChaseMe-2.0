import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'dart:async';
// import 'package:location/location.dart';

class GeoLocator extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<GeoLocator> {
  Position _currentPosition = null;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
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
    print('trying...');
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
Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);   
  print(position.latitude);
  print(position.longitude);
  var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 1);
  StreamSubscription<Position> positionStream = Geolocator().getPositionStream(locationOptions).listen(
    (Position position)async {
        // print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
    double distanceInMeters = await Geolocator().distanceBetween(position.latitude, position.longitude, position.latitude+1000, position.longitude+1000);
  if (distanceInMeters <= 3)
   {
     print("Yups");
   }
   else 
   print("nopes");
    });
  
  }
}