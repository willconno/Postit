import 'package:flutter/material.dart';
import 'package:postit/routes.dart';
import 'package:postit/view/login/LoginBloc.dart';

import 'package:postit/view/login/LoginWidget.dart';


void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Notes';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: LoginBlocProvider(
        child: LoginWidget()
      ),
      routes: Routes.getRoutes(context),
    );
  }
}
