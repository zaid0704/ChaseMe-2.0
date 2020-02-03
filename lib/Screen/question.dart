import 'package:flutter/material.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import  'package:flutter_socket_io/flutter_socket_io.dart';
import '../provider/Auth.dart';
import 'dart:convert';
import 'package:vibration/vibration.dart';
// import 'package:websocket_manager/websocket_manager.dart';
class Question extends StatefulWidget {
  // final WebSocketChannel webSocketChannel;
  // Question({this.webSocketChannel});

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question>  with WidgetsBindingObserver {
  
  @override
  
  
  // SocketIO socketIO;
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addObserver(this);
      //  socketIO =SocketIOManager().createSocketIO(
    //   'http://loot07.herokuapp.com',
    //   '/'
    //   // socketStatusCallback: _socketStatus
    // );
    //  socketIO.init();
    //   socketIO.subscribe('received_message', (jjson){
    //             print(json.decode(jjson.body));
    //           });
    //  socketIO.connect();
    
  }
  // _socketStatus(data){
  //   print(data);
  // }
  bool isLoading = false;
  // _socketStatus(dynamic data){print("Socket Status is ${data}");}
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
  String data ;
  Auth auth;
  Widget build(BuildContext context) {
    
  auth = Provider.of<Auth>(context);
   
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
                    onPressed: (){
                    //   print('Pressed');
                    //   widget.webSocketChannel.sink.add('Devansh Pagal h');
                      
                    //   widget.webSocketChannel.stream.listen((message) {
                    //  print('My Message is $message');
                    //   });
              // socketIO.sendMessage(
              // 'test', json.encode({'message': 'Devansh Paglet h :)'}),(rec){
              //   print(rec);
              // });
             
                    },
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.all(30),
                  child: RaisedButton(
                    elevation: 6.0,
                    child: Text('Submit',style: TextStyle(color: Colors.black)),
                    color: Color(0xFFFEC009),
                    onPressed: ()async{

                     if( auth.question['answer']['answer'] == ansController.text ){
                       print('Correct');
                       auth.updateLevel();
                       
                     }
                     else
                     {
                       print('Wrong asnwer');
                       if(await Vibration.hasVibrator()){
                         if (await Vibration.hasAmplitudeControl())
                         {
                           Vibration.vibrate(amplitude: 128,duration: 1000);
                        
                            }
                            Vibration.vibrate(duration: 500);
                        
                       }
                     }

                      
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
void dispose() {
    // SocketIOManager().destroySocket(socketIO);
    // SocketIOManager().destroyAllSocket();
    // print('Disposed');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
void didChangeAppLifecycleState(AppLifecycleState state) {
  if(state == AppLifecycleState.resumed){
    print('App Resumed');
    auth.online();
  }
  if (state == AppLifecycleState.paused){
    auth.offline();
    print("paused");
  }
}
}