
class Lesson {

  int id;

  String date = '';

  String startTime = '';

  String endTime = '';

  Lesson();

  Lesson.init(this.date, this.startTime, this.endTime);

  int calculateDiff() {
    return 0;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "date": this.date,
      "startTime": this.startTime,
      "endTime": this.endTime
    };

    if (this.id != null) {
      map['id'] = this.id;
    }

    print(map);

    return map;
  }


}
