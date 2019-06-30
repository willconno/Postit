import 'package:flutter/material.dart';

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
                        Navigator.of(context).pushReplacementNamed("/notes");
                      },
                    )
                  ],
                )
              ],
            ))));
  }
}
