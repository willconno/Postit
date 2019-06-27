
import 'package:flutter/material.dart';
import 'package:postit/entity/User.dart';

enum NoteListType {
  all, archive
}

class NotesListWidget extends StatefulWidget {

  final NoteListType pageIndex;
  NotesListWidget(this.pageIndex);

  @override
  NotesListState createState() {
    return new NotesListState(pageIndex);
  }
}

class NotesListState extends State<NotesListWidget> {

  final NoteListType pageIndex;

  NotesListState(this.pageIndex);

  @override
  Widget build(BuildContext context, {pageIndex}) {
    return ListView.builder(
        itemBuilder: (context, i) {
          return ListTile(
            contentPadding: EdgeInsets.all(16.0),
            title: getItem(context, i),
          );
        });
  }

  Widget getItem(context, index) {
    return Container(
      height: 200,
//      padding: EdgeInsets.all(16.0),
      decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(20.0),
          shape: BoxShape.rectangle,
          color: getColor(index),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              offset: new Offset(0.0, 16.0),
              blurRadius: 16.0,
            )
          ]),
    );
  }

  Color getColor(int index) {
    if (index.isEven) {
      return Colors.lightBlue;
    } else {
      return Colors.lightGreen;
    }
  }
}
