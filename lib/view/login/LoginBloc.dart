
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:postit/repo/UserRepo.dart';

class LoginBloc {
  final _repo = UserRepo();

  Future<FirebaseUser> googleSignIn() => _repo.googleSignIn();

  Future<void> updateUser(FirebaseUser user) => _repo.updateUser(user);

  void dispose() async {
    //dispose of streams
  }
}

class LoginBlocProvider extends InheritedWidget {
  final bloc = LoginBloc();

  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  LoginBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  static LoginBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(
        LoginBlocProvider) as LoginBlocProvider).bloc;
  }
}