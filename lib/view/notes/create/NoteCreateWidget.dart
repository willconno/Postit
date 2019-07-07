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

  final _bodyFocus = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = NoteCreateBlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(_bodyFocus);
        },
        child: Builder(builder: (context) => _scaffold(context)
        )
        );
  }

  Widget _scaffold(context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: _viewContainer(context),
      ),
    );
  }

  Widget _viewContainer(context) {
    return Column(
      children: <Widget>[_titleField(), _bodyField()],
    );
  }

  Widget _appBar(context) {
    return AppBar(
      title: Text("Create Note"),
      actions: <Widget>[
        SaveButton()
      ],
    );
  }

  Widget _titleField() {
    return TextField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        style: TextStyle(fontSize: 24,),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 8),
            hintText: 'Title',
            hasFloatingPlaceholder: false,
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey)));
  }

  Widget _bodyField() {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      focusNode: _bodyFocus,
      autofocus: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16),
          hintText: 'Type something in here',
          hasFloatingPlaceholder: false,
          border: InputBorder.none),
    );
  }
}

class SaveButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.save_alt), onPressed: () => _onSavePressed(context));;
  }

  void _onSavePressed(context) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("This action isn't supported yet.")));
  }
}