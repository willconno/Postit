
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:postit/view/notes/NoteListItemView.dart';

class NoteListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new NoteListState();
  }
}

class NoteListState extends State<NoteListWidget> {
  var _currentIndex = 0;

  PageController _pageController = PageController(initialPage: 0);

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: _currentIndex,
        onTap: onPageChanged,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        fabLocation: BubbleBottomBarFabLocation.end,
        //new
        hasNotch: true,
        //new
        hasInk: true,
        //new, gives a cute ink effect
        inkColor: Colors.black12,
        //optional, uses theme color if not specified
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
      ),
    );
  }

  void onPageChanged(newIndex) {
    setState(() {
      _currentIndex = newIndex;
      _pageController.animateToPage(newIndex, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }
}
