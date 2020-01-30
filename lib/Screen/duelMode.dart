import 'package:flutter/material.dart';

class DuelMode extends StatefulWidget {
  DuelMode({Key key}) : super(key: key);

  @override
  _DuelModeState createState() => _DuelModeState();
}

class _DuelModeState extends State<DuelMode> {
  @override
  Widget build(BuildContext context) {
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
                         Text('Loot',style: TextStyle(color: Colors.yellow,fontSize: 16),)
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