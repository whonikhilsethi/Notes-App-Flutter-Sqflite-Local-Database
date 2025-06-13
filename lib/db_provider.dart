import 'package:db_practice/data/local/db_helper.dart';
import 'package:flutter/material.dart';

class DbProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _mData = [];
  DBHelper dbHelper;
  DbProvider({required this.dbHelper});

  //events
  void addNote(String title, String desc) async {
    bool check = await dbHelper.addNote(mTitle: title, mDescription: desc);
    if (check) {
      _mData = await dbHelper.getAllNotes();
      notifyListeners();
    }
  }

  void updateNote(String title, String desc, int sno) async {
    bool check = await dbHelper.updateNote(
      mtitle: title,
      mdesc: desc,
      sno: sno,
    );
    if (check) {
      _mData = await dbHelper.getAllNotes();
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> getNotes() {
    return _mData;
  }

  void getInitialNotes() async {
    _mData = await dbHelper.getAllNotes();
    notifyListeners();
  }
}
