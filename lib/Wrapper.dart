import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/Pages/BaseLayer.dart';
import 'package:news_app/auth/NewUser.dart';
import 'package:news_app/services/Constant.dart';

import 'Pages/Home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    check();
    if (user?.uid == null) {
      return FirstView();
    } else {
      return BaseLayer();
    }
  }
  check(){
    FirebaseAuth.instance
        .userChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!zzzzz');
      } else {
        Constants.uid = user.uid;
        print('User is signed in!zzzzz');
      }
    });
  }
}
