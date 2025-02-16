import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class MusicAnimationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated text for "Musically"
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  'Musically',
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: [Colors.blue, Colors.purple],
                      ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                  ),
                  speed: Duration(milliseconds: 100),
                ),
              ],
              totalRepeatCount: 1,
              pause: Duration(milliseconds: 1000),
            ),
            SizedBox(height: 20), // Space between texts
            // Static text for "Get into the world of music"
            Container(
              alignment: Alignment.center,
              child: Text(
                'Get into the world of music',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black, // You can change this to any color you like
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

