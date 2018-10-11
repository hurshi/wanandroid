import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EmptyHolder extends StatefulWidget {
  final String msg;

  EmptyHolder({this.msg});

  @override
  State<StatefulWidget> createState() => new _EmptyHolderState();
}

class _EmptyHolderState extends State<EmptyHolder> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(null != widget.msg ? widget.msg : "Loading..."),
    );
  }
}
