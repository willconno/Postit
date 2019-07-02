
import 'package:flutter/widgets.dart';
import 'package:postit/view/login/LoginBloc.dart';
import 'package:postit/view/login/LoginWidget.dart';
import 'package:postit/view/notes/create/NoteCreateBloc.dart';
import 'package:postit/view/notes/create/NoteCreateWidget.dart';
import 'package:postit/view/notes/list/NoteListBloc.dart';
import 'package:postit/view/notes/list/NoteListWidget.dart';

class Routes {

  static Map<String, WidgetBuilder> getRoutes(context){
    return <String, WidgetBuilder>{
      '/login': (BuildContext context) => LoginBlocProvider(child: LoginWidget()),
      '/notes': (BuildContext context) => NoteListBlocProvider(child: NoteListWidget()),
      '/notes/create': (BuildContext context) => NoteCreateBlocProvider(child: NoteCreateWidget()),
    };
  }
}