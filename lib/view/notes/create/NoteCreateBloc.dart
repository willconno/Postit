
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:postit/entity/Note.dart';
import 'package:postit/repo/NoteRepo.dart';
import 'package:rxdart/rxdart.dart';

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

class NoteCreateBloc {

  final _repo = NoteRepo();
  Note selectedNote;

  final _colour = BehaviorSubject<int>();
  Function(int) get setColour => _colour.sink.add;
  Observable<int> get colour => _colour.stream;

  final _title = BehaviorSubject<String>();
  Function(String) get setTitle => _title.sink.add;
  Observable<String> get title => _title.stream;

  final _body = BehaviorSubject<String>();
  Function(String) get setBody => _body.sink.add;
  Observable<String> get body => _body.stream;

  void withNote(Note note) {
    selectedNote = note;
    setTitle(note.title);
    setBody(note.body);
    setColour(note.colour);
  }

  Note _buildNote() {
    return Note(id: selectedNote?.id, title: _title.value, body: _body.value, colour: _colour.value, inserted: selectedNote?.inserted);
  }

  void saveNote() {
    _repo.saveNote(_buildNote());
  }

  void dispose() async {
    await _colour.drain();
    _colour.close();
    await _title.drain();
    _title.close();
    await _body.drain();
    _body.close();
  }

}

