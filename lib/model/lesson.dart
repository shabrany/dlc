
import 'package:intl/intl.dart';

class Lesson {

  int id;

  String _date = '';

  DateTime _startTime;

  DateTime _endTime;

  DateFormat _df = new DateFormat.Hm();

  Lesson();

  Lesson.init(date, startTime, endTime) {
    this._date = date;
    this._startTime = _df.parse(startTime);
    this._endTime = _df.parse(endTime);
  }


  set date(String value) {
    _date = value;
  }

  set startTime(String value) {
    _startTime = _df.parse(value);
  }

  set endTime(String value) {
    _endTime = _df.parse(value);
  }

  String get date => _date;

  String get startTime => _df.format(_startTime);

  String get endTime => _df.format(_endTime);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "date": this._date,
      "startTime": _df.format(this._startTime),
      "endTime": _df.format(this._endTime)
    };

    if (this.id != null) {
      map['id'] = this.id;
    }

    return map;
  }

  int calculateDiff() {
    return this._endTime.difference(this._startTime).inMinutes;
  }

  bool valiateTimes() {
    return this._startTime.isBefore(this._endTime);
  }

}
