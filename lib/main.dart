import 'package:flutter/material.dart';

import 'view/LoginView.dart';
import 'view/notes/NoteListView.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Notes';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: LoginWidget(),
      routes:  <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginWidget(),
        '/notes': (BuildContext context) => NoteListWidget(),
      },
    );
  }
}

