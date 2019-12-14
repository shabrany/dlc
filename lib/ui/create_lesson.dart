import 'package:flutter/material.dart';
import 'dart:async';
import '../model/lesson.dart';
import '../provider/lesson_provider.dart';
import 'package:intl/intl.dart';
import 'package:rijleskaart/util/helpers.dart' as Util;
import 'package:rijleskaart/ui/app_colors.dart' as AppColors;

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
  var passKey = new GlobalKey<FormFieldState>();

  Lesson lesson = new Lesson();
  LessonProvider provider = new LessonProvider();

  Future<Null> _selectDate(BuildContext context, String initialDateString ) async {
    final DateTime datePicked = await showDatePicker(
        context: context,
        initialDate: Util.convertToDate(initialDateString) ?? _today,
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
        initialTime: Util.convertToTime(controller.text) ?? _now
    );

    if (timePicked == null) return;

    setState(() {
      controller.text = timePicked.format(context);
    });
  }



  Row _buildFormRowField(String label, TextFormField formField) {

    return Row(
      children: <Widget>[
        SizedBox(
            width: 100.0,
            child: Text(
                label,
                style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w900
                )
            )
        ),
        Expanded(child: Container(
          child: formField,
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        ))
      ],
    );
  }

  Widget _buildDateField() {
    TextFormField _dateField = new TextFormField(
      controller: _dateController,
      onSaved: (String value) { lesson.date = value; },
      validator: (value) {
        if (value.isEmpty) {
          return "Kies een datum, aub.";
        }
      },
    );
    Row _fieldGroup = this._buildFormRowField('DATUM:', _dateField);
    return new GestureDetector(
      child: AbsorbPointer(child: _fieldGroup),
      onTap: () => _selectDate(context, _dateController.text),
    );
  }

  Widget _buildStartTimeField() {
    TextFormField _textField = TextFormField(
      onSaved: (String value) => lesson.startTime = value,
      controller: _startTimeController,
      keyboardType: TextInputType.datetime,
      validator: (value) {
        if (value.isEmpty) {
          return "Kies een tijd, aub.";
        }
      },
    );

    Row _fieldGroup = this._buildFormRowField('BEGINTIJD', _textField);

    return new GestureDetector(
      child: AbsorbPointer(child: _fieldGroup),
      onTap: () => _selectTime(context, _startTimeController),
    );
  }

  Widget _buildEndTimeField() {
    TextFormField _textField = TextFormField(
      onSaved: (String value) => lesson.endTime = value,
      controller: _endTimeController
    );

    Row _fieldGroup = this._buildFormRowField('EINDTIJD', _textField);

    return new GestureDetector(
      child: AbsorbPointer(child: _fieldGroup),
      onTap: () => _selectTime(context, _endTimeController),
    );
  }

  Widget _buildFormButton() {
    return SizedBox(
        width: double.infinity,
        child: RaisedButton(
          child: Text('Opslaan', style: TextStyle(color: AppColors.primary, fontSize: 18.0)),
          color: AppColors.tertiary,
          onPressed: () => this._createAppointment(),
          padding: EdgeInsets.all(15.0),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Nieuwe afspraak')),
      backgroundColor: AppColors.secondary,
      body: SingleChildScrollView(
        child: Container(
          padding: new EdgeInsets.all(20.0),
          child: Form(
            key: this._formKey,
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                  margin: EdgeInsets.only(bottom: 15.0),
                  child: Column(
                    children: <Widget>[
                      _buildDateField(),
                      SizedBox(height: 20.0),
                      _buildStartTimeField(),
                      SizedBox(height: 20.0),
                      _buildEndTimeField(),
                    ],
                  ),
                ),


                _buildFormButton()
              ],
            ),
          ),
        )
      )
    );
  }

  void _createAppointment() {
    if (_formKey.currentState.validate()) {

      _formKey.currentState.save();

      provider.init().then((value) {
        provider.insert(lesson);
        Navigator.pop(context, 'saved');
      });
    }
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