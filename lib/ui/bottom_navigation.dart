import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: [
      new BottomNavigationBarItem(icon: Icon(Icons.timeline), title: Text("Voortgang")),
      new BottomNavigationBarItem(icon: Icon(Icons.schedule), title: Text("Afspraken")),
      new BottomNavigationBarItem(icon: Icon(Icons.star), title: Text("Vaardigheden")),
    ], onTap: (int index) {

      debugPrint("Index pressed: $index");

      switch (index) {
        case 0:
          Navigator.pop(context);
          //Navigator.push(context, new MaterialPageRoute(builder: new Dash))
      }

    },);
  }



}