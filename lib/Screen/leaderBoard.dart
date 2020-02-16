import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/Auth.dart';
class LeaderBoard extends StatefulWidget {
  LeaderBoard({Key key}) : super(key: key);

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> with WidgetsBindingObserver {
  List<dynamic> leaderBoard;
  Auth auth;
  @override
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  Widget build(BuildContext context) {
     auth = Provider.of<Auth>(context);
     auth.leaderBoard();
    leaderBoard=auth.leaderboard;
    return Column(
    mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
          padding: const EdgeInsets.all(40),
          child: Text('LeaderBoard',style: TextStyle(color: Colors.white,fontSize: 30),),
        ),
          ],
        ),
        leaderBoard == null?Center(child: CircularProgressIndicator(),):
        Container(
          height: MediaQuery.of(context).size.height - 263,
          width: MediaQuery.of(context).size.width,
          // color: Colors.purple,
          child: ListView.builder(
          itemCount: leaderBoard.length,
          itemBuilder: (ctx,index)=>Padding(
            padding: const EdgeInsets.only(left:30,right: 30,top: 10),
            child: Card(
              color: Colors.white,
              child: ListTile(
                title: Text('${leaderBoard[index]['name']}'),
                subtitle: Text('${leaderBoard[index]['score']}'),
              ),
            ),
          ),
          ),
        ),
        
        
      ],
    );
  }
  void dispose() {
    // SocketIOManager().destroySocket(socketIO);
    // SocketIOManager().destroyAllSocket();
    // print('Disposed');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
void didChangeAppLifecycleState(AppLifecycleState state) {
  if(state == AppLifecycleState.resumed){
    print('App Resumed');
    auth.online();
  }
  if (state == AppLifecycleState.paused){
    auth.offline();
    print("paused");
  }
}
}