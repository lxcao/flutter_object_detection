/*
 * @Author: clingxin
 * @Date: 2021-05-19 07:28:54
 * @LastEditors: clingxin
 * @LastEditTime: 2021-05-19 08:38:42
 * @FilePath: /flutter_object_detection/lib/main.dart
 */
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_object_detection/pages/splash_page.dart';

List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
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
