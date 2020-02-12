import 'game_controller.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'spawn_enemy.dart';
class Spawner{

  double x,y;
  Random rand = Random();
  Size size;
   int timeElapse= 1000;
  int spawnAfter;
  Enemy enemy ;
  int totalTime ;
  GameController gameController;
  Spawner(this.gameController,this.size){ 
     x = rand.nextDouble()*size.width*0.95;
    y = rand.nextDouble()*size.height*0.95;
    // print('X is $x and Y is $y');
      enemy = Enemy(gameController, size.width/10,x,y);
    spawnAfter = DateTime.now().millisecondsSinceEpoch + timeElapse;
    totalTime =0;}
    
  void update(double t){
     int now = DateTime.now().millisecondsSinceEpoch  ;

    if (now>=spawnAfter){
      
    x = rand.nextDouble()*size.width*0.95;
    y = rand.nextDouble()*size.height*0.95;
    // print('X is $x and Y is $y');
      enemy = Enemy(gameController, size.width/10,x,y);
      spawnAfter = now+timeElapse;
      totalTime ++;
    }
  }
  void render(Canvas c){
    enemy.render(c);
  }
}