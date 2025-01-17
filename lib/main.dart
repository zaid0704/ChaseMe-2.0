import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:streamlocation/Screen/tabsScreen.dart';
import './Screen/question.dart';
import './Screen/SignUp.dart';
import 'geolocator.dart';
import 'home_page.dart';
import 'package:provider/provider.dart';
import './provider/Auth.dart';
import './Screen/Login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Auth(),
      child: MaterialApp(
        routes: {
          '/login':(ctx)=>Login(),
          '/question':(ctx)=>Question(),
          '/tabsScreen':(ctx)=>TabsScreen()
        },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    )
    );
    
  }
}