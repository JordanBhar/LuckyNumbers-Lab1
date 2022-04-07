import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 1',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Lab N1'),
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
  int? luckyNumber;
  Timer? timer;
  int counter = 0;
  bool clickState = false;

  void counterUpdate() {
    if (counter % 2 == 0) {
      counter++;
      setState(() {
        clickState = true;
      });
      clickState = true;
      startGenerating();
    } else if (counter % 2 != 0) {
      counter++;
      setState(() {
        clickState = false;
      });
      clickState = false;
      stopGenerating();
    }
  }

  void startGenerating() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => generatLuckyNumber());
    });
  }

  void stopGenerating() {
    timer?.cancel();
  }

  Future<void> generatLuckyNumber() async {
    int newLuckyNumber = new Random().nextInt(100) + 0;

    setState(() {
      luckyNumber = newLuckyNumber;
    });
  }

  Widget _bottomNavBar(BuildContext context){
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Container(
        height: 75,
      ),
    );
  }

  Widget _floatingActionButton(BuildContext context){




    return Container(child: FloatingActionButton(
      onPressed: counterUpdate,
      child: Icon((clickState == false) ? Icons.play_arrow : Icons.pause , color: Colors.white,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    generatLuckyNumber();

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title , style: TextStyle(color: Colors.white),),
        ),
        body: Stack(
          children: [
            Center(
                child: Column(
                  children: [
                    Text("Your Lucky Number:" , style: TextStyle(fontSize: 20)),
                    Container(
                     child: Text("${luckyNumber}" , style: TextStyle(fontSize: 30),),
                     margin: EdgeInsets.only(top: 20),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )
            ),
          ],
        ),
        bottomNavigationBar: _bottomNavBar(context),
        floatingActionButton: _floatingActionButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
  }
}
