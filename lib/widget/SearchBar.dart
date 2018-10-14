// Copyright (c) 2017, Spencer. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
// flutter_search_bar: ^2.0.7 copy from https://pub.dartlang.org/packages/flutter_search_bar

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

typedef Widget AppBarCallback(BuildContext context);
typedef void TextFieldSubmitCallback(String value);
typedef void TextFieldChangeCallback(String value);
typedef void SetStateCallback(void fn());

class SearchBar {
  /// Whether or not the search bar should close on submit. Defaults to true.
  final bool closeOnSubmit;

  /// Whether the text field should be cleared when it is submitted
  final bool clearOnSubmit;

  /// A void callback which takes a string as an argument, this is fired every time the search is submitted. Do what you want with the result.
  final TextFieldSubmitCallback onSubmitted;

  /// A void callback which gets fired on close button press.
  final VoidCallback onClosed;

  /// Since this should be inside of a State class, just pass setState to this.
  final SetStateCallback setState;

  /// Whether or not the search bar should add a clear input button, defaults to true.
  final bool showClearButton;

  final bool showBackButton;

  /// What the hintText on the search bar should be. Defaults to 'Search'.
  final String hintText;

  /// A callback which is invoked each time the text field's value changes
  final TextFieldChangeCallback onChanged;

  /// The controller to be used in the textField.
  TextEditingController controller;

  /// Whether the clear button should be active (fully colored) or inactive (greyed out)
  bool _clearActive = false;

  final Color bgColor;
  final Color clearButtonColor;
  final Color clearButtonDisablesColor;
  final Color textColor;

  final bool autoShowKeyboard;

  SearchBar(
      {@required this.setState,
      this.onSubmitted,
      this.controller,
      this.hintText = 'Search',
      this.bgColor,
      this.textColor,
      this.closeOnSubmit = true,
      this.clearOnSubmit = true,
      this.showBackButton = true,
      this.showClearButton = true,
      this.autoShowKeyboard = true,
      this.clearButtonColor,
      this.clearButtonDisablesColor,
      this.onChanged,
      this.onClosed}) {
    if (this.controller == null) {
      this.controller = new TextEditingController();
    }

    // Don't waste resources on listeners for the text controller if the dev
    // doesn't want a clear button anyways in the search bar
    if (!this.showClearButton) {
      return;
    }

    this.controller.addListener(() {
      if (this.controller.text.isEmpty) {
        // If clear is already disabled, don't disable it
        if (_clearActive) {
          setState(() {
            _clearActive = false;
          });
        }

        return;
      }

      // If clear is already enabled, don't enable it
      if (!_clearActive) {
        setState(() {
          _clearActive = true;
        });
      }
    });
  }

  /// Builds the search bar!
  ///
  /// The leading will always be a back button.
  /// backgroundColor is determined by the value of inBar
  /// title is always a [TextField] with the key 'SearchBarTextField', and various text stylings based on [inBar]. This is also where [onSubmitted] has its listener registered.
  ///
  AppBar buildSearchBar(BuildContext context) {
    return new AppBar(
      backgroundColor: bgColor,
      leading: showBackButton
          ? IconButton(
              icon: const BackButtonIcon(),
              color: null,
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              onPressed: () {
                if (onClosed != null) {
                  onClosed();
                }
                controller.clear();
                Navigator.maybePop(context);
              })
          : null,
      title: new Directionality(
          textDirection: Directionality.of(context),
          child: new TextField(
//            focusNode: _focusNode,
            key: new Key('SearchBarTextField'),
            keyboardType: TextInputType.text,
            style: new TextStyle(color: textColor, fontSize: 16.0),
            decoration: new InputDecoration(
                hintText: hintText,
                hintStyle: new TextStyle(
//                    color: textColor,
                    fontSize: 16.0),
                border: null),
            onChanged: this.onChanged,
            onSubmitted: (String val) async {
              if (closeOnSubmit) {
                await Navigator.maybePop(context);
              }

              if (clearOnSubmit) {
                controller.clear();
              }

              onSubmitted(val);
            },
            autofocus: autoShowKeyboard,
            controller: controller,
          )),
      actions: !showClearButton
          ? null
          : <Widget>[
              // Show an icon if clear is not active, so there's no ripple on tap
              new IconButton(
                  icon: new Icon(Icons.clear,
                      color: _clearActive
                          ? clearButtonColor
                          : clearButtonDisablesColor),
                  onPressed: !_clearActive
                      ? null
                      : () {
                          controller.clear();
                        })
            ],
    );
  }

  /// Returns an AppBar based on the value of [isSearching]
  AppBar build(BuildContext context) {
    return buildSearchBar(context);
//    return isSearching.value ? buildSearchBar(context) : buildAppBar(context);
  }
}
