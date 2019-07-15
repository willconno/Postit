import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'Note.g.dart';

@JsonSerializable(includeIfNull: false)
class Note {
  String id;
  String body;
  String title;
  bool archived;
  int colour;
  String inserted;

  Note(
      {this.id,
      this.title,
      this.body,
      this.archived = false,
      this.colour,
      this.inserted}) {
    if (this.inserted == null) {
      inserted = DateTime.now().toUtc().toIso8601String();
    }
  }

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);

  static List<Note> from(QuerySnapshot list) {
    return list.documents.map((it) {
      final result = Note.fromJson(it.data);
      result.id = it.documentID;
      return result;
    }).toList();
  }

  String debugDescription() {
    return this.toJson().toString();
  }

  Color getColour() {
    if (this.colour == null) {
      return null;
    } else {
      return Color(this.colour);
    }
  }

  /// Source:
  /// https://stackoverflow.com/questions/54438359/how-to-change-text-color-based-on-background-image-flutter
  Color getTextColour({Color c}) {
    final colour = c ?? getColour();
    if (colour == null) {
      return Colors.black;
    }
    int d = 0;

// Counting the perceptive luminance - human eye favors green color...
    double luminance =
        (0.299 * colour.red + 0.587 * colour.green + 0.114 * colour.blue) / 255;

    if (luminance > 0.65)
      d = 0; // bright colors - black font
    else
      d = 255; // dark colors - white font

    return Color.fromARGB(colour.alpha, d, d, d);
  }
}
