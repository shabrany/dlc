import 'package:flutter/material.dart';
import 'create_lesson.dart';

class Lessons extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _LessonsState();
}


class _LessonsState extends State<Lessons> {

  final List _lessons = List.generate(30, (i) => "Sat, 25 februari $i");

  final TextStyle _cardFooterStyle = TextStyle(color: Colors.grey);

  final Icon _cardFooterIcon = Icon(Icons.access_time, size: 20.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Afspraken')),
      body: _renderList(),
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => new FormNewLesson()));
        },
        tooltip: 'Nieuwe afspraak toevoegen',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _renderList() {
    return new ListView.builder(
      padding: EdgeInsets.fromLTRB(4.0, 1.0, 4.0, 1.0),
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
        //  shape: RoundedRectangleBorder(side: BorderSide(width: 1.0, color: Colors.grey.shade400)),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                _lessons[index],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
              child: _buildCardFooter()
            )
          ],
        )
      ),
    );//Card(child: Text(_lessons[index]));
  }

  Widget _buildCardFooter() {
    return Row(
      children: <Widget>[
        _cardFooterIcon,
        const SizedBox(width: 10.0),
        Text('19:00', style: _cardFooterStyle),
        const SizedBox(width: 10.0),
        Text('-', style: _cardFooterStyle),
        const SizedBox(width: 10.0),
        Text('--:--', style: _cardFooterStyle),
        Expanded(
          child: Text('70 min', textAlign: TextAlign.right),
        )
      ],
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