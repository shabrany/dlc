import 'package:flutter/material.dart';

class Lessons extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _LessonsState();
}


class _LessonsState extends State<Lessons> {

  final List _lessons = List.generate(30, (i) => "Item number $i");

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
        return _buildAppointmentItem(index);
      }
    );
  }

  Widget _buildAppointmentItem(int index) {
    return new Padding(
      padding: new EdgeInsets.all(5.0),
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
                leading: Icon(Icons.access_time, color: Colors.blue),
                title: Text(_lessons[index])
            ),
            Container(
              decoration: BoxDecoration(border: Border( top: BorderSide(color: Colors.blue[200]))),
              padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              child: Row(
                children: <Widget>[

                  Icon(Icons.timer),
                  Container(width: 10.0),
                  Text('19:00'),
                  Container(width: 15.0),
                  Text('--:--'),

                  Expanded(
                    child: Text('70 min', textAlign: TextAlign.right),
                  )
                ],
              ),
            )
          ],
        )
      ),
    );//Card(child: Text(_lessons[index]));
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