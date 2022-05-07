import 'package:flutter/material.dart';
import 'package:flutter_figures/figure/figure_controller.dart';
import 'package:flutter_figures/figure/figure_generator.dart';

class Figure extends StatefulWidget {
  final double size;
  final FigureController? controller;
  final Duration duration;
  const Figure({ Key? key,
   this.size = 200, 
   this.controller,
   this.duration = const Duration(seconds: 1)
  }) : super(key: key);

  @override
  State<Figure> createState() => _FigureState();
}

class _FigureState extends State<Figure> with SingleTickerProviderStateMixin {
  late Animation<Color?> _colorTweenAnimation;
  late AnimationController _animController;
  late ColorTween _colorTween;

  late List<Offset> points;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _colorTween = ColorTween(begin: Colors.black, end: Colors.black);
    _colorTweenAnimation = _colorTween.animate(_animController);
    points = generatePoints(size: Size(widget.size, widget.size));

    widget.controller?.onChange((s,r,c,cb)=>_regenerate(sides: s, radians: r, color: c, callback: cb));
  }

  List<Offset> _regenerate({int sides=3, double radians=0, Color? color, Function? callback}){
    if(_animController.isAnimating){
      return [];
    }
    var newPoints = generatePoints(size: Size(widget.size, widget.size), sides: sides, radians: radians );
    
    if (_animController.status == AnimationStatus.completed) {
      _animController.reset();
    }
    setState(() {
      points = newPoints;
      _colorTween = ColorTween(begin: _colorTween.end, end: color);
      _colorTweenAnimation = _colorTween.animate(_animController);
    });
    
    _animController.forward().whenCompleteOrCancel((){
      callback?.call();
    });
    
    return newPoints;
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    _animController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print(2);
    return AnimatedBuilder(
      animation: _colorTweenAnimation,
      builder: (context, child)=> SizedBox(
        height: widget.size,
        width: widget.size,
        child: RepaintBoundary(
          child: CustomPaint(
            painter: ShapePainter(points, _colorTweenAnimation.value),
          ),
        )
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  final List<Offset> points;
  final Color? color;
  ShapePainter(this.points, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color??Colors.teal
      ..strokeWidth = 5
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    var path = Path();
    path.addPolygon(points, false);
    path.close();
    canvas.drawPath(path, paint);
    //canvas.drawPoints(PointMode.points, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}