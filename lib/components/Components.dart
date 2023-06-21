import 'package:flutter/material.dart';

Text CustomText1(String text) {
  return Text(text,
      style: const TextStyle(
          color: Colors.grey,
          fontSize: 17,
          fontWeight: FontWeight.bold,
          wordSpacing: 3));
}

MaterialButton CustomMaterialButton(
    VoidCallback functionToBeExecuted, String text) {
  return MaterialButton(
    onPressed: functionToBeExecuted,
    child: Text(
      text,
      style: const TextStyle(fontSize: 19),
    ),
  );
}

AppBar MyAppBar(String text) {
  return AppBar(
    title: Text(text,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
    centerTitle: true,
    backgroundColor: Colors.grey[900],
  );
}
