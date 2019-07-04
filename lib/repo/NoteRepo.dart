
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:postit/entity/Note.dart';

class NoteRepo {

  Future<FirebaseUser> _getUser(){
    return FirebaseAuth.instance.currentUser();
  }

  Future<List<Note>> getNotes() async {
    final user = await _getUser();
    final collection = await Firestore.instance.collection("users").document(user.uid).collection("notes").getDocuments();
    return Note.from(collection);
  }

}