import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/cart_page.dart';
import 'package:ecommerce/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasbackArrow;
  final bool hasTitle;
  final bool hasBackground;

  CustomActionBar(
      {required this.title,
      required this.hasbackArrow,
      required this.hasTitle,
      required this.hasBackground});

  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    bool _hasbackArrow = hasbackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasbackground = hasBackground ?? true;

    return Container(
      decoration: BoxDecoration(
        gradient: _hasbackground
            ? LinearGradient(colors: [
                Colors.white,
                Colors.white.withOpacity(0),
              ], begin: Alignment(0, 0), end: Alignment(0, 1))
            : null,
      ),
      padding:
          EdgeInsets.only(top: 50.0, left: 24.0, right: 24.0, bottom: 40.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        if (_hasbackArrow)
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  color: Colors.blueGrey[700],
                  borderRadius: BorderRadius.circular(8.0)),
              alignment: Alignment.center,
              child: Image(
                  image: AssetImage('assets/images/backarrow.png'),
                  height: 16,
                  width: 16),
            ),
          ),
        if (_hasTitle)
          Text(
            title ?? 'Action Bar',
            style: Constants.boldHeading,
          ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CartPage()));
          },
          child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  color: Colors.blueGrey[700],
                  borderRadius: BorderRadius.circular(8.0)),
              alignment: Alignment.center,
              child: StreamBuilder(
                stream: FirebaseServices()
                    .userRef
                    .doc(_firebaseServices.getUserId())
                    .collection("CART")
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  int _totalItems = 0;

                  if (streamSnapshot.connectionState ==
                      ConnectionState.active) {
                    List _documents = streamSnapshot.data!.docs;
                    _totalItems = _documents.length;
                  }

                  return Text(
                    "${_totalItems ?? '0'}",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  );
                },
              )),
        )
      ]),
    );
  }
}
