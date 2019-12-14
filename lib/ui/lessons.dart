import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rijleskaart/util/helpers.dart';
import 'create_lesson.dart';
import 'package:rijleskaart/provider/lesson_provider.dart';
import 'package:rijleskaart/model/lesson.dart';
import './app_colors.dart' as AppColors;

class Lessons extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _LessonsState();
}


class _LessonsState extends State<Lessons> {

  LessonProvider provider = new LessonProvider();

  List<Lesson> _lessons_ = new List();

  final TextStyle _cardFooterStyle = TextStyle(color: AppColors.textPrimary);

  final DateFormat df = new DateFormat("EEE, MMM d, ''yy");

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Afspraken'), backgroundColor: AppColors.primary),
      body: _renderList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createLesson(context),
        tooltip: 'Nieuwe afspraak toevoegen',
        child: Icon(Icons.add),
        backgroundColor: AppColors.tertiary,
        foregroundColor: AppColors.primary,
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
                formatDate(lesson.date),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: AppColors.primary),
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