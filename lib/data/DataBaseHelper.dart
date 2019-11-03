import 'dart:async';
import 'dart:io';

import 'package:az_man_bepors/models/Grade.dart';
import 'package:az_man_bepors/models/Lesson.dart';
import 'package:az_man_bepors/models/Qustion.dart';
import 'package:az_man_bepors/models/User.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
final String tableWords = 'words';
final String columnId = '_id';
final String columnWord = 'word';
final String columnFrequency = 'frequency';


//class Word {
//
//  int id;
//  String word;
//  int frequency;
//
//  Word();
//
//  // convenience constructor to create a Word object
//  Word.fromMap(Map<String, dynamic> map) {
//    id = map[columnId];
//    word = map[columnWord];
//    frequency = map[columnFrequency];
//  }
//
//  // convenience method to create a Map from this Word object
//  Map<String, dynamic> toMap() {
//    var map = <String, dynamic>{
//      columnWord: word,
//      columnFrequency: frequency
//    };
//    if (id != null) {
//      map[columnId] = id;
//    }
//    return map;
//  }
//}
class DatabaseHelper {

  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();

    return _database;
  }

//   open the database
  _initDatabase() async {


    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
//    print(documentsDirectory.path);
    String path = join(documentsDirectory.path, _databaseName);


    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion,
        );
  }

  // SQL string to create the database
  Future createTables( ) async {

//
    print('in create table');
//    print(_database);
    Database db = await database;

    db.execute("DROP TABLE IF EXISTS tbl_users");
    db.execute("DROP TABLE IF EXISTS tbl_lessons");
    db.execute("DROP TABLE IF EXISTS tbl_grades");
    db.execute("DROP TABLE IF EXISTS tbl_questions");
    db.execute("DROP TABLE IF EXISTS tbl_configuration");



//    db.delete('tbl_lessons');
//    db.delete('tbl_grades');
//    db.delete('tbl_questions');
//    db.delete('tbl_configuration');
// print('table grades created');
    print('above creating tables ------');
     db.execute('''
              CREATE TABLE IF NOT EXISTS tbl_users (
                id INTEGER PRIMARY KEY,
                username TEXT NOT NULL,
                mobile INTEGER NOT NULL,
                password INTEGER NOT NULL,
                email TEXT NOT NULL,
                server_user_id INTEGER NOT NULL
              )
              ''');
    print('table grades users');
    db.execute('''
              CREATE TABLE IF NOT EXISTS tbl_grades (
                id INTEGER PRIMARY KEY,
                title TEXT NOT NULL,
                countOfLessons INTEGER NOT NULL,
                description TEXT
              )
              ''');
     db.execute('''
              CREATE TABLE IF NOT EXISTS tbl_lessons (
                id INTEGER PRIMARY KEY,
                title TEXT NOT NULL,
                grade_id INTEGER NOT NULL,
                description TEXT,
                FOREIGN KEY(grade_id) REFERENCES tbl_grades(id)
              )
              ''');
    print('table grades lessons');

    print('table grades grades');
     db.execute('''
              CREATE TABLE IF NOT EXISTS tbl_questions (
                id INTEGER PRIMARY KEY,
                lesson_id INTEGER NOT NULL,
                question_text TEXT NOT NULL,
                definition TEXT NOT NULL,
                FOREIGN KEY(lesson_id) REFERENCES tbl_lessons(id)
              )
              ''');
    print('table grades questions');
     db.execute('''
              CREATE TABLE IF NOT EXISTS tbl_configuration (
                id INTEGER PRIMARY KEY,
                last_version INTEGER NOT NULL
              )
              ''');
  }

//   Database helper methods:

  Future<int> insertUser(User user) async {
    print('in inser user');
    Database db = await database;
    int id = await db.insert('tbl_users', user.toMap());
    return id;
  }

  Future<Map<String , String>> queryUser(String username , String password) async {
    print('in query user');
    Database db = await database;

    List<Map> maps = await db.query('tbl_users',
        columns: ['username'],
        where: 'username = ? ',
        whereArgs: [username]);
    print(maps);

    if (maps.length <= 0) {
      return {"error":"true" , "errorMessage" : "you must sign up first." , "username":"null"};
    }
    else{
      if(maps.first["password"] != password.hashCode){
        return {"error":"true" , "errorMessage" : "password is incorrect" , "username":"null"};
      }
      else{
        String username = maps.first["username"];
        return {"error":"false" , "errorMessage" : "null" , "username":"$username"};
      }
    }
  }

  initializeTables(Map<String,dynamic> res)async {
    Database db = await database;

    // from map
    res["grades"].forEach((row) => db.insert('tbl_grades', row));
    res["lessons"].forEach((row) => db.insert('tbl_lessons', row));
    res["lessons"].forEach((row) => print(row));
    res["questions"].forEach((row) => db.insert('tbl_questions', row));
//    res["configuration"].forEach((row) => db.insert('tbl_configuration', row));
   }
   Future<List<Lesson>> getLessons(Grade grade) async{
    List<Lesson> lessons = new List<Lesson>();
    Database db = await database;
//    List<Map> maps = await db.query('tbl_lessons');
    List<Map> rowQuestions = await db.query('tbl_lessons',
        where: 'grade_id = ? ',
        whereArgs: [grade.id]);
     rowQuestions.forEach((row)=>lessons.add(Lesson.fromMap(row)));
    return lessons;
   }

  Future<List<Grade>> getGrades() async{
    List<Grade> grades = new List<Grade>();
    Database db = await database;
    List<Map> maps = await db.query('tbl_grades');
    maps.forEach((row)=>grades.add(Grade.fromMap(row)));
    return grades;
  }
  Future<List<Question>> getQuestion(Lesson lesson) async{
    List<Question> questions = new List <Question>();
    Database db = await database;
    List<Map> rowQuestions = await db.query('tbl_questions',
        where: 'lesson_id = ? ',
        whereArgs: [lesson.id]);
    rowQuestions.forEach((row)=>questions.add(Question.fromMap(row)));
    return questions;
  }
  Future<List<Question>> getSemester1(Grade grade) async{
    List<Lesson> lessons = new List<Lesson>();
    Database db = await database;
//    List<Map> maps = await db.query('tbl_lessons');
    List<Map> rowQuestions = await db.query('tbl_lessons',
        where: 'grade_id = ? ',
        whereArgs: [grade.id]);
    List<Question> questionsf = new List <Question>();
    rowQuestions.forEach((row)=>lessons.add(Lesson.fromMap(row)));
    lessons.forEach((lesson) {if(lesson.id<=grade.countOfLessons/2){
      lessons.forEach((lesson) async {
        List<Question> questions = new List <Question>();

        List<Map> rowQuestions = await db.query('tbl_questions',
            where: 'lesson_id = ? ',
            whereArgs: [lesson.id]);
        rowQuestions.forEach((row)=>questions.add(Question.fromMap(row)));
        questionsf.addAll(questions);
      });
    }});
    return questionsf;
  }
  Future<List<Question>> getSemester2(Grade grade) async{
    List<Lesson> lessons = new List<Lesson>();
    Database db = await database;
//    List<Map> maps = await db.query('tbl_lessons');
    List<Map> rowQuestions = await db.query('tbl_lessons',
        where: 'grade_id = ? ',
        whereArgs: [grade.id]);
    List<Question> questionsf = new List <Question>();
    rowQuestions.forEach((row)=>lessons.add(Lesson.fromMap(row)));
    lessons.forEach((lesson) {if(lesson.id > grade.countOfLessons/2){
      lessons.forEach((lesson) async {
        List<Question> questions = new List <Question>();

        List<Map> rowQuestions = await db.query('tbl_questions',
            where: 'lesson_id = ? ',
            whereArgs: [lesson.id]);
        rowQuestions.forEach((row)=>questions.add(Question.fromMap(row)));
        questionsf.addAll(questions);
      });
    }});
    return questionsf;
  }
}
