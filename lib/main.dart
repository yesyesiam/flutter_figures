import 'package:flutter/material.dart';
import 'package:flutter_figures/common.dart';
import 'package:flutter_figures/figure/figure.dart';
import 'package:flutter_figures/figure/figure_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Figure',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter kek'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var figureCtrl = FigureController();
  bool canChange = true;

  Color c = Colors.black;

  void _regenerate() {
    var randomColor = randColor();
    setState(() {
      canChange=false;
      c= randomColor;
    });
    figureCtrl.change(
      sides: next(kMinSides,kMaxSides), 
      radians: doubleInRange(kMinRadians, kMaxRadians), 
      color: randomColor,
      callback: ()=>setState(()=>canChange=true)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Kek',
              style: TextStyle(color: c)
            ),
            Figure(
              size: MediaQuery.of(context).size.shortestSide*0.8, 
              controller: figureCtrl,
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: canChange,
        child: FloatingActionButton(
          onPressed: _regenerate,
          tooltip: 'Tap to regenerate',
          child: const Icon(Icons.refresh),
        ),
      ), 
    );
  }
}