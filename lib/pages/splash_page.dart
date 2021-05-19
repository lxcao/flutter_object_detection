/*
 * @Author: clingxin
 * @Date: 2021-05-19 07:54:47
 * @LastEditors: clingxin
 * @LastEditTime: 2021-05-19 08:30:46
 * @FilePath: /flutter_object_detection/lib/pages/splash_page.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_object_detection/pages/home_page.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterSeconds: HomePage(),
      useLoader: true,
      loaderColor: Theme.of(context).primaryColor,
      loadingText: Text(
        "loading...",
        style: TextStyle(
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
