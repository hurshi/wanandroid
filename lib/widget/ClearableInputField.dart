import 'package:flutter/material.dart';
import 'package:wanandroid/fonts/IconF.dart';
import 'package:flutter/services.dart';

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
  final EdgeInsetsGeometry padding;

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
      this.padding,
      this.obscureText = false});

  @override
  State<StatefulWidget> createState() => new _ClearableInputFieldState();
}

class _ClearableInputFieldState extends State<ClearableInputField> {
  bool _showClearIcon = false;
  FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    var _controller = (null == widget.controller)
        ? TextEditingController()
        : widget.controller;
    _focusNode = FocusNode();
    return TextField(
      obscureText: widget.obscureText,
      keyboardType: widget.inputType,
      autofocus: widget.autoFocus,
      focusNode: _focusNode,
      controller: _controller,
      style: widget.textStyle,
      onChanged: onTextChanged,
      onSubmitted: onSubmit,
      decoration: InputDecoration(
        contentPadding:
            (null == widget.padding) ? EdgeInsets.all(20.0) : widget.padding,
        hintText: widget.hintTxt,
        hintStyle: widget.hintStyle,
        border: widget.border,
        suffixIcon: _buildDefaultClearIcon(context, _controller),
      ),
    );
  }

  void onTextChanged(String str) {
    bool newState = (str.length <= 0) ? false : true;
    if (newState != _showClearIcon) {
      setState(() {
        _showClearIcon = newState;
      });
    }
    widget.onchange(str);
  }

  void onSubmit(String str) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
//    FocusScope.of(context).requestFocus(new FocusNode());
    widget.onSubmit(str);
  }

  Widget _buildDefaultClearIcon(
      BuildContext context, TextEditingController controller) {
    if (_showClearIcon) {
      return InkWell(
        child: Icon(
          IconF.wrong,
          color: Theme.of(context).textTheme.subhead.color,
        ),
        onTap: () {
          controller.clear();
          widget.onchange("");
          FocusScope.of(context).requestFocus(_focusNode);
          setState(() {
            _showClearIcon = false;
          });
        },
      );
    } else {
      return null;
    }
  }
}
