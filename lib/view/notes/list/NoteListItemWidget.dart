import 'package:flutter/material.dart';
import 'package:postit/entity/Note.dart';

import 'NoteListBloc.dart';

enum NoteListType { all, archive }

class NotesListWidget extends StatefulWidget {
  final NoteListType pageIndex;

  NotesListWidget(this.pageIndex);

  @override
  NotesListState createState() {
    return new NotesListState(pageIndex);
  }
}

class NotesListState extends State<NotesListWidget> {
  NoteListBloc _bloc;

  final NoteListType pageIndex;

  NotesListState(this.pageIndex);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = NoteListBlocProvider.of(context);
    setItems();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _bloc.getNotes(this.pageIndex == NoteListType.archive),
        builder: (context, AsyncSnapshot<List<Note>> snapshot) {
          return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, i) {
                return _item(context, snapshot.data[i]);
              });
        });
  }

  Widget _item(context, note) {

    return GestureDetector(
      onTapUp: (gesture) {
        Navigator.of(context).pushNamed("/notes/create", arguments: note);
      },
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
        decoration: getDecoration(note),
        child: Column(
          children: _noteBodyView(note, context),
        ),
      ),
    );
  }

  List<Widget> _noteBodyView(Note note, context) {
    var result = <Widget>[];

    if ((note.title?.length ?? 0) > 0) {
      final titleView = Row(
        children: <Widget>[_largeLabel(note.title, note.getTextColour())],
      );

      final pad = Padding(
        padding: EdgeInsets.all(8),
      );

      result.add(titleView);
      result.add(pad);
    }

    if ((note.body?.length ?? 0) > 0) {
      final bodyView = Row(
        children: <Widget>[_label(note.body, note.getTextColour())],
      );

      result.add(bodyView);
    }

    return result;
  }

  Widget _largeLabel(value, colour) {
    return Flexible(
        child: Text(
      value,
      style: TextStyle(fontSize: 22,
          color: colour),
    ));
  }

  Widget _label(value, colour) {
    return Flexible(child: 
    Text(value,
    style: TextStyle(
        color: colour
    ),)
    );
  }

  BoxDecoration getDecoration(Note note) {
    return new BoxDecoration(
        borderRadius: new BorderRadius.circular(20.0),
        shape: BoxShape.rectangle,
        color: note.colour != null ? Color(note.colour) : Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            offset: new Offset(0.0, 16.0),
            blurRadius: 16.0,
          )
        ]);
  }

  void setItems() {
    _bloc.setNotes(pageIndex == NoteListType.archive);
  }
}
