import 'package:flutter/material.dart';

class EmptyHolder extends StatelessWidget {
  final String msg;

  EmptyHolder({this.msg});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(null != msg ? msg : "Loading..."),
    );
  }
}
