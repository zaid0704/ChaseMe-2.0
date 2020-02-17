// import 'package:flame/time.dart';
// import 'package:flame/time.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:streamlocation/Screen/leaderBoard.dart';
import '../Screen/tabsScreen.dart';
import '../Screen/onlineUser.dart';
import '../game2/lastScreen.dart';
import '../game2/game_controller.dart';
import 'dart:async';
import 'package:toast/toast.dart';
import 'package:firebase_database/firebase_database.dart';
import '../provider/Auth.dart';
import 'package:provider/provider.dart';
class GameOver extends StatefulWidget {
  GameController gameController;
  GameOver(this.gameController);
  @override
  _GameOverState createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  bool isOver = false;
  BuildContext ctx;
  final DBRef = FirebaseDatabase.instance.reference();
  Auth auth;
  Future timer()async{
   Timer(Duration(seconds:11), (){
      Toast.show("Game Over score :${widget.gameController.score}", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      
        DBRef.child(auth.firebaseMessagingToken).update({
        'score':widget.gameController.score
      });
      
      
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
    setState(() {
      ctx= context;
    });
    auth =Provider.of<Auth>(context);
    return MaterialApp(
      onGenerateRoute: (settings){
        print(settings.name);
        if (settings.name == '/onlineScreenFromResult'){
          return MaterialPageRoute(builder: (con)=>OnlineUser());
        }
      },
      debugShowCheckedModeBanner: false,
      home: Scaffold(
       backgroundColor: Colors.black,
      
      body:!isOver?
        widget.gameController.widget:LastScreen(widget.gameController.score)
        
        
      ),
      
    );
  }
}