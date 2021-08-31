import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Pages/Home.dart';
import 'package:news_app/Pages/Profile.dart';
import 'package:news_app/Pages/Search.dart';
class BaseLayer extends StatefulWidget {
  const BaseLayer({Key? key}) : super(key: key);

  @override
  _BaseLayerState createState() => _BaseLayerState();
}

class _BaseLayerState extends State<BaseLayer> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      bottomNavigationBar: buildBottomNavigation(),
    );
  }

  Widget buildBody() {
    switch (index){
      case 1:
        return Search();
      case 2:
        return Profile();
      case 0:
      default:
        return Home();
    }
  }

  Widget buildBottomNavigation() {
    return BottomNavyBar(
      selectedIndex: index,
        onItemSelected: (index) => setState(() => this.index = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              icon: Icon(Icons.apps),
              title: Text('Home'),
              activeColor: Colors.black,
              inactiveColor: Colors.black,
              textAlign: TextAlign.center),
          BottomNavyBarItem(
              icon: Icon(Icons.search),
              title: Text('Search'),
              activeColor: Colors.black,
              inactiveColor: Colors.black,
              textAlign: TextAlign.center),
          BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile.dart'),
              activeColor: Colors.black,
              inactiveColor: Colors.black,
              textAlign: TextAlign.center),

        ],
    );
  }
}
