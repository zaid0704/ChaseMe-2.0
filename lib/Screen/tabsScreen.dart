import 'package:flutter/material.dart';
import './duelMode.dart';
import './question.dart';
import './leaderBoard.dart';
class TabsScreen extends StatefulWidget {
  TabsScreen({Key key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int currentIndex = 0;
  List<Widget> _screens=[
     DuelMode(),
     Question(),
     LeaderBoard()
  ];
  void selectedTab(int index){
    setState(() {
      currentIndex = index;
    });
  }
  Widget build(BuildContext context) {
    return MaterialApp(
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
         appBar: AppBar(title: Text('Zaid',style: TextStyle(color: Colors.black),),backgroundColor: Color(0xFFFEC009),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert,color: Colors.black,),
            onPressed: (){print('Vert More Pressed');},
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