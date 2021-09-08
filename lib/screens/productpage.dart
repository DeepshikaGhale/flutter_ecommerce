import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/services/firebase_services.dart';
import 'package:ecommerce/widgets/customActionBar.dart';
import 'package:ecommerce/widgets/image_widget.dart';
import 'package:ecommerce/widgets/ringsize.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final String productId;
  ProductPage({required this.productId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _selectedProductSize = "0";

  Future _addtoCart() {
    return FirebaseServices()
        .userRef
        .doc(_firebaseServices.getUserId())
        .collection("CART")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  Future _addToSave() {
    return FirebaseServices()
        .userRef
        .doc(_firebaseServices.getUserId())
        .collection("SAVED")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  final SnackBar _snackBar =
      SnackBar(content: Text('Product added to the cart.'));

  final SnackBar _savesnackBar =
      SnackBar(content: Text('Product has been saved.'));    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        FutureBuilder<DocumentSnapshot>(
            future: FirebaseServices().productRef.doc(widget.productId).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              // var docData = snapshot.data as DocumentSnapshot;

              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                //firebase document data map, it acts as a datasnapshot
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;

                //list of images
                List imagelist = data['images'];
                List size = data['size'];

                //set an initial size
                _selectedProductSize = size[0];

                return ListView(
                  padding: EdgeInsets.all(0),
                  children: [
                    ImageWidget(imagelist: imagelist),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 24.0, left: 24.0, right: 24.0, bottom: 4.0),
                      child: Text(
                        "${data['name']}",
                        style: Constants.boldHeading,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 24),
                      child: Text("\$${data['price']}",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.pink[900],
                              fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 24),
                      child: Text("${data['description']}",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w200)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 24),
                      child: Text(
                        'Select Size',
                        style: Constants.regularDarkText,
                      ),
                    ),
                    RingSize(
                      size: size,
                      onSelected: (size) {
                        _selectedProductSize = size;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async{
                              await _addToSave();
                                Scaffold.of(context).showSnackBar(_savesnackBar);
                            },
                            child: Container(
                              width: 40,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage(
                                  "assets/images/save.png",
                                ),
                                width: 25.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                await _addtoCart();
                                Scaffold.of(context).showSnackBar(_snackBar);
                              },
                              child: Container(
                                height: 50,
                                margin: EdgeInsets.only(left: 16.0),
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey[700],
                                    borderRadius: BorderRadius.circular(12.0)),
                                alignment: Alignment.center,
                                child: Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              }

              //loading state
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              );
            }),
        CustomActionBar(
          title: 'Product Page',
          hasbackArrow: true,
          hasTitle: false,
          hasBackground: false,
        )
      ],
    ));
  }
}
