import 'package:finspace/Homepage/home.dart';
import 'package:finspace/intro/first_page.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(App());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}
