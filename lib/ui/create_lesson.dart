import 'package:flutter/material.dart';
import 'dart:async';
import '../model/lesson.dart';
import 'package:intl/intl.dart';

class FormNewLesson extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _FormNewLessonState();
}

class _FormNewLessonState extends State<FormNewLesson> {

  final DateTime _today = new DateTime.now();
  final TimeOfDay _now = new TimeOfDay.now();
  final _dateController = new TextEditingController();
  final _startTimeController = new TextEditingController();
  final _endTimeController = new TextEditingController();

  final GlobalKey<FormState>_formKey = new GlobalKey<FormState>();

  Lesson lesson = new Lesson();

  Future<Null> _selectDate(BuildContext context, String initialDateString ) async {
    final DateTime datePicked = await showDatePicker(
        context: context,
        initialDate: convertToDate(initialDateString) ?? _today,
        firstDate: DateTime(2016),
        lastDate: DateTime(2020)
    );

    if (datePicked == null) return;

    setState(() {
      _dateController.text = new DateFormat.yMd().format(datePicked);
    });
  }

  Future<Null> _selectTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay timePicked = await showTimePicker(
        context: context,
        initialTime: convertToTime(controller.text) ?? _now
    );

    if (timePicked == null) return;

    setState(() {
      controller.text = timePicked.format(context);
    });
  }

  TimeOfDay convertToTime(String input) {
    try {
      var t = new DateFormat.jm().parseStrict(input);
      return new TimeOfDay.fromDateTime(t);
    } catch (e) {
      return null;
    }
  }

  DateTime convertToDate(String input) {
    try {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

  Row _buildFormRowField(String label, TextFormField formField) {
    return Row(
      children: <Widget>[
        SizedBox(width: 120.0, child: Text(label, style: TextStyle(fontSize: 18.0))),
        Expanded(child: Container(
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
          ),
          child: formField,
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        ))
      ],
    );
  }

  Widget _buildDateField() {
    TextFormField _dateField = new TextFormField(controller: _dateController, decoration: textInputDecoration());
    Row _fieldGroup = this._buildFormRowField('Datum:', _dateField);
    return new GestureDetector(
      child: AbsorbPointer(child: _fieldGroup),
      onTap: () => _selectDate(context, _dateController.text),
    );
  }

  Widget _buildStartTimeField() {
    TextFormField _textField = TextFormField(
      decoration: textInputDecoration(),
      onSaved: (String value) => lesson.startTime = value,
      controller: _startTimeController,
      keyboardType: TextInputType.datetime,
    );

    Row _fieldGroup = this._buildFormRowField('Begintijd', _textField);

    return new GestureDetector(
      child: AbsorbPointer(child: _fieldGroup),
      onTap: () => _selectTime(context, _startTimeController),
    );
  }

  Widget _buildEndTimeField() {
    TextFormField _textField = TextFormField(
      decoration: textInputDecoration(),
      onSaved: (String value) => lesson.endTime = value,
      controller: _endTimeController,
      keyboardType: TextInputType.datetime,
    );

    Row _fieldGroup = this._buildFormRowField('Eindtijd', _textField);

    return new GestureDetector(
      child: AbsorbPointer(child: _fieldGroup),
      onTap: () => _selectTime(context, _endTimeController),
    );
  }

  InputDecoration textInputDecoration () {
    return InputDecoration(
        border: InputBorder.none,
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
      body: SingleChildScrollView(
        child: Container(
          padding: new EdgeInsets.all(20.0),
          child: Form(
            key: this._formKey,
            child: Column(
              children: <Widget>[
                _buildDateField(),
                SizedBox(height: 20.0),
                _buildStartTimeField(),
                SizedBox(height: 20.0),
                _buildEndTimeField(),
                SizedBox(height: 30.0),
                _buildFormButton()
              ],
            ),
          ),
        )
      )
    );
  }

  void _createAppointment() {

    _formKey.currentState.save();

    print(lesson);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}