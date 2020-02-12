import 'package:flutter/material.dart';
import '../game_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../game_controller.dart';
class FirstScreen extends StatefulWidget {
  FirstScreen({Key key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  Util flameUtil = Util();
   GameController gameController;
  Future _setGame()async{
    await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  SharedPreferences storage = await SharedPreferences.getInstance();
   gameController = GameController(storage);
  // runApp(gameController.widget);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = gameController.onTapDown;
  flameUtil.addGestureRecognizer(tapper);
  }
 void initState() { 
   super.initState();
  _setGame();
 }
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      home:Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: GestureDetector(
            onTap: (){
              print('tapped');
             Navigator.push(context,MaterialPageRoute(
               builder: (ctx)=>gameController.widget
             ));
            },
            child: Text('Tap to Start the game !',style: TextStyle(color:Colors.yellow,fontSize: 20),),
          ),
        ),
      ),
      
      
    );
  }
}