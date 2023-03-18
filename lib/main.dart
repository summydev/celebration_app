import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  final String title = 'Celebrating 1000 Followers';

  late AnimationController _controller;
  late ConfettiController _confettiController;
  bool _isCelebrating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _confettiController = ConfettiController(
      duration: Duration(seconds: 3),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _startCelebration() {
    setState(() {
      _isCelebrating = true;
    });
    _confettiController.play();
    _controller.forward().whenComplete(() {
      setState(() {
        _isCelebrating = false;
      });
      _controller.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                height: _isCelebrating ? 300 : 150,
                child: Icon(
                  Icons.favorite,
                  size: 100,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 20),
              TyperAnimatedTextKit(
                speed: Duration(milliseconds: 200),
                isRepeatingAnimation: false,
                text: ['Thank you for following!'],
                textStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _startCelebration,
                child: Text('Celebrate!'),
              ),
              ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                numberOfParticles: 20,
                gravity: 0.5,
                maxBlastForce: 10,
                minBlastForce: 5,
                colors: [
                  Colors.blue,
                  Colors.lightBlue,
                  Colors.red,
                  Colors.pink,
                  Colors.orange,
                  Colors.yellow,
                  Colors.green,
                  Colors.purple,
                  Colors.amber,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
