import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Login Screen Example',
      home: Scaffold(body: Text("hey Flutter",textAlign: TextAlign.center,),));
  }
}
