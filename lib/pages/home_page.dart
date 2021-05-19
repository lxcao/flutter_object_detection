/*
 * @Author: clingxin
 * @Date: 2021-05-19 08:27:14
 * @LastEditors: clingxin
 * @LastEditTime: 2021-05-19 11:30:28
 * @FilePath: /flutter_object_detection/lib/pages/home_page.dart
 */
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_object_detection/main.dart';
import 'package:tflite/tflite.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CameraController cameraController;
  bool isBusy = false;
  CameraImage imgCamera;
  String result = "";

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/models/mobilenet_v1_1.0_224.tflite",
        labels: "assets/models/mobilenet_v1_1.0_224.txt");
  }

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
                  runModelOnStreamFrames(),
                }
            });
      });
    });
  }

  runModelOnStreamFrames() async {
    if (imgCamera != null) {
      var recognitions = await Tflite.runModelOnFrame(
        bytesList: imgCamera.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: imgCamera.height,
        imageWidth: imgCamera.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true,
      );
      result = "";
      recognitions.forEach((response) {
        result += response["label"] +
            "   " +
            (response["confidence"] as double).toStringAsFixed(2) +
            "\n\n";
      });
      setState(() {
        result;
      });
      isBusy = false;
    }
  }

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  @override
  void dispose() {
    cameraController?.dispose();
    Tflite.close();
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
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 55),
              child: SingleChildScrollView(
                child: Text(
                  result,
                  style: TextStyle(
                    backgroundColor: Colors.black87,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
