import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:task_2/CameraView.dart';
import 'package:task_2/face_detector_painter.dart';

class Face_detector extends StatefulWidget {
  const Face_detector({Key? key}) : super(key: key);

  @override
  State<Face_detector> createState() => _Face_detectorState();
}

class _Face_detectorState extends State<Face_detector> {
  final FaceDetector face_detector = FaceDetector(
      options: FaceDetectorOptions(
          enableContours: true, enableClassification: true));
  bool canProcess = true;
  bool isbusy = false;
  CustomPaint? custompaint;
  String? _text;

  @override
  void dispose() {
    // TODO: implement dispose

    canProcess = false;
    face_detector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Camera_view(
      Title: 'Face Detector',
      custompaint: custompaint,
      Text: _text,
      onImage: (inputimage) {
        processImage(inputimage);
      },
      initialDirection: CameraLensDirection.front,
    );
  }

  Future<void> processImage(final InputImage inputimage) async {
    if (!canProcess) {
      return;
    }
    if (isbusy) return;
    isbusy = true;
    setState(() {
      _text = " ";
    });
    final faces = await face_detector.processImage(inputimage);
    if (inputimage.inputImageData?.size != null &&
        inputimage.inputImageData?.imageRotation != null) {
      final Painter = FaceDetectorPainter(
          faces,
          inputimage.inputImageData!.size,
          inputimage.inputImageData!.imageRotation);
      custompaint = CustomPaint(
        painter: Painter,
      );
    } else {
      String text = 'faces found:${faces.length}\n\n';
      for (final face in faces) {
        text += 'face:${face.boundingBox}\n\n';
      }
      _text = text;
      custompaint = null;
    }
    isbusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
