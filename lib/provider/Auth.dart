import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
// import 'package:firebase_database/firebase_database.dart';


class Auth with ChangeNotifier {
 
  int _level;
  int _status ;
  String _token;
  List<dynamic> leaderboard;
  Map<String,dynamic> question ;

  Future<void> Login (String email,String password)async{
   http.post(Uri.parse('http://loot07.herokuapp.com/login'),
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
       _getQuestion(_level, _status);
    
     });
     
     notifyListeners();
   
   
  }
 

 Future<void> SignUp(String name,String email,String admission,String contact,String password,String gangstar)async{
  
  
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
}