import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:task_2/Face_detector_page.dart';

List<CameraDescription> cameras = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        backgroundColor: Colors.grey,
        accentColor: Colors.black,
        sliderTheme: const SliderThemeData(
          activeTrackColor: Colors.white,
          thumbColor: Colors.black,
          inactiveTrackColor: Colors.grey,
        ),
        scaffoldBackgroundColor: Colors.deepPurple[100],
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 150,
            height: 60,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40))),
            child: ElevatedButton(
              child: Row(
                children: const [
                  Icon(
                    Icons.camera_alt_outlined,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Camera",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const Face_detector();
                }));
              },
            ),
          ),
          const Divider(
            height: 30,
            thickness: 2.0,
            color: Colors.deepPurple,
          ),
          Container(
            // color: Colors.green,
            width: MediaQuery.of(context).size.width * 0.95,
            // height: MediaQuery.of(context).size.height * 0.5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                "assets/lgm.jpg",
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
    );
  }
}
