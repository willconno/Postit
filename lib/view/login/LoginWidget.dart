import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'LoginBloc.dart';

class LoginWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }


}

class LoginState extends State<LoginWidget> {
  LoginBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = LoginBlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    _bloc.isAuthenticated( (success) {
      if (success) { pushNotes(); }
    });
    return Scaffold(
      body: Padding(padding: EdgeInsets.all(16), child: _center()),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  Widget _center() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _googleButton(),
          ],
        )
      ],
    ));
  }

  Widget _googleButton() {
    return RaisedButton(
      padding: EdgeInsets.only(left: 32, right: 32),
      child: Row(
        children: <Widget>[
          Icon(Icons.person),
          Text(
            "Sign in with Google",
            textAlign: TextAlign.center,
          )
        ],
      ),
      elevation: 3,
      onPressed: () => _onSignInPressed(),
    );
  }

  void _onSignInPressed() {
    _bloc.googleSignIn().then((user) {
      if (user != null) {
        updateUser(user);
      } else {
        showSnackbar("Log in failed. Please try again later.");
      }
    }).catchError((error, stack) {
      print(error);
      showSnackbar(stack);
    });
  }

  void updateUser(FirebaseUser user) {
    _bloc.updateUser(user).then((_) {
      pushNotes();
    }).catchError((error, stack) {
      print(error);
      showSnackbar(stack);
    });
  }

  void pushNotes() {
    Navigator.of(context).pushReplacementNamed("/notes");
  }

  void showSnackbar(String msg) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
