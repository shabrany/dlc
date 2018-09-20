import 'package:flutter/material.dart';
//import 'dart:async';

class FormNewLesson extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _FormNewLessonState();

}

class _FormNewLessonState extends State<FormNewLesson> {

//  final DateTime _today = new DateTime.now();

//  final _lessonDateField = new TextEditingController();

  final GlobalKey<FormState>_formKey = new GlobalKey<FormState>();

  Map formData = {
    "lessonDate": "",
    "startTime": "",
    "endTime": "00:00"
  };

//  Future<Null> _selectDate(BuildContext context) async {
//    final DateTime datePicked = await showDatePicker(
//        context: context,
//        initialDate: _today,
//        firstDate: DateTime(2016),
//        lastDate: DateTime(2020)
//    );
//  }

  Widget buildTimeFields() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(labelText: 'Begintijd'),
            onSaved: (String value) => formData['startTime'] = value
          )
        ),

        SizedBox(width: 20.0),

        Expanded(
          child: TextFormField(
            decoration: InputDecoration(labelText: 'Eindtijd'),
            onSaved: (String value) => formData['endTime'] = value,
          )
        ),
      ],
    );
  }

  Widget _buildFormButton() {
    return SizedBox(
        width: double.infinity,
        child: RaisedButton(
          child: Text('Opslaan', style: TextStyle(color: Colors.white, fontSize: 18.0)),
          color: Colors.blue,
          onPressed: () => this._createAppointment(),
          padding: EdgeInsets.all(15.0),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Nieuwe afspraak')),
      body: Container(
        padding: new EdgeInsets.all(20.0),
        child: Form(
          key: this._formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Datum'),
                onSaved: (String value) => formData['lessonDate'] = value,
                keyboardType: TextInputType.datetime,
              ),

              SizedBox(height: 20.0),

              buildTimeFields(),

              SizedBox(height: 30.0),

              _buildFormButton()
            ],
          ),
        ),
      ),
    );
  }

  void _createAppointment() {

    _formKey.currentState.save();



    print(this.formData);
  }
}