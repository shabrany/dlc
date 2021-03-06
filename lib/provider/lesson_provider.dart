
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/lesson.dart';

class LessonProvider {

  Database db;

  LessonProvider();

  Future init() async {
    var databasePath = await getDatabasesPath();
    var path = join(databasePath, 'data.db');
    db = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE lessons (
        id INTEGER PRIMARY KEY,
        date TEXT,
        startTime TEXT,
        endTime TEXT
      )
    ''');
  }

  Future<Lesson> insert(Lesson lesson) async {
    Map _map = lesson.toMap();
    lesson.id = await db.insert('lessons', _map);
    return lesson;
  }

  Future<List<Lesson>> all() async {
    List<Map> rows = await db.rawQuery('SELECT * FROM lessons ORDER BY `date` DESC');
    List<Lesson> lessons = new List();

    if (rows.length > 0) {
      for (int i = 0; i < rows.length; i++) {
        Lesson lesson = new Lesson.init(rows[i]['date'], rows[i]['startTime'], rows[i]['endTime']);
        lesson.id = rows[i]['id'];
        lessons.add(lesson);
      }
    }
    return lessons;
  }

  Future<Lesson> findNext() async {
    String sql = "SELECT * FROM lessons WHERE `date` > DATE('NOW') ORDER BY `date` LIMIT 1";
    List<Map> row = await db.rawQuery(sql);
    Map rawLesson = row.first;

    return new Lesson.init(rawLesson['date'], rawLesson['startTime'], rawLesson['endTime']);
  }

  Future<int> delete(int id) async {
    return await db.delete('lessons', where: 'id = ?', whereArgs: [id]);
  }

}