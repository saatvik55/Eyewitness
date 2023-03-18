import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    iconTheme: const IconThemeData(
        color: Colors
            .black), // set backbutton color here which will reflect in all screens.
    leading: const BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
