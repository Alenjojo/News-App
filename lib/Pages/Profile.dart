import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/auth/NewUser.dart';
import 'package:news_app/services/auth.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  AuthMethod authMethod = new AuthMethod();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:
      FloatingActionButton(onPressed: (){
          final snackBar = SnackBar(content: Text('Signed Out'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          authMethod.signOut();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FirstView()),
          );
        },child: Text("Sign Out"),),
      ),
    );
  }
}
