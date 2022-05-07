import 'dart:math';
import 'package:flutter/material.dart';

final _random = Random();
int next(int min, int max) => min + _random.nextInt(max - min);
double doubleInRange(num start, num end) => _random.nextDouble() * (end - start) + start;
Color randColor() => Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1);

const kMinSides = 3; // no less 3
const kMaxSides = 27;

const kMinRadians = 0;
const kMaxRadians = 6.26573; 