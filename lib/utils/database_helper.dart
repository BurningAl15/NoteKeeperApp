import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:notekeeper/models/note.dart';

class DatabaseHelper{
  static DatabaseHelper _databaseHelper; //Singleton DatabaseHelper
  static Database _database;

  String noteTable='note_table';
  String colId='id';
  String colTitle='title';
  String colDescription='description';
  String colPriority='priority';
  String colDate='date';

  DatabaseHelper._createInstance();

  //When u use factory for constructor, the constructor is allowed to return a value
  factory DatabaseHelper(){

    if(_databaseHelper==null){
      //Executes only once, singleton object
      _databaseHelper=DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }

  Future<Database> get database async{
    if(_database ==null) {
      _database=await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async{
    //Get the directory path for both Android and iOS to store database.
    Directory directory=await getApplicationDocumentsDirectory();
    String path=directory.path+'notes.db';

    //Open/create the database ata a given path
    var notesDatabase= openDatabase(path,version:1,onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async{
    await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colDescription TEXT, $colPriority INTEGER, $colDate TEXT');
  }

  //Fetch Operation: Get all note objects from database
  Future<List<Map<String,dynamic>>> getNoteMapList() async{
    Database db= await this.database;

    //Both are the same
    //var result=await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result=await db.query(noteTable,orderBy: '$colPriority ASC');
    return result;
  }

  //Insert Operation: Insert a Note Object to database
  Future<int> insertNote(Note note) async{
    Database db= await this.database;

    var result=await db.insert(noteTable,note.toMap());
    return result;
  }

  //Update Operations: Update a Note Object and save it to database
  Future<int> updateNote(Note note) async{
    Database db= await this.database;

    var result=await db.update(noteTable,note.toMap(),where:'$colId=?',whereArgs: [note.id]);
    return result;
  }

  //Delete Operation: Delete a Note Object from database
  Future<int> deleteNote(int id) async{
    Database db= await this.database;

    var result=await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
  }

  //Get Number of Note Objects in database
  Future<int> getCount() async{
    Database db=await this.database;
    List<Map<String,dynamic>> x =await db.rawQuery('SELECT COUNT (*) FROM $noteTable');
    int result=Sqflite.firstIntValue(x);
    return result;
  }
}
