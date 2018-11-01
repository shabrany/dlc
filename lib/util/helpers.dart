import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateTime convertToDate(String input) {
  try {
    var d = new DateFormat.yMd().parseStrict(input);
    return d;
  } catch (e) {
    return null;
  }
}

TimeOfDay convertToTime(String input) {
  try {
    var t = new DateFormat.jm().parseStrict(input);
    return new TimeOfDay.fromDateTime(t);
  } catch (e) {
    return null;
  }
}
