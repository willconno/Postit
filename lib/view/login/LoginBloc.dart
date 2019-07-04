
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:postit/repo/UserRepo.dart';

class LoginBlocProvider extends InheritedWidget {
  final bloc = LoginBloc();

  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  LoginBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  static LoginBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(
        LoginBlocProvider) as LoginBlocProvider).bloc;
  }
}

class LoginBloc {
  final _repo = UserRepo();

  Future<FirebaseUser> googleSignIn() => _repo.googleSignIn();

  Future<void> updateUser(FirebaseUser user) => _repo.updateUser(user);

  void isAuthenticated(Function callback) {
    _repo.currentUser().then( (user) {
      if (user != null) {
        _repo.updateUser(user);
        callback(true);
      }
    });
  }

  void dispose() async {
    //dispose of streams
  }
}
