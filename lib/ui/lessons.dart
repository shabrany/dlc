import 'package:flutter/material.dart';

class Lessons extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _LessonsState();
  }

//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: AppBar(title: Text('Afspraken')),
//      body: new Container(
//        alignment: Alignment.topLeft,
//        child: Text('Een overzicht van alle lessen'),
//      ),
//    );

//  }
}


class _LessonsState extends State<Lessons> {

  final List _lessons = List.generate(1000, (i) => "Item number $i");

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Afspraken')),
      body: _renderList(),
    );
  }

  Widget _renderList() {
    return new ListView.builder(
      itemCount: _lessons.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(_lessons[index]),
        );
      }
    );
  }


  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}