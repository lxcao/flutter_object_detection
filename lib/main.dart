/*
 * @Author: clingxin
 * @Date: 2021-05-19 07:28:54
 * @LastEditors: clingxin
 * @LastEditTime: 2021-05-19 07:59:58
 * @FilePath: /flutter_object_detection/lib/main.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_object_detection/pages/splash_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Object Detector APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}
