// import 'package:flame/time.dart';
// import 'package:flame/time.dart' as prefix0;
import 'package:flutter/material.dart';
import '../Screen/onlineUser.dart';
import '../game2/lastScreen.dart';
import '../game2/game_controller.dart';
import 'dart:async';
import 'package:toast/toast.dart';
class GameOver extends StatefulWidget {
  GameController gameController;
  GameOver(this.gameController);
  @override
  _GameOverState createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  bool isOver = false;
  Future timer()async{
   Timer(Duration(seconds:11), (){
      Toast.show("Game Over score :${widget.gameController.score}", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

     setState(() {
       isOver=true;
     });
   });
  }
  void initState() { 
    super.initState();
    timer();
    
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
       backgroundColor: Colors.black,
      
      body:!isOver?
        widget.gameController.widget:OnlineUser()
        
        
      ),
      
    );
  }
}