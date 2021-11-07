import 'package:flutter/material.dart';

class SquarePainter extends CustomPainter {
  Color innerColor;
  double borderWidth;
  bool goingForward;
  double fontSize;

  SquarePainter(
      {this.innerColor, this.borderWidth, this.goingForward, this.fontSize});

  @override
  void paint(Canvas canvas, Size size) {
    final solidSquarePaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = 200.0
      ..color = innerColor;

    final borderSquarePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = borderWidth
      ..color = Colors.indigoAccent;

    final manInSquarePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0
      ..color = Colors.white;

    double centerWidth = size.width / 2;
    double centerHeight = size.height / 2;
    double squareSize = 200;

    canvas.drawRect(
        Rect.fromLTWH(centerWidth - squareSize / 2,
            centerHeight - squareSize / 2, squareSize, squareSize),
        solidSquarePaint);

    //draw border
    canvas.drawRect(
        Rect.fromLTWH(centerWidth - squareSize / 2,
            centerHeight - squareSize / 2, squareSize, squareSize),
        borderSquarePaint);

/*****************************/
//  Draw a little man now.   //
/*****************************/

    //head
    canvas.drawCircle(
        Offset(centerWidth, centerHeight + 30), 20.0, manInSquarePaint);

    //eyes
    canvas.drawCircle(
        Offset(centerWidth - 5, centerHeight + 40), 3.0, manInSquarePaint);
    canvas.drawCircle(
        Offset(centerWidth + 5, centerHeight + 40), 3.0, manInSquarePaint);

    //mouth
    canvas.drawCircle(
        Offset(centerWidth, centerHeight + 25), 5.0, manInSquarePaint);

    //body
    canvas.drawLine(Offset(centerWidth, centerHeight + 10),
        Offset(centerWidth, centerHeight - 25), manInSquarePaint);

    //right leg
    canvas.drawLine(Offset(centerWidth, centerHeight - 25),
        Offset(centerWidth - 15, centerHeight - 70), manInSquarePaint);

    //left leg
    canvas.drawLine(Offset(centerWidth, centerHeight - 25),
        Offset(centerWidth + 15, centerHeight - 70), manInSquarePaint);

    //left arm
    canvas.drawLine(Offset(centerWidth, centerHeight - 15),
        Offset(centerWidth + 25, centerHeight + 15), manInSquarePaint);

    //right arm
    canvas.drawLine(Offset(centerWidth, centerHeight - 15),
        Offset(centerWidth - 25, centerHeight + 15), manInSquarePaint);

    /******************************************* 
    //  Add some text here...
    ******************************************/

    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: fontSize,
    );
    final leftTextSpan = TextSpan(
      text: 'Help',
      style: textStyle,
    );
    final rightTextSpan = TextSpan(
      text: 'Me',
      style: textStyle,
    );
    final leftTextPainter = TextPainter(
      text: leftTextSpan,
      textDirection: TextDirection.ltr,
    );
    final rightTextPainter = TextPainter(
      text: rightTextSpan,
      textDirection: TextDirection.ltr,
    );
    leftTextPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    rightTextPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final leftOffset = Offset(30, 150);
    final rightOffset = Offset(140, 150);
    if (goingForward) {
      leftTextPainter.paint(canvas, leftOffset);
    } else {
      rightTextPainter.paint(canvas, rightOffset);
    }
  }

  @override
  bool shouldRepaint(SquarePainter oldDelegate) => true;
}
