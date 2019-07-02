
import 'package:flutter/widgets.dart';

class NoteCreateBloc {


}

class NoteCreateBlocProvider extends InheritedWidget {
  final bloc = NoteCreateBloc();

  NoteCreateBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  static NoteCreateBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(
        NoteCreateBlocProvider) as NoteCreateBlocProvider).bloc;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}