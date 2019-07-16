import 'package:flutter/widgets.dart';
import 'package:postit/repo/NoteRepo.dart';
import 'package:postit/entity/Note.dart';
import 'package:postit/repo/UserRepo.dart';
import 'package:rxdart/rxdart.dart';

class NoteListBloc {
  final _repo = NoteRepo();
  final _userRepo = UserRepo();

  final notesSubject = BehaviorSubject<List<Note>>();
  final archivedSubject = BehaviorSubject<List<Note>>();

  Observable<List<Note>> getNotes(archived) {
   if (archived){
     return archivedSubject.stream;
   } else {
     return notesSubject.stream;
   }
  }

  void setNotes(archived) {
    _repo.getNotes(archived, (items) {
      if (archived) {

      } else {
        notesSubject.sink.add(items);
      }
    });
  }

  void signOut(){
    _userRepo.signOut();
  }

  void dispose() async {
    await notesSubject.drain();
    notesSubject.close();
    await archivedSubject.drain();
    archivedSubject.close();
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