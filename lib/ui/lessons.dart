import 'package:flutter/material.dart';
import 'create_lesson.dart';
import 'package:rijleskaart/provider/lesson_provider.dart';
import 'package:rijleskaart/model/lesson.dart';

class Lessons extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _LessonsState();
}


class _LessonsState extends State<Lessons> {

  LessonProvider provider = new LessonProvider();

  List<Lesson> _lessons_ = new List();

  final TextStyle _cardFooterStyle = TextStyle(color: Colors.grey);

  final Icon _cardFooterIcon = Icon(Icons.access_time, size: 20.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Afspraken')),
      body: _renderList(),
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createLesson(context),
        tooltip: 'Nieuwe afspraak toevoegen',
        child: Icon(Icons.add),
      ),
    );
  }

  void _createLesson(BuildContext context) async {
    String result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => new FormNewLesson())
    );

    if (result == 'saved') {
      _lessons_.clear();
      loadData();
    }
  }

  Widget _renderList() {
    return new ListView.builder(
      padding: EdgeInsets.fromLTRB(4.0, 1.0, 4.0, 1.0),
      itemCount: _lessons_.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildAppointmentItem(_lessons_[index]);
      }
    );
  }

  Widget _buildAppointmentItem(Lesson lesson) {
    return new Padding(
      padding: new EdgeInsets.all(5.0),
      child: Card(
        //  shape: RoundedRectangleBorder(side: BorderSide(width: 1.0, color: Colors.grey.shade400)),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                lesson.date,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
              child: _buildCardFooter(lesson)
            )
          ],
        )
      ),
    );//Card(child: Text(_lessons[index]));
  }

  Widget _buildCardFooter(Lesson lesson) {
    return Row(
      children: <Widget>[
        _cardFooterIcon,
        const SizedBox(width: 10.0),
        Text(lesson.startTime, style: _cardFooterStyle),
        const SizedBox(width: 10.0),
        Text('-', style: _cardFooterStyle),
        const SizedBox(width: 10.0),
        Text(lesson.endTime, style: _cardFooterStyle),
        Expanded(
          child: Text('${lesson.calculateDiff()}  min', textAlign: TextAlign.right),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    await provider.init();
    provider.all().then((lessons) {
      setState(() {
        _lessons_ = lessons;
      });
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}