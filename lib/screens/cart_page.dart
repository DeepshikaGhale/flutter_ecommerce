import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/screens/productpage.dart';
import 'package:ecommerce/services/firebase_services.dart';
import 'package:ecommerce/widgets/customActionBar.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.userRef
                .doc(_firebaseServices.getUserId())
                .collection('CART')
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              //collection data/list to display to user
              if (snapshot.connectionState == ConnectionState.done) {
                //DISPLAY DATA INSIDE LISTVIEW
                return ListView(
                  padding: EdgeInsets.only(top: 100.0, bottom: 12.0),
                  children: snapshot.data!.docs.map((document) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductPage(
                                productId: document.id,
                              ),
                            ));
                      },
                      child: FutureBuilder(
                        future:
                            _firebaseServices.productRef.doc(document.id).get(),
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> ringsnap) {
                          if (ringsnap.hasError) {
                            return Container(
                              child: Center(
                                child: Text("${ringsnap.error}"),
                              ),
                            );
                          }

                          if (ringsnap.connectionState ==
                              ConnectionState.done) {
                            Map _ringMap = ringsnap.data!.data() as Map;

                            return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 24.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 90,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.network("${_ringMap['images'][0]}",
                                        fit: BoxFit.cover,),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: 15.0
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${_ringMap['name']}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500
                                          ),
                                          ),
                                          Padding(padding: const EdgeInsets.symmetric(
                                            vertical: 4.0
                                          ),
                                          child: Text(
                                            "\$${_ringMap['price']}",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.pink[900],
                                              fontWeight: FontWeight.w200
                                            ),
                                          ),
                                          ),
                                          Text(
                                            "Size - ${document['size']}",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w200
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                    );
                          }

                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                );
              }

              //loading state
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
              title: 'My Cart',
              hasbackArrow: true,
              hasTitle: true,
              hasBackground: false)
        ],
      ),
    );
  }
}
