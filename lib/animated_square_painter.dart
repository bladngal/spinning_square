import 'package:flutter/material.dart';

class AnimatedSquarePainter extends StatefulWidget {
  @override
  _AnimatedSquarePainterState createState() => _AnimatedSquarePainterState();
}

class _AnimatedSquarePainterState extends State<AnimatedSquarePainter>
    with SingleTickerProviderStateMixin {
  AnimationController borderController;
  Animation borderAnimation;
  double borderWidth = 10.0;
  @override
  void initState() {
    super.initState();
    borderController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    borderAnimation = Tween<double>(begin: 0.0, end: borderWidth)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(borderController);

    //Rebuilding the screen when animation goes ahead
    borderController.addListener(() {
      setState(() {});
    });

    borderController.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.completed:
        case AnimationStatus.dismissed:
          if (borderAnimation.value == borderWidth) {
            borderController.reverse();
          } else {
            borderController.forward();
          }

          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
