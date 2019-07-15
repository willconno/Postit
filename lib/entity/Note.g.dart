// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) {
  return Note(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      archived: json['archived'] as bool,
      colour: json['colour'] as int,
      inserted: json['inserted'] as String);
}

Map<String, dynamic> _$NoteToJson(Note instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('body', instance.body);
  writeNotNull('title', instance.title);
  writeNotNull('archived', instance.archived);
  writeNotNull('colour', instance.colour);
  writeNotNull('inserted', instance.inserted);
  return val;
}
