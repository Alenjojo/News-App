import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Pages/splash.dart';
import 'package:news_app/auth/NewUser.dart';
import 'package:news_app/auth/SignupPage.dart';
import 'package:news_app/services/auth.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

import 'Wrapper.dart';
import 'model/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SplashScreen(),
    );
  }
}

