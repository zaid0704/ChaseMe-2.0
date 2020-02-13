import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import '../provider/Auth.dart';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:toast/toast.dart';


import 'dart:async';
import '../game2/game_controller.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import '../game2/gamOver.dart';
class OnlineUser extends StatefulWidget {
  OnlineUser({Key key}) : super(key: key);

  @override
  _OnlineUserState createState() => _OnlineUserState();
}

class _OnlineUserState extends State<OnlineUser> {

  
  final DBRef = FirebaseDatabase.instance.reference();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  final challengeController = TextEditingController();
  Auth auth;
  BuildContext ctx;
  Util flameUtil;
  GameController gameController ;
  
  void gameInitialize()async{
     flameUtil = Util();
 
    flameUtil.fullScreen();
    flameUtil.setOrientation(DeviceOrientation.portraitUp);
    gameController = GameController();
 
    TapGestureRecognizer tapper = TapGestureRecognizer();
    tapper.onTapDown = gameController.onTapDown;
    flameUtil.addGestureRecognizer(tapper);


  }
  
  
  void initState() { 
    super.initState();
    
    gameInitialize();
    firebaseMessaging.configure(
      onMessage: (Map<String,dynamic> message)async{
        print('Firebase message is $message');
        if (message.containsKey('notification')){
          final notification = message['notification'];
          // final fcmToken = notification['title'];
          // print('Sender ');
          showDialog(context: context,
          builder: (ctx){
            return AlertDialog(
              title: Text(notification['title']),
              content: Text(notification['body']),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: (){
                    print('OK');
                    Navigator.of(ctx).pop();
                    DBRef.child(auth.firebaseMessagingToken).update({
                     'gameAccepted':'true',
                     'challenge':'false'
        
              });
              Navigator.push(ctx, MaterialPageRoute(
                    builder: (context)=>GameOver(gameController)
                    ));
                    
                  },
                ),
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: (){
                   DBRef.child(auth.firebaseMessagingToken).update({
                     'gameAccepted':'false',
                     'challenge':'false'
        
              });
                  Navigator.of(ctx).pop();},
                ),
              ],
            );
          });
        }
      },
      onLaunch: (Map<String,dynamic> message)async{
        print('OnLaunch message $message');
      },
      onResume: (Map<String,dynamic> message)async{
        print('OnResume message $message');
      },
    );
  }
  Widget build(BuildContext context) {
     auth = Provider.of<Auth>(context);
    // print(auth.id);
    ctx=context;
    setState(() {
      ctx=ctx;
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover
          )
        ),
        child:WillPopScope( onWillPop:(){
          
         return  Future.value(false);
        },
        child:
         Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.more_vert,color: Colors.black,),
                onPressed: (){
                  // Navigator.pop(context);
                },
              )
            ],
            title: Text('Online Players',style: TextStyle(color: Colors.black),),backgroundColor: Color(0xFFFEC009)),
       
         body:
             UserList(auth)
           
         )
      )
    ));
  }
  Widget UserList(Auth auth){
  final DBRef = FirebaseDatabase.instance.reference();
    return 
       
          StreamBuilder(
      stream: DBRef.onValue,
      builder: (ctx,snap){
        if (snap.hasData && !snap.hasError && snap.data.snapshot.value!=null) {
 

          DataSnapshot snapshot = snap.data.snapshot;
          List _item=[];
          // List _list=[];
          Map<dynamic,dynamic> map;
          map =snapshot.value;
        // print(map);
        map.forEach((f,k){
          _item.add(map[f]);
          // print(map[f]['gangstar']);
          });
          // _list=snapshot.value; 

        //   _list.forEach((f){
        //   if(f!=null){
        //   item.add(f);
        //   }
        //   }
        // );
        // print('My Online Users are $item');
        // print('User $_item');
        return  ListView.builder(
             shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
          itemCount: map.length,
          itemBuilder: (ctxx,index)=> 
          GestureDetector(
            onTap: (){
              
              showDialog(context: context,
              barrierDismissible: true,
              builder: (ctx)=>SimpleDialog(
                title: Text('Challenge'),
                // content: Text('Do you want to challenge ${_item[index]['gangstar']}'),
                elevation: 6.0,
                children:<Widget>[
                  SimpleDialogOption(
                    child: TextField(
                      controller: challengeController,
                      decoration: InputDecoration(
                        hintText: 'hint'
                      ),
                    ),
                  ),
                  SimpleDialogOption(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                          FlatButton(
                    child: Text('Challenged'),
                    onPressed: (){
                      // print('Challenged ${challengeController.text}');
                      DBRef.child(_item[index]['id']).update({
                     'challenge':'true',
                     'player_challenged':auth.Gangstar,
                     'price':challengeController.text,
        
              });
                    requestCheck(_item[index]['id']);
              Navigator.of(ctx).pop();
              
              
                    },
                  ),
                    FlatButton(
                    child: Text('Cancel'),
                    onPressed: (){print('Cancelled');
                    Navigator.of(ctx).pop();},
                  )
                
                      ],
                    )
                
                  ),
                 
                ]
                // : <Widget>[
                  
                 
                //   FlatButton(
                //     child: Text('Challenge'),
                //     onPressed: (){print('Challenged');
                //     Navigator.of(ctx).pop();
                //     },
                //   ),
                //   FlatButton(
                //     child: Text('Cancel'),
                //     onPressed: (){print('Cancelled');
                //     Navigator.of(ctx).pop();},
                //   )
                // ],
              )
              );
              // print('${_item[index]['gangstar']}');
              // DBRef.child(_item[index]['id']).update({
              //   'challenge':'true',
              //   'player_challenged':auth.id
              // });
            },
            child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            child: Container(
              width:MediaQuery.of(context).size.width,
              height: 70,
              child: ListTile(
              leading: CircleAvatar(),
              title: Text('${_item[index]['gangstar']}'),             
            ),
            ),
            
            color: Colors.white,
          ),
          )
          
        );
        
       
        }
        return CircularProgressIndicator();

      },
    );
        }
      
    Future<void> requestCheck(String id)async{

      Timer(Duration(seconds: 5),(){
        DBRef.once().then((onValue){
          Map<dynamic,dynamic> map =onValue.value;
          // print(map[id]);
          if (map[id]['gameAccepted']=='true'){
            print('Game Start');
            Navigator.push(ctx, MaterialPageRoute(
                    builder: (context)=>GameOver(gameController)
                    ));
          }
          else{
            showDialog(context: ctx,
            builder: (context)=>AlertDialog(
              title: Text('Loot'),
              content: Text('Challenged Rejected'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
            print('Rejected');
          }
        });
      });
    }
    
  }
