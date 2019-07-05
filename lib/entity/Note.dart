
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'Note.g.dart';

@JsonSerializable(includeIfNull: false)
class Note {

  var body;
  var title;

  Note();

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);

  static List<Note> from(QuerySnapshot list) {
    return list.documents.map( (it) => Note.fromJson(it.data)).toList();
  }

  String debugDescription(){
    return this.toJson().toString();
  }
}