import 'dart:ui';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Wrapper.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  whiteSplashScreen() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedSplashScreen(
            duration: 250,
            splash: Image.asset('assets/2.png'),
            nextScreen: AnimatedSplashScreen(
                duration: 150,
                splash:
                    Image.asset('assets/1.png'),
                nextScreen: Wrapper(),
                splashTransition: SplashTransition.fadeTransition,
                backgroundColor: Colors.white),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Color(0xff0CB5BB)));
  }
}
