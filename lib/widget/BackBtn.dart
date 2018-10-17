import 'package:flutter/material.dart';
import 'package:wanandroid/fonts/IconF.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({Key key, this.color}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return IconButton(
        icon: Icon(IconF.back),
        color: color,
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        onPressed: () {
          Navigator.maybePop(context);
        });
  }
}
