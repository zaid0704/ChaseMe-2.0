import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:provider/provider.dart';
import '../provider/Auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class LastScreen extends StatefulWidget {
 int myScore ;
 LastScreen(this.myScore);

  @override
  _LastScreenState createState() => _LastScreenState();
}

class _LastScreenState extends State<LastScreen> {
  Auth auth;
  bool isResult = false;
  bool once =true;
  String betValue;
  final DBRef = FirebaseDatabase.instance.reference();
  String challengedPlayer ;
  String result ='';
  bool throwChallenge;
  int scoreRead ;
  Future<void> gameResult()async{
    
      
     int challengedPlayerScore ;
     
     DBRef.once().then((onValue){
       
          Map<dynamic,dynamic> map =onValue.value;
          scoreRead = map[challengedPlayer]['scoreRead'];
          
          // print('Throw is $throwChallenge and score Read after $scoreRead');
          Timer(Duration(seconds:throwChallenge?3:scoreRead+4), (){
            DBRef.once().then((val){
              Map<dynamic,dynamic> map2 =val.value;
                 if (map2[challengedPlayer]['score']!=null){
            challengedPlayerScore =map2[challengedPlayer]['score'];
            if (!throwChallenge){
              betValue  =map2[auth.firebaseMessagingToken]['price'];
              auth.betMoney = int.parse(betValue);
            }
            
            print('challenged Player Score is $challengedPlayerScore');
            print('Your Score is ${widget.myScore}');
            
            Timer(Duration(seconds:10), (){
              DBRef.child(challengedPlayer).update(
              {
              'gameRunning':'false',
              //  'score':0,
               'player_challenged':null,
              'price':null,
              'gameAccepted':null,
               'challenge':'false',
               'scoreRead':0,
               'score':0,
               'challengePlayerToken':null

            });
            DBRef.child(auth.firebaseMessagingToken).update(
              {
              'gameRunning':'false',
              //  'score':0,
               'player_challenged':null,
              'price':null,
              'gameAccepted':null,
               'challenge':'false',
               'scoreRead':0,
               'score':0,
               'challengePlayerToken':null

            });

            });
            
          if (challengedPlayerScore > widget.myScore){
            // print('I lose');
            setState(() {
              result = 'You Lost !';
            });
            String sign = '-';
            auth.updateScoreAfterDuel(sign,auth.betMoney.toString());
            
            
          }
          else {
            // print('I won');
            setState(() {
            result = 'You Won!';
          });
            String sign = '+';
            auth.updateScoreAfterDuel(sign,auth.betMoney.toString());
          }
          
           
          }
            });
           setState(() {
      isResult = true;
    });
          });
           
     });
   
    
    
  }

  
  
  Widget build(BuildContext context) {
    auth = Provider.of<Auth>(context);
    throwChallenge = auth.throwChallenge;
    challengedPlayer = auth.challengedPlayer;
    if (once){
      once = false;
      // gameResult();
      gameResult();
    }
    return MaterialApp(
      routes: {
        
      },
      debugShowCheckedModeBanner: false,
      home:Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover
          )
        ),
        child:
       Scaffold(
         backgroundColor: Colors.transparent,
        appBar: AppBar(title:Text('GameOver',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.yellow,),
        body: isResult?GestureDetector(
          onTap: (){
            Navigator.of(context).popAndPushNamed('/tabsScreen');
          },
          child: Center(
            child:Padding(padding: const EdgeInsets.all(20),
              child:Card(
                elevation: 6.0,
                child:  Container(
              height: MediaQuery.of(context).size.height*.30,
              
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                Padding(padding:const EdgeInsets.all(30),
                child: Text(result,
                style: TextStyle(color: Colors.black,
                fontSize: 30),), ),
                 
                     Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: <Widget>[
                     FlatButton(
                       child: Text('Ok'),
                       onPressed: (){
                        
                         
                        //  Navigator.pop(context);
                        //  Navigator.of(context).
                        //  pushNamedAndRemoveUntil('/tabsScreen', ModalRoute.withName('/tabsScreen'));
                       },
                     )
                   ],
                 )
                   
                 
              ],),
              
            )
              ),
             )
            ),
           
          )
        :Center(child:CircularProgressIndicator())
        
      ),
    ));
  }

}