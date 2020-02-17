import 'package:flutter/material.dart';
import '../provider/Auth.dart';
import '../Screen/onlineUser.dart';
import '../game/components/FirstScreen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
class DuelMode extends StatefulWidget {
  DuelMode({Key key}) : super(key: key);

  @override
  _DuelModeState createState() => _DuelModeState();
}

class _DuelModeState extends State<DuelMode> with WidgetsBindingObserver {
  Auth auth;
  final DBRef = FirebaseDatabase.instance.reference();
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  
  void dispose() { 
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  void didChangeAppLifecycleState(AppLifecycleState state) {
  if(state == AppLifecycleState.resumed){
    print('App Resumed DuelMode');
   auth.online();
  }
  if (state == AppLifecycleState.paused){
    auth.offline();
    // DBRef.child(auth.firebaseMessagingToken).update({
    //   'score':0
    // });
    // String sign='-';
    // auth.updateScoreAfterDuel(sign, auth.betMoney.toString());
    // print("paused Mode");
  }
}
  Widget build(BuildContext context) {
    auth =Provider.of<Auth>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30),
              child: Text('Duel Mode',style: TextStyle(color: Colors.white,fontSize: 30),),
            ),

          ],
        ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 Padding(
                  padding: const EdgeInsets.all(30),
                  child: RaisedButton(
                    elevation: 6.0,
                    child: Text('Won',style: TextStyle(color: Colors.black,fontSize: 18),),
                    color: Colors.white,
                    onPressed: (){},
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.all(30),
                  child: RaisedButton(
                    elevation: 6.0,
                    child: Text('Lost',style: TextStyle(color: Colors.black,fontSize: 18)),
                    color: Color(0xFFDB3A3A),
                    onPressed: (){
                     
                    },
                  ),
                )
              ],
            ),

           Expanded(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.end,
               children: <Widget>[
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Text('Ready to Loot !',style: TextStyle(color: Colors.red,fontSize: 20),),
                         GestureDetector(
                           onTap: (){print('Loot Tapped');
                         Navigator.of(context)
                         .pushNamed('/onlineUser').then((result){
                           if (result == 'logoutFromOnline'){
                             Navigator.of(context).popAndPushNamed('/signUp');
                           }else{
                             print('Re rendering duel Screen');
                           setState(() {
                             
                           });
                           }
                           
                         });
                         
                           },                           
                  child: Text('Loot',style: TextStyle(color: Colors.yellow,fontSize: 16),),                      
                         ),
                          ],
                     )
                   ],
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     Container(
                       width: 200,
                       height: 300,
                       child: Image.asset('assets/images/character.png',fit:BoxFit.cover),
                     )
                   ],
                 ),
                   ],
                 ),
                 
               ],
             ),
           )
      ],
      );
    
    
  }
}