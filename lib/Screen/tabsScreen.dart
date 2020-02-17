import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import './duelMode.dart';
import './question.dart';
import './leaderBoard.dart';
import './onlineUser.dart';
import 'package:provider/provider.dart';
import '../provider/Auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../game2/gamOver.dart';
import './SignUp.dart';
import './Login.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/html.dart';


class TabsScreen extends StatefulWidget {
  TabsScreen({Key key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int currentIndex = 0;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  final DBRef = FirebaseDatabase.instance.reference();
  Auth auth;
  List<Widget> _screens=[
     DuelMode(),
     Question(
      //  webSocketChannel:IOWebSocketChannel.connect("wss://echo.websocket.org")
      // webSocketChannel:HtmlWebSocketChannel.connect("ws://loot07.herokuapp.com")
     ),
     LeaderBoard()
  ];
  void selectedTab(int index){
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() { 
    super.initState();
    firebaseMessaging.configure(
      onMessage: (Map<String,dynamic> message)async{
        print('Firebase message is $message');
        if (message.containsKey('notification')){
          final notification = message['notification'];
          final fcmToken = notification['title'];
          auth.challengedPlayer = fcmToken;
          // print('Sender ');
          showDialog(context: context,
          builder: (ctx){
            return AlertDialog(
              title: Text('Challenge'),
              content: Text(notification['body']),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: (){
                    print('OK');
                    Navigator.of(ctx).pop();
                    auth.throwChallenge = false;
                    DBRef.child(auth.firebaseMessagingToken).update({
                     'gameAccepted':'true',
                     'challenge':'false',
                     'gameRunning':'true'
        
              });
              Navigator.push(ctx, MaterialPageRoute(
                    builder: (context)=>GameOver(auth.gameController)
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

    return MaterialApp(
      routes: {
        '/onlineUser':(ctx)=>OnlineUser(),
         '/signUp':(ctx)=>SignUP(),
         '/login':(ctx)=>Login(),
          '/question':(ctx)=>Question(),
          '/tabsScreen':(ctx)=>TabsScreen(),
          '/duelMode':(ctx)=>DuelMode(),
      },
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover
          )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
         appBar: AppBar(title: Text('${auth.gangstar}',style: TextStyle(color: Colors.black),),backgroundColor: Color(0xFFFEC009),
        actions: <Widget>[
         PopupMenuButton(
           icon: Icon(Icons.more_vert,color: Colors.black,),
           
           onSelected: (val){
             if (val == 1)
              {
                print('LogOut');
                auth.logOut(context,'tabsScreen');
              }
           },
           itemBuilder: (context)=>[
             PopupMenuItem(
               child: Text('LogOut'),
               value: 1,
           )],
         )
        ],),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: selectedTab,
          elevation: 6.0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          backgroundColor: Color(0xFFFEC009),
          items: [
            BottomNavigationBarItem(
              icon:Container(
                width: 30,
                height: 30,
                child: Image.asset('assets/images/duel.png',fit: BoxFit.cover,),
              ),
              title: Text('Duel')
            ),
            BottomNavigationBarItem(
              icon:Container(
                width: 30,
                height: 30,
                child: Image.asset('assets/images/current_task.png',fit: BoxFit.cover,),
              ),
              title: Text('Current Task')
            ),
             BottomNavigationBarItem(
              icon:Container(
                width: 30,
                height: 30,
                child: Image.asset('assets/images/trophy.png',fit: BoxFit.cover,),
              ),
              title: Text('Leader Board')
            )
          ],
        ),
        body: _screens[currentIndex],
        ),
        
        ));
  }
}