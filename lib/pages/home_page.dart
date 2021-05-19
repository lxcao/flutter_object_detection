/*
 * @Author: clingxin
 * @Date: 2021-05-19 08:27:14
 * @LastEditors: clingxin
 * @LastEditTime: 2021-05-19 09:24:50
 * @FilePath: /flutter_object_detection/lib/pages/home_page.dart
 */
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_object_detection/main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CameraController cameraController;
  bool isBusy = false;
  CameraImage imgCamera;
  String result = "";

  void initCamera() {
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController.startImageStream((image) => {
              if (!isBusy)
                {
                  isBusy = true,
                  imgCamera = image,
                }
            });
      });
    });
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Object Detector"),
      ),
      body: Column(
        children: [
          Center(
            child: FlatButton(
              onPressed: () {
                initCamera();
              },
              child: Container(
                margin: EdgeInsets.only(top: 35),
                height: 360,
                width: 270,
                child: imgCamera == null
                    ? Container(
                        height: 360,
                        width: 270,
                        child: Icon(
                          Icons.photo_camera_front,
                          color: Colors.blueAccent,
                          size: 40,
                        ),
                      )
                    : AspectRatio(
                        aspectRatio: cameraController.value.aspectRatio,
                        child: CameraPreview(cameraController),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
