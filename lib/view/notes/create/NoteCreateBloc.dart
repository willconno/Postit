
import 'package:flutter/widgets.dart';
import 'package:postit/entity/Note.dart';
import 'package:postit/repo/NoteRepo.dart';

class NoteCreateBloc {

  final _repo = NoteRepo();

  void saveNote(note) {
    _repo.saveNote(note);
  }
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