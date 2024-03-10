import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late ConfettiController _controllerCenter;
  late ConfettiController _controllerCenterRight;
  late ConfettiController _controllerCenterLeft;
  late ConfettiController _controllerTopCenter;
  late ConfettiController _controllerBottomCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenterRight = ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenterLeft = ConfettiController(duration: const Duration(seconds: 10));
    _controllerTopCenter = ConfettiController(duration: const Duration(seconds: 10));
    _controllerBottomCenter = ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();
    _controllerTopCenter.dispose();
    _controllerBottomCenter.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text('Confetti Carnival'),),
          body: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: ConfettiWidget(
                  confettiController: _controllerCenter,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: true,
                  colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
                  createParticlePath: drawStar,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                    onPressed: () {
                      _controllerCenter.play();
                    },
                    child: _display('blast\nstars')),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ConfettiWidget(
                  confettiController: _controllerCenterRight,
                  blastDirection: pi,
                  particleDrag: 0.05,
                  emissionFrequency: 0.05,
                  numberOfParticles: 20,
                  gravity: 0.05,
                  shouldLoop: false,
                  colors: const [Colors.green, Colors.blue, Colors.pink],
                  strokeWidth: 1,
                  strokeColor: Colors.white,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      _controllerCenterRight.play();
                    },
                    child: _display('pump left')),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: ConfettiWidget(
                  confettiController: _controllerCenterLeft,
                  blastDirection: 0,
                  emissionFrequency: 0.6,
                  minimumSize: const Size(10, 10),
                  maximumSize: const Size(50, 50),
                  numberOfParticles: 1,
                  gravity: 0.1,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                    onPressed: () {
                      _controllerCenterLeft.play();
                    },
                    child: _display('singles')),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _controllerTopCenter,
                  blastDirection: pi / 2,
                  maxBlastForce: 5,
                  minBlastForce: 2,
                  emissionFrequency: 0.05,
                  numberOfParticles: 50,
                  gravity: 1,
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: TextButton(
                    onPressed: () {
                      _controllerTopCenter.play();
                    },
                    child: _display('goliath')),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ConfettiWidget(
                  confettiController: _controllerBottomCenter,
                  blastDirection: -pi / 2,
                  emissionFrequency: 0.01,
                  numberOfParticles: 20,
                  maxBlastForce: 100,
                  minBlastForce: 80,
                  gravity: 0.3,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                    onPressed: () {
                      _controllerBottomCenter.play();
                    },
                    child: _display('hard and infrequent')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text _display(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.black, fontSize: 20), // Changed color to black for visibility
    );
  }
}
