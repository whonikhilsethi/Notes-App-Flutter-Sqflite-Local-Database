import 'package:db_practice/data/local/db_helper.dart';
import 'package:db_practice/db_provider.dart';
import 'package:db_practice/home_page.dart';
import 'package:db_practice/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DbProvider(dbHelper: DBHelper.getInstance()),
        ),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DBHelper db = DBHelper.getInstance();

    return MaterialApp(
      themeMode:
          context.watch<ThemeProvider>().getThemeValue()
              ? ThemeMode.dark
              : ThemeMode.light,
      darkTheme: ThemeData.dark(),

      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
