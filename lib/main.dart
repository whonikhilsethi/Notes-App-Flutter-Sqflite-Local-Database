import 'package:db_practice/data/local/db_helper.dart';
import 'package:db_practice/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DBHelper db = DBHelper.getInstance();

    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
