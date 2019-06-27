// Flutter code sample for material.AppBar.actions.1

// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:flutter/material.dart';

import 'view/HomeView.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Notes';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: HomeWidget(),
    );
  }
}

