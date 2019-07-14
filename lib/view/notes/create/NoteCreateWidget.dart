import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:postit/entity/Note.dart';
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
  final _titleFieldController = TextEditingController();
  final _bodyFieldController = TextEditingController();

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
        child: Builder(builder: (context) => _scaffold(context)));
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
        SaveButton(onSavePressed: () {
          _saveNote();
          Navigator.of(context).pop();
        }),
        MenuButton()
      ],
    );
  }

  Widget _titleField() {
    return TextField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        controller: _titleFieldController,
        style: TextStyle(
          fontSize: 24,
        ),
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 8),
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
      controller: _bodyFieldController,
      autofocus: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16),
          hintText: 'Type something in here',
          hasFloatingPlaceholder: false,
          border: InputBorder.none),
    );
  }

  Note _builtNote() {
    return Note(
        title: _titleFieldController.text, body: _bodyFieldController.text);
  }

  void _saveNote() {
    _bloc.saveNote(_builtNote());
  }
}

class SaveButton extends StatelessWidget {
  final Function onSavePressed;

  SaveButton({this.onSavePressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: FlatButton(
            onPressed: onSavePressed,
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white, fontSize: 18),
            )));
  }
}

class MenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [_archiveButton, _colourButton],
      onCanceled: (){
        print("cancelled!");
      },
      onSelected: (int item) {
//        print("Hello!");
          if (item == 2 ) {
            _showColourPicker(context);
          }
      },
    );
  }

  final _archiveButton = PopupMenuItem(child: Text("Archive"), value: 1);
  final _colourButton = PopupMenuItem(child: Text("Colour"), value: 2);

  void _showColourPicker(context) {
    print("Hello");
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Rewind and remember'),
            content: MaterialColorPicker(
              allowShades: false,
              onColorChange: (result) {
                //
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Done'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
