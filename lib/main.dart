import 'dart:async';

import 'package:flutter/material.dart';

import 'package:intl/date_symbol_data_local.dart';

import 'onBoarding.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: "avenir"),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), openOnBoard);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage('assets/images/aking.png')),
          ),
        ),
      ),
    );
  }

  void openOnBoard() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => OnBoarding()));
  }
}
