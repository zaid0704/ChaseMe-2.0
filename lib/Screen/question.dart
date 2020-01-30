import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import '../provider/Auth.dart';
class Question extends StatefulWidget {
  Question({Key key}) : super(key: key);

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  bool isLoading = false;
  StreamSubscription<Position> positionStream;
  Future<void> _getLocation(double latitude,double longitude,Auth auth)async{
  
  Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);   
  print(position.latitude);
  print(position.longitude);
  var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 0);
   positionStream = Geolocator().getPositionStream(locationOptions).listen(
    (Position position)async {
        // print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
    double distanceInMeters = await Geolocator().distanceBetween(position.latitude, position.longitude, latitude,longitude);
  print(distanceInMeters);
  if (distanceInMeters <= 7)
   {
    auth.updateLevel();
    print("U r in the Zone");
     positionStream.cancel();
   }
   else 
   print("Out of Zone");
    });
  
  }
  final ansController = TextEditingController();
  Widget build(BuildContext context) {
    
   final auth = Provider.of<Auth>(context);
   
   if (auth.question != null&&auth.question['status']==0 )
   {
     
     _getLocation(double.parse( auth.question['answer']['latitude']),double.parse( auth.question['answer']['longitude']),auth);
   }
    return auth.question == null?Center(child: CircularProgressIndicator(
          backgroundColor: Color(0xFFFEC009),
        ),):SingleChildScrollView(
          child:     Padding(
          padding: const EdgeInsets.only(top:60,right: 30,left: 30),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
             Text(auth.question['question'],style: TextStyle(color: Colors.white),),
             auth.question != null&&auth.question['status']==1 ?
              
              TextField(
            style: TextStyle(color: Colors.white),
            controller: ansController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              helperText: 'Answer',
              helperStyle: TextStyle(color: Colors.white),
              
            ),
          ):Text(''),
             auth.question != null&&auth.question['status']==1 ?
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: RaisedButton(
                    elevation: 6.0,
                    child: Text('Drop',style: TextStyle(color: Colors.black),),
                    color: Colors.white,
                    onPressed: (){},
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.all(30),
                  child: RaisedButton(
                    elevation: 6.0,
                    child: Text('Submit',style: TextStyle(color: Colors.black)),
                    color: Color(0xFFFEC009),
                    onPressed: (){
                      auth.question['answer']['answer'] == ansController.text ?
                      print('Done'):print('Not done');
                      auth.updateLevel();
                    },
                  ),
                )

              ],
            ):Text(''),
         
          
            // Container(
            //   width: 200,
            //   height: 100,
            //   child:  Image.asset('assets/images/character.png',fit: BoxFit.cover,),
            // ),
            
            ],
          )
        ),);
      
     }
}