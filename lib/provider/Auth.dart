import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import '../game2/game_controller.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import '../game2/gamOver.dart';
// import 'package:firebase_database/firebase_database.dart';


class Auth with ChangeNotifier {
 
  int _level;
  int _status ;
  String _token;
  List<dynamic> leaderboard;
  Map<String,dynamic> question ;
  String _id ;
  String gangstar;
  String firebaseToken ;
  GameController gameController ;
  bool gameWon;
  String challengedPlayer;
  bool throwChallenge = false;
  int betMoney = 0;
  final DBRef = FirebaseDatabase.instance.reference();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  

  Future<bool> Login (String email,String password)async{
  final SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
  bool success = await  http.post(Uri.parse('http://loot07.herokuapp.com/login'),
    body: json.encode({
      'email':email,
      'password':password
    }),
    headers: {
       "Accept":"application/json",
       "Content-Type": "application/json",
     }).then((onValue)async{
       print('val is ${json.decode(onValue.body)}');
       _level = json.decode(onValue.body)['level'];
       _status = json.decode(onValue.body)['status'];
       _token = json.decode(onValue.body)['token'];
       _id = json.decode(onValue.body)['id'];
       gangstar = json.decode(onValue.body)['gangstar'];
       _getQuestion(_level, _status);
       online();
       gameInitialize();
       final userData = json.encode({
         'token':_token,
         'gangstar':gangstar,
         'level':_level,
         'status':_status
       });
       sharedPreferences.setString('userData', userData);
       return true;
     }).catchError((onError){
       return false;
     });
     
     notifyListeners();
   
   return success;
  }
 

 Future<void> SignUp(String name,String email,String admission,String contact,String password,String gangstar)async{
  

  //First Signing Up to Firebase if found true then we go for storing data to backend
  
  http.post(
    Uri.parse('http://loot07.herokuapp.com/signup'),
        body:json.encode({
           'name':name,
           'email':email,
           'zeal':admission,
           'contact':contact,
           'password':password,
           'gangstar':gangstar
      }),
     headers: {
       "Accept":"application/json",
       "Content-Type": "application/json",
     }).then((onValue){
       print('val is ${json.decode(onValue.body)}');
     }).catchError((onError){
       print('Error${onError}');
     });
   
 }
 

 
 Future updateLevel()async{
   final sharedPreference = await SharedPreferences.getInstance();
   http.put(
     Uri.parse('http://loot07.herokuapp.com/update'),
     headers: {
       "Accept":"application/json",
       "Content-Type": "application/json",
       "Authorization": "Bearer $_token"
     }
   ).then((onValue){
     print('Rspone ${json.decode(onValue.body)}');
     _level= json.decode(onValue.body)['level'];
     _status = json.decode(onValue.body)['status'];
     _getQuestion(_level, _status);
      if (sharedPreference.containsKey('userData')){
        sharedPreference.remove('userData');
        final userData = json.encode({
         'token':_token,
         'gangstar':gangstar,
         'level':_level,
         'status':_status
       });
         sharedPreference.setString('userData',userData );
      }
     notifyListeners();
   });
   
 }
  
  Future<void> _getQuestion(int _level,int _status)async{
     http.Response response = await http.get('http://loot07.herokuapp.com/question/$_level/$_status');
       print('Question ${json.decode(response.body)}');
       question = json.decode(response.body);
       notifyListeners();
  }

  Future<void> leaderBoard()async{
    http.get(Uri.parse('http://loot07.herokuapp.com/leaderboard'),
    headers: {
       "Accept":"application/json",
       "Content-Type": "application/json",
       "Authorization": "Bearer $_token"
    }).then((onValue){
      // print(json.decode(onValue.body));
      leaderboard = json.decode(onValue.body);
      // print('Leader Board $leaderboard');
      notifyListeners();
    });
  }


  Future<void> online()async{
    firebaseMessaging.getToken().then((onValue){
      firebaseToken = onValue;
      print('FCM $firebaseToken');
       DBRef.child('$onValue').set({
     'id':firebaseToken,
     'gangstar':gangstar,
     'challenge':'false',
     'player_challenged':null,
     'price':null,
     'gameAccepted':null,
     'gameRunning':null,
     'score':0,
     'scoreRead':0,
     'challengePlayerToken':null

    });

    });
  
  }

  Future<void> offline()async{
    DBRef.child('$firebaseToken').remove();
  }


  Future<bool> autoLogin(BuildContext context)async{
    final sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('userData')){
      print('Auto Login Contains Key');
      final map = json.decode(sharedPreferences.getString('userData')) as Map<String,Object>;
      _token = map['token'];
      _level = map['level'];
      _status = map['status'];
      gangstar = map['gangstar'];
      Toast.show("AutoLogin ",context,duration: Toast.LENGTH_LONG,gravity: Toast.TOP,textColor: Colors.white);
      _getQuestion(_level, _status);
      online();
      gameInitialize();
      notifyListeners();
      print('Level is $_level , status is $_status , gangstar  is $gangstar');
      return true;
    }
   
    else {
      notifyListeners();
      //  Toast.show("AutoLogin Failed ",context,duration: Toast.LENGTH_LONG,gravity: Toast.TOP,textColor: Colors.white);
       return false;
    }
    
  }

  Future<void> logOut(context,String screen)async{
    final sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('userData')){
        sharedPreferences.remove('userData');
        _token=null;
        gangstar = null;
        _level=null;
        _status = null;
        offline();
        if (screen == 'tabsScreen'){
          while(Navigator.canPop(context)){
         Navigator.pop(context);
         
        }
        }
        
    }
    notifyListeners();
  }

  Future<void> gameInitialize()async{
    Util flameUtil;
    
     flameUtil = Util();
    flameUtil.fullScreen();
    flameUtil.setOrientation(DeviceOrientation.portraitUp);
    gameController = GameController();
 
    TapGestureRecognizer tapper = TapGestureRecognizer();
    tapper.onTapDown = gameController.onTapDown;
    flameUtil.addGestureRecognizer(tapper);
 }


  Future<void> gameResult()async{
    gameWon = true;
    notifyListeners();
    
  }
  
  Future updateScoreAfterDuel(String sign,String score)async{
    print('Update Score by ${score} and sign $sign');
    http.put(
      Uri.parse('http://loot07.herokuapp.com/score'),
      headers: {
        "Accept":"application/json",
       "Content-Type": "application/json",
       "Authorization": "Bearer $_token"
      },
      body: json.encode({
        'score':score,
        'sign':sign
      })).then((onValue){
        print(json.decode(onValue.body));
      });
  }
  String get id {
    if (_id!=null)
     {
       return _id ;
     }
  }
  String get Gangstar{
    return gangstar;
  }

  bool get token {
    if (_token!= null ){
      return true;
    }
    return false;

  }

  String get firebaseMessagingToken{
    if (firebaseToken!=null)
     {
       return firebaseToken;
     }
  }
  bool get wonLoss{
    if (gameWon!=null)
     {
       return gameWon;
     }
  }
}