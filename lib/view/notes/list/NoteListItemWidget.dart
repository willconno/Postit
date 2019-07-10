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

  var items = List<Note>();

  NotesListState(this.pageIndex);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = NoteListBlocProvider.of(context);
    setItems();
  }

  @override
  Widget build(BuildContext context, {pageIndex}) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, i) {
          return _item(context, i);
        });
  }

  Widget _item(context, index) {
    final note = items[index];

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: getDecoration(index),
      child: Column(
        children: _noteBodyView(note, context),
      ),
    );
  }

  List<Widget> _noteBodyView(Note note, context) {
    var result = <Widget>[];

    if (note.title.length > 0) {
      final titleView = Row(
        children: <Widget>[_largeLabel(note.title)],
      );

      final pad = Padding(
        padding: EdgeInsets.all(8),
      );

      result.add(titleView);
      result.add(pad);
    }

    if (note.body.length > 0) {
      final bodyView = Row(
        children: <Widget>[_label(note.body)],
      );

      result.add(bodyView);
    }

    return result;
  }

  Widget _largeLabel(value) {
    return Flexible(
        child: Text(
          value,
          style: TextStyle(fontSize: 22),
        )
    );
  }

  Widget _label(value) {
    return Flexible(child: Text(value));
  }

  BoxDecoration getDecoration(index) {
    return new BoxDecoration(
        borderRadius: new BorderRadius.circular(20.0),
        shape: BoxShape.rectangle,
        color: getColor(index),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            offset: new Offset(0.0, 16.0),
            blurRadius: 16.0,
          )
        ]);
  }

  Color getColor(int index) {
    if (index.isEven) {
      return Colors.lightBlue;
    } else {
      return Colors.lightGreen;
    }
  }

  void setItems() {
    _bloc.getNotes().then((result) {
      this.items = result;
      setState(() {});
    }).catchError((error) {
      print(error);
    });
  }
}
