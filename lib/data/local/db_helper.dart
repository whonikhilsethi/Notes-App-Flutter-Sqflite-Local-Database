import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._(); // private constructor

  static getInstance() {
    return DBHelper._();
  }

  static final String TABLE_NOTE = "note";
  static final String COLUMN_NOTE_SNO = "s_no";
  static final String COLUMN_NOTE_TITLE = "title";
  static final String COLUMN_NOTE_DESC = "description";

  Database? myDB;
  Future<Database> getDB() async {
    if (myDB != null) {
      return myDB!;
    } else {
      myDB = await openDB();
      return openDB();
    }
  }

  Future<Database> openDB() async {
    Directory appdir = await getApplicationDocumentsDirectory();
    String dbpath = join(appdir.path, "noteDB.db");
    return await openDatabase(
      dbpath,
      onCreate: (db, version) {
        //tables will create here
        db.execute(
          "create table $TABLE_NOTE($COLUMN_NOTE_SNO integer primary key autoincrement, $COLUMN_NOTE_TITLE text, $COLUMN_NOTE_DESC text )",
        );
      },
      version: 1,
    );
  }

  // ADDING THE DATA
  Future<bool> addNote({
    required String mTitle,
    required String mDescription,
  }) async {
    var db = await getDB();
    int rowsaffected = await db.insert(TABLE_NOTE, {
      COLUMN_NOTE_TITLE: mTitle,
      COLUMN_NOTE_DESC: mDescription,
    });
    return rowsaffected > 0;
  }

  /// FETCHING THE DATA
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    var db = await getDB();
    List<Map<String, dynamic>> mdata = await db.query(TABLE_NOTE);
    return mdata;
  }

  /// UPDATING THE DATA
  Future<bool> updateNote({
    required String mtitle,
    required String mdesc,
    required int s_no,
  }) async {
    var db = await getDB();
    int rowsEffected = await db.update(TABLE_NOTE, {
      COLUMN_NOTE_TITLE: mtitle,
      COLUMN_NOTE_DESC: mdesc,
    }, where: "$COLUMN_NOTE_SNO= $s_no");
    return rowsEffected > 0;
  }

  //DELETING THE DATA
  Future<bool> deleteNote({required int s_no}) async {
    var db = await getDB();
    int rowsEffected = await db.delete(
      TABLE_NOTE,
      where: "$COLUMN_NOTE_SNO= ?",
      whereArgs: ["$s_no"],
    );
    return rowsEffected > 0;
  }
}
