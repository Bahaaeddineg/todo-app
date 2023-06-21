import 'package:flutter/material.dart';
import 'views/home.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  //initialise
  await Hive.initFlutter();
  var box = await Hive.openBox('mybox');
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {'/': (context) => HomePage()},
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.grey[900],
        ),
      )));
}
