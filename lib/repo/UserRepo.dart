import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepo {

  final _firestore = Firestore.instance;

  Future<FirebaseUser> googleSignIn() async {
    final account = await GoogleSignIn().signIn();
    final auth = await account.authentication;
    print(auth);

    var provider = GoogleAuthProvider.getCredential(
        idToken: auth.idToken, accessToken: auth.accessToken);

    final user = await FirebaseAuth.instance.signInWithCredential(provider);

    return user;
  }

  Future<void> updateUser(FirebaseUser user) async {
    final profile = {'email': user.email, 'name': user.displayName};

    return
      await _firestore
          .collection('users')
          .document(user.uid)
          .setData(profile, merge: true);
  }

}
