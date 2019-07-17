
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
  bool archived;

  final colour = BehaviorSubject<int>();
  int get currentColour => colour.value;

  final title = BehaviorSubject<String>();
  String get currentTitle => title.value;

  final body = BehaviorSubject<String>();
  String get currentBody => body.value;

  void withNote(Note note) {
    selectedNote = note;
    archived = note?.archived ?? false;
    title.sink.add(note.title);
    body.sink.add(note.body);
    colour.sink.add(note.colour);
  }

  Note _buildNote() {
    return Note(id: selectedNote?.id, title: currentTitle, body: currentBody, archived: archived ?? false, colour: currentColour, inserted: selectedNote?.inserted);
  }

  void saveNote() {
    _repo.saveNote(_buildNote());
  }

  void archiveNote() {
    archived = !(archived ?? false);

    if (selectedNote != null) {
      _repo.archive(selectedNote, archived);
    }
  }

  void dispose() async {
    await colour.drain();
    colour.close();
    await title.drain();
    title.close();
    await body.drain();
    body.close();
  }

}

