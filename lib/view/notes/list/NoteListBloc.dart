import 'package:flutter/widgets.dart';
import 'package:postit/repo/NoteRepo.dart';
import 'package:postit/entity/Note.dart';
import 'package:postit/repo/UserRepo.dart';

class NoteListBloc {
  final _repo = NoteRepo();
  final _userRepo = UserRepo();

  void getNotes(archived, Function(List<Note>) callback) {
    return _repo.getNotes(archived, callback);
  }

  void signOut(){
    _userRepo.signOut();
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