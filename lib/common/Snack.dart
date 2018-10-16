import 'package:flutter/material.dart';

class Snack {
  static void show(BuildContext context, String str) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(null == str ? "" : str),
    ));
  }
}
