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
  Color _selectedColour;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_bloc == null) {
      _bloc = NoteCreateBlocProvider.of(context);
    }
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final note = ModalRoute.of(context).settings.arguments as Note;

    if (note != null && _bloc.selectedNote == null) {
      _bloc.withNote(note);
      _titleFieldController.text = note.title;
      _bodyFieldController.text = note.body;
    }

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(_bodyFocus);
        },
        child: Builder(builder: (context) => _scaffold(context)));
  }

  Widget _scaffold(context) {
    return StreamBuilder(
      stream: _bloc.colour,
      builder: (context, AsyncSnapshot<int> snapshot) {
        _selectedColour = snapshot.data == null ? null : Color(snapshot.data);
        return Scaffold(
          appBar: _appBar(context),
          backgroundColor: _selectedColour,
          body: SingleChildScrollView(
            child: _viewContainer(context),
          ),
        );
      },
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
//          _bloc.dispose();
          _saveNote();
          Navigator.of(context).pop();
        }),
        MenuButton(
          onMenuOptionSelected: (MenuOption option) {
            if (option == MenuOption.colour) {
              _showColourPicker(context);
            }
          },
        )
      ],
    );
  }

  Widget _titleField() {
    return StreamBuilder(
        stream: _bloc.title,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: _titleFieldController,
              onChanged: _bloc.setTitle,
              style: TextStyle(
                fontSize: 24,
                color: _bloc.selectedNote.getTextColour(c: _selectedColour)
              ),
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 8),
                  hintText: 'Title',
                  hasFloatingPlaceholder: false,
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey)));
        });
  }

  Widget _bodyField() {
    return StreamBuilder(
        stream: _bloc.body,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            focusNode: _bodyFocus,
            controller: _bodyFieldController,
            autofocus: true,
            onChanged: _bloc.setBody,
            style: TextStyle(
              color: _bloc.selectedNote.getTextColour(c: _selectedColour)
            ),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16),
                hintText: 'Type something in here',

                hasFloatingPlaceholder: false,
                border: InputBorder.none),
          );
        });
  }

  void _showColourPicker(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Rewind and remember'),
            content: MaterialColorPicker(
              allowShades: false,
              onMainColorChange: (result) => _bloc.setColour(result.value),
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

  void _saveNote() {
    _bloc.saveNote();
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

enum MenuOption { archive, colour }

class MenuButton extends StatelessWidget {
  final Function(MenuOption) onMenuOptionSelected;

  MenuButton({this.onMenuOptionSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuOption>(
      itemBuilder: (context) => [_archiveButton, _colourButton],
      onSelected: (MenuOption item) {
        onMenuOptionSelected(item);
      },
    );
  }

  final _archiveButton =
      PopupMenuItem(child: Text("Archive"), value: MenuOption.archive);
  final _colourButton =
      PopupMenuItem(child: Text("Colour"), value: MenuOption.colour);
}
