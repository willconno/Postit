import 'package:flutter/widgets.dart';
import 'package:postit/repo/NoteRepo.dart';
import 'package:postit/entity/Note.dart';
import 'package:postit/repo/UserRepo.dart';
import 'package:rxdart/rxdart.dart';

class NoteListBloc {
  final _repo = NoteRepo();
  final _userRepo = UserRepo();

  final _notes = BehaviorSubject<List<Note>>();
  final _archived = BehaviorSubject<List<Note>>();

  Observable<List<Note>> getNotes(archived) {
   if (archived){
     return _archived.stream;
   } else {
     return _notes.stream;
   }
  }

  void setNotes(archived) {
    _repo.getNotes(archived, (items) {
      if (archived) {

      } else {
        _notes.sink.add(items);
      }
    });
  }

  void signOut(){
    _userRepo.signOut();
  }

  void dispose() async {
    await _notes.drain();
    _notes.close();
    await _archived.drain();
    _archived.close();
  }
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