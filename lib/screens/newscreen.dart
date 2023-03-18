import 'package:flutter/material.dart';


class NewScreen extends StatelessWidget {
  const NewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const <Widget>[
          Text("Hello World"),
        ],
      ),
      body: const Center(
        child: Text("Hello World"),
      ),
    );
  }
}