import 'dart:math';
import 'package:flutter/material.dart';

List<Offset> generatePoints({required Size size, int sides=3, double radians=0}){
  final _random = Random();
  int next(int min, int max) => min + _random.nextInt(max - min);
  var angle = (pi * 2) / sides;
  var radius = size.width/2;
  Offset center = Offset(size.width / 2, size.height / 2);
  /*Offset startPoint =
    Offset(radius * cos(radians), radius * sin(radians));
  path.moveTo(startPoint.dx + center.dx, startPoint.dy + center.dy);*/
  List<Offset> points = [];
  int min = (radius*0.4).round();
  int max = radius.round();
  for (int i = 1; i <= sides; i++) {
    var randRadius = next(min,max);
    double x = randRadius * cos(radians + angle * i) + center.dx;
    double y = randRadius * sin(radians + angle * i) + center.dy;
    points.add(Offset(x, y));
  }

  return points;
}