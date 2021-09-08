import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressed;
  BottomTabs({required this.selectedTab, required this.tabPressed});

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  spreadRadius: 1.0,
                  blurRadius: 20.0)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomTabBottom(
              imagePath: "assets/images/home.png",
              selected: _selectedTab == 0 ? true : false,
              onPressed: () {
                widget.tabPressed(0);
              },
            ),
            BottomTabBottom(
              imagePath: "assets/images/search.png",
              selected: _selectedTab == 1 ? true : false,
              onPressed: () {
                widget.tabPressed(1);
              },
            ),
            BottomTabBottom(
              imagePath: "assets/images/save.png",
              selected: _selectedTab == 2 ? true : false,
              onPressed: () {
                widget.tabPressed(2);
              },
            ),
            BottomTabBottom(
              imagePath: "assets/images/logout.png",
              selected: _selectedTab == 3 ? true : false,
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            )
          ],
        ));
  }
}

class BottomTabBottom extends StatelessWidget {
  final String imagePath;
  final bool selected;
  final Function onPressed;

  BottomTabBottom({
    required this.imagePath,
    required this.selected,
    required this.onPressed,
  });
  // required this.selected,
  // required this.onPressed});

  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;

    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: _selected
                        ? Theme.of(context).accentColor
                        : Colors.transparent,
                    width: 2.0))),
        child: Image(
          image: AssetImage(imagePath ?? "assets/images/home.png"),
          width: 30.0,
          height: 30.0,
          color: _selected ? Theme.of(context).accentColor : Colors.black,
        ),
      ),
    );
  }
}
