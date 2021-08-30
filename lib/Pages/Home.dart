import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/auth/NewUser.dart';
import 'package:news_app/services/auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initState() {
  }

  AuthMethod authMethod = new AuthMethod();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        FloatingActionButton(onPressed: (){
          final snackBar = SnackBar(content: Text('Signed Out'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          authMethod.signOut();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FirstView()),
          );
        },),
      ],)
    );
  }

}
