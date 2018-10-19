import 'package:flutter/material.dart';
import 'package:wanandroid/fonts/IconF.dart';

class ClearableInputField extends StatefulWidget {
  final ValueChanged onchange;
  final ValueChanged onSubmit;
  final String hintTxt;
  final bool autoFocus;
  final TextStyle textStyle;
  final TextStyle hintStyle;
  final InputBorder border;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool obscureText;

  ClearableInputField(
      {this.onchange,
      this.hintTxt,
      this.autoFocus = true,
      this.onSubmit,
      this.textStyle,
      this.hintStyle,
      this.border,
      this.controller,
      this.inputType,
      this.obscureText = false});

  @override
  State<StatefulWidget> createState() => new _ClearableInputFieldState();
}

class _ClearableInputFieldState extends State<ClearableInputField> {
  bool showClearIcon = false;

  @override
  Widget build(BuildContext context) {
    var _controller = (null == widget.controller)
        ? TextEditingController()
        : widget.controller;
    return TextField(
      obscureText: widget.obscureText,
      keyboardType: widget.inputType,
      autofocus: widget.autoFocus,
      controller: _controller,
      style: widget.textStyle,
      onChanged: onTextChanged,
      onSubmitted: widget.onSubmit,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20.0),
        hintText: widget.hintTxt,
        hintStyle: widget.hintStyle,
        border: widget.border,
        suffixIcon: _buildDefaultClearIcon(context, _controller),
      ),
    );
  }

  void onTextChanged(String str) {
    setState(() {
      showClearIcon = (str.length <= 0) ? false : true;
    });
    widget.onchange(str);
  }

  Widget _buildDefaultClearIcon(
      BuildContext context, TextEditingController controller) {
    if (showClearIcon) {
      return InkWell(
        child: Icon(
          IconF.wrong,
          color: Theme.of(context).textTheme.subhead.color,
        ),
        onTap: () {
          controller.clear();
          setState(() {
            showClearIcon = false;
          });
        },
      );
    } else {
      return null;
    }
  }
}
