import 'package:flutter/material.dart';
import 'package:wanandroid/fonts/IconF.dart';

class ClearableInputField extends StatefulWidget {
  final ValueChanged onchange;
  final ValueChanged onSubmit;
  final String hintTxt;
  final bool autoFocus;
  final TextStyle labelStyle;
  final InputBorder border;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool obscureText;

  ClearableInputField(
      {this.onchange,
      this.hintTxt,
      this.autoFocus = true,
      this.onSubmit,
      this.labelStyle,
      this.border,
      this.controller,
      this.inputType,
      this.obscureText = false});

  @override
  State<StatefulWidget> createState() => new _ClearableInputFieldState();
}

class _ClearableInputFieldState extends State<ClearableInputField> {
  @override
  Widget build(BuildContext context) {
    var controller = (null == widget.controller)
        ? TextEditingController()
        : widget.controller;
    return TextField(
      obscureText: widget.obscureText,
      keyboardType: widget.inputType,
      autofocus: widget.autoFocus,
      controller: controller,
      onChanged: widget.onchange,
      onSubmitted: widget.onSubmit,
      decoration: InputDecoration(
        labelStyle: widget.labelStyle,
        hintText: widget.hintTxt,
        border: widget.border,
        suffixIcon: _buildDefaultClearIcon(controller),
      ),
    );
  }

  Widget _buildDefaultClearIcon(TextEditingController controller) {
    return InkWell(
      child: Icon(IconF.wrong),
      onTap: () {
        controller.clear();
      },
    );
  }
}
