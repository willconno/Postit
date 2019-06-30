import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
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
                      onPressed: () {
                        if (_signIn() != null) {
                          Navigator.of(context).pushReplacementNamed("/notes");
                        }
                      },
                    )
                  ],
                )
              ],
            ))));
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleAuth = GoogleSignIn();

  Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount account = await _googleAuth.signIn();
    GoogleSignInAuthentication auth = await account.authentication;
    print(auth);

    var provider = GoogleAuthProvider.getCredential(idToken: auth.idToken, accessToken: auth.accessToken);

    FirebaseUser user = await _firebaseAuth.signInWithCredential(provider);
    print(user);
    return user;
  }
}
