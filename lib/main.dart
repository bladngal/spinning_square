// ignore: avoid_web_libraries_in_flutter
import 'square_painter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pendulum Man',
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
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Pendulum Man'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController rotationController;
  AnimationController borderController;
  Animation spinAnimation;
  Animation borderAnimation;
  Color squareColor = Colors.indigo;
  double rotation = 0.0;
  double borderWidth = 40.0;
  bool isGoingForward = true;
  String hiddenMessage;
  double fontSize = 20;
  double sliderValue = 20;

  @override
  void initState() {
    super.initState();
    double startValue = 3.34 + (3.14 / 2);
    double endValue = 6.08 + (3.14 / 2);
    rotationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    spinAnimation = Tween<double>(begin: startValue, end: endValue)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(rotationController);
    borderController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    borderAnimation = Tween<double>(begin: borderWidth, end: 0.0)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(borderController);

    //Rebuilding the screen when animation goes ahead
    rotationController.addListener(() {
      setState(() {});
    });
    borderController.addListener(() {
      setState(() {});
    });

    rotationController.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.completed:
        case AnimationStatus.dismissed:
          if (spinAnimation.value == startValue) {
            isGoingForward = true;
            hiddenMessage = 'HELP';
            rotationController.forward();
          } else {
            isGoingForward = false;
            hiddenMessage = 'ME';
            rotationController.reverse();
          }

          break;
        default:
      }
    });

    borderController.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.completed:
          if (borderAnimation.value == 0.0) {
            borderController.reverse();
          }
          break;

        case AnimationStatus.dismissed:
          if (borderAnimation.value == borderWidth) {
            borderController.forward();
          }
          //else {
          //   borderController.repeat();
          // }

          break;
        default:
      }
    });
  }

  // void _rotateSquare() {
  //   // setState(() {
  //   //   //spinAnimation.animate(controller);
  //   //   //squareColor = Colors.red;
  //   //   rotation += (0.125 * pi); //rotate one-eighth each click
  //   // });
  //   rotationController.forward();
  // }

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
          Center(
            child: Container(
              color: Colors.red,
              child: Transform.rotate(
                alignment: Alignment.topCenter,
                angle: spinAnimation.value,
                //angle: rotation,
                child: Container(
                  height: 200,
                  width: 200,
                  child: CustomPaint(
                      painter: SquarePainter(
                          innerColor: squareColor,
                          borderWidth: borderAnimation.value,
                          goingForward: isGoingForward,
                          fontSize: fontSize)),
                ),
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              child: Chip(
                label: Text(
                  'swing me',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: squareColor,
              ),
              onTapDown: (value) {
                setState(() {
                  if (isGoingForward) {
                    rotationController.forward();
                    borderController.forward();
                  } else {
                    rotationController.reverse();
                    borderController.reverse();
                  }
                });
              },
              onTapUp: (value) {
                setState(() {
                  rotationController.stop();
                  borderController.stop();
                });
              },
            ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.indigoAccent,
              //Colors.red[700],
              inactiveTrackColor: squareColor,
              //Colors.red[100],
              trackShape: RoundedRectSliderTrackShape(),
              trackHeight: 40.0,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
              thumbColor: Colors.white,
              overlayColor: Colors.indigoAccent.withAlpha(32),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
              valueIndicatorShape: PaddleSliderValueIndicatorShape(),
              valueIndicatorColor: Colors.redAccent,
              valueIndicatorTextStyle: TextStyle(
                color: Colors.black,
              ),
            ),
            child: Slider(
              value: sliderValue,
              min: 0,
              max: 50,
              label: borderWidth.round().toString(),
              onChanged: (double value) {
                setState(() {
                  //borderController.stop();
                  fontSize = value;
                  sliderValue = value;
                  //borderController.forward();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
