import 'package:flame/flame.dart';
import 'game_controller.dart';
import 'dart:ui';
import 'package:flutter/material.dart';

class Enemy {
  GameController gameController;
  Rect rect ;
  double tileSize;
 double x=200;
 double y=200;
  Enemy(this.gameController,tileSize,x,y){
    rect = Rect.fromLTWH(x, y, tileSize,tileSize);
    
  }
  
  void render(Canvas c){
    
    Paint color = Paint()..color = Colors.white;
    c.drawRect(rect, color);
    
  }
 
}