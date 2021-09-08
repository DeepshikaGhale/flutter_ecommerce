import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/productpage.dart';
import 'package:ecommerce/services/firebase_services.dart';
import 'package:ecommerce/widgets/customActionBar.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: FirebaseServices().productRef.get(),
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
                            )
                            );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0)),
                        height: 250.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 12.0),
                        child: Stack(children: [
                          Container(
                            height: 250.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.network(
                                "${document['images'][0]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    document['name'] ?? 'Product Name',
                                    style: Constants.regularHeading,
                                  ),
                                  Text(
                                    "\$${document['price']}" ?? 'Price',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.pink[900],
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ]),
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
          CustomActionBar(title: 'Home', hasbackArrow: false, hasTitle: true, hasBackground: true,),
        ],
      ),
    );
  }
}
