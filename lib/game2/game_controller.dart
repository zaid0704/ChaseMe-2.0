import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'spawn_enemy.dart';
import 'spawner.dart';
class GameController extends Game{
  Rect screen ;
  Size size;
  Enemy enemy;
  int score =0;
  Spawner spawner;
  GameController(){
    initialize();
  }
  void initialize()async{
    resize(await Flame.util.initialDimensions());
    screen = Rect.fromLTWH(0, 0, size.width, size.height);
  
    spawner = Spawner(this,size);
  }
  void render(Canvas c){
    Paint color = Paint()..color = Colors.black;
    c.drawRect(screen, color);
    // c.drawRect(screen,color);
    spawner.render(c);
  }
  void resize(Size s){
    size = s;
  }
  void update(t){
    spawner.update(t);
    if (spawner.totalTime == 10){
      // print('Game Over ');
      
      
      
    }
  }
  void onTapDown(TapDownDetails d){
   
   if(spawner.enemy.rect.contains(d.globalPosition))
   {
    score++;
    //  print('tapped');
   }
  }
}