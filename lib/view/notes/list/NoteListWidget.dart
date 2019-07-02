
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:postit/view/notes/list/NoteListItemWidget.dart';

import 'NoteListBloc.dart';

class NoteListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new NoteListState();
  }
}

class NoteListState extends State<NoteListWidget> {
  NoteListBloc _bloc;
  var _currentIndex = 0;

  PageController _pageController = PageController(initialPage: 0);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = NoteListBlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          NotesListWidget(NoteListType.all),
          NotesListWidget(NoteListType.archive)
        ],
        onPageChanged: (toIndex) {
          setState(() {
            _currentIndex = toIndex;
          });
        },
      ),
      floatingActionButton: _fab(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: _bottomNav()
    );
  }

  void onPageChanged(newIndex) {
    setState(() {
      _currentIndex = newIndex;
      _pageController.animateToPage(newIndex, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  Widget _fab(context) {
    return FloatingActionButton(
      onPressed: () => pushNoteCreate(context),
      child: Icon(Icons.add),
    );
  }

  void pushNoteCreate(context) {
    Navigator.of(context).pushNamed("/notes/create");
  }

  Widget _bottomNav(){
    return BubbleBottomBar(
      opacity: .2,
      currentIndex: _currentIndex,
      onTap: onPageChanged,
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      elevation: 8,
      fabLocation: BubbleBottomBarFabLocation.end,
      hasNotch: true,
      hasInk: true,
      inkColor: Colors.black12,
      items: <BubbleBottomBarItem>[
        BubbleBottomBarItem(
            backgroundColor: Colors.red,
            icon: Icon(
              Icons.dashboard,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.dashboard,
              color: Colors.red,
            ),
            title: Text("Notes")),
        BubbleBottomBarItem(
            backgroundColor: Colors.deepPurple,
            icon: Icon(
              Icons.access_time,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.access_time,
              color: Colors.deepPurple,
            ),
            title: Text("Archive")),
      ],
    );
  }
}
