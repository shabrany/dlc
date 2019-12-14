import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../app_colors.dart' as AppColors;
import 'package:rijleskaart/provider/lesson_provider.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _DashboardState();
  }
}

class _DashboardState extends State<Dashboard> {

  LessonProvider provider = new LessonProvider();

  String _nextLesson = '';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Voortgang')),
      body: ListView(
          children: <Widget>[
            this._showNextLesson()
          ]
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void loadData() async {
    await provider.init();
    provider.findNext().then((lesson) {
        setState(() {
          _nextLesson = lesson.getFormattedStartDate();
        });
    });
  }

  Widget _showNextLesson() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: <Widget>[
          this._buildCardNextLesson(),
          Divider(height: 55.0, color: AppColors.primary,)
        ],
      ),
    );
  }

  Widget _buildCardNextLesson() {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Column(
        children: <Widget>[
          Text(
            'Volgende Les'.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w800
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            children: <Widget> [
              Icon(Icons.calendar_today, size: 38.0),
              Text(_nextLesson, style: TextStyle(fontSize: 18.5))
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
