
import 'package:flutter/material.dart';
import 'NoteCreateBloc.dart';

class NoteCreateWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteCreateState();
  }

}


class NoteCreateState extends State<NoteCreateWidget> {
  NoteCreateBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = NoteCreateBlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Note"),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.arrow_back), title: Text("Back")),
        BottomNavigationBarItem(icon: Icon(Icons.block), title: Text("Create Note"))
      ]),
    );
  }
}