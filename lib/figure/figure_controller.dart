import 'package:flutter/material.dart';

class FigureController {
  List<Offset> Function(int sides, double radians, Color? color, Function? callback)? _listener;
  bool _isAnimating = false;
  FigureController();
  onChange(List<Offset> Function(int sides, double radians, Color? color, Function? callback) ex){
    _listener = ex;
  }
  onAnimating(bool animating){
    _isAnimating=animating;
  }
  bool get isAnimating => _isAnimating;
  
  List<Offset> change({int sides=3, double radians = 0, Color? color, Function? callback}) {
    if (_listener == null) return [];
    return _listener!(sides, radians, color, callback);
  }

  dispose() {
    _listener = null;
  }
}