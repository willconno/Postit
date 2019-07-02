import 'package:flutter/widgets.dart';

class NoteListBloc {


}

class NoteListBlocProvider extends InheritedWidget {
  final bloc = NoteListBloc();

  NoteListBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;


  static NoteListBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(
        NoteListBlocProvider) as NoteListBlocProvider).bloc;
  }

}