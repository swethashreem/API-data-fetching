import 'package:flutter/material.dart';
import 'package:flutter_pagination/firstpage.dart';
import 'package:flutter_pagination/secondpage.dart';

// import 'homepage1.dart';
 void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: firstpage(),
    );
  }
}
