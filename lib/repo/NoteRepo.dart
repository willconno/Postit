
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:postit/entity/Note.dart';

class NoteRepo {

  Future<FirebaseUser> _getUser(){
    return FirebaseAuth.instance.currentUser();
  }

  Future<CollectionReference> _getNotes() async {
    final user = await _getUser();
    return Firestore.instance.collection("users").document(user.uid).collection("notes");
  }

  void getNotes(archived, Function(List<Note>) callback) {
    _getNotes().then( (items) {

      items.where('archived', isEqualTo: archived).snapshots().listen((snapshot) {

        callback(Note.from(snapshot));
      });
    });
  }

  void saveNote(Note note) async {
    final notes = await _getNotes();
    print(note.debugDescription());
    notes.add(note.toJson());
  }

}