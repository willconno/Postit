import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
                        _signIn().then((user) {

                          print(user);

                          _updateUser(user).then( (_) {

                            Navigator.of(context).pushReplacementNamed(
                                "/notes");

                          }).catchError( (e) => print(e));
                        }).catchError((e) => print(e));
                      },
                    )
                  ],
                )
              ],
            ))));
  }

  Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount account = await GoogleSignIn().signIn();
    GoogleSignInAuthentication auth = await account.authentication;
    print(auth);

    var provider = GoogleAuthProvider.getCredential(
        idToken: auth.idToken, accessToken: auth.accessToken);

    FirebaseUser user = await FirebaseAuth.instance.signInWithCredential(provider);


    return user;
  }

  Future<void> _updateUser(FirebaseUser user) async {
    var profile = Map<String, dynamic>();

    profile["email"] = user.email;
    profile["name"] = user.displayName;

    return await Firestore.instance.collection('users').document(user.uid)
        .setData(profile, merge: true);
  }
}
