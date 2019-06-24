// Flutter code sample for material.AppBar.actions.1

// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Notes';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomeState();
  }
}

/// This is the stateless widget that the main application instantiates.
class HomeState extends State<HomeWidget> {
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

//  Widget getChild(WidgetatIndex) {
//    return new NotesListWidget();
//  }
}

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
    // TODO: implement build
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
