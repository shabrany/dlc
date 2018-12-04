import 'package:flutter/material.dart';
import '../app_colors.dart' as AppColors;

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _DashboardState();
  }
}

class _DashboardState extends State<Dashboard> {
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
              Text('Woe, 16 Maart @ 15:00', style: TextStyle(fontSize: 18.0))
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
