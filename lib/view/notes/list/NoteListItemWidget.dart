
import 'package:flutter/material.dart';
import 'package:postit/entity/Note.dart';

import 'NoteListBloc.dart';

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

  Widget _item(context, index){
    final note = items[index];

    return Container(
      height: 200,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: getDecoration(index),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(note.title,
              style: TextStyle(
                fontSize: 22
              ),)
            ],
          ),
          Row(
            children: <Widget>[
              Text(note.body)
            ],
          )
        ],
      ),
    );
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
        ]
    );
  }

  Color getColor(int index) {
    if (index.isEven) {
      return Colors.lightBlue;
    } else {
      return Colors.lightGreen;
    }
  }

  void setItems(){
    _bloc.getNotes().then( (result) {
      this.items = result;
      setState(() {});

    }).catchError( (error) {
      print(error);
    });
  }
}
