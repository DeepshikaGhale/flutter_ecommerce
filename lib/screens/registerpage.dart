import 'package:ecommerce/widgets/customInput.dart';
import 'package:ecommerce/widgets/custombutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isloading = false;
  bool showregister = true;

  //dialog to show errors
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Container(
              child: Text(error),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close Dialog.'),
              )
            ],
          );
        });
  }

  //form input field values
  String _registeremail = "";
  String _registerpassword = "";

  Future<String?> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registeremail, password: _registerpassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitform() async {
    //process
    setState(() {
      isloading = true;
      showregister = false;
    });
    //if account is created
    String? _createAccountFeedback = await _createAccount();

    //if the string is not null
    if (_createAccountFeedback != null) {
      _alertDialogBuilder(_createAccountFeedback);

      //bring back to regular state
      setState(() {
        isloading = false;
        showregister = true;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        // width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: Text(
                "Create New Account.",
                textAlign: TextAlign.center,
                style: Constants.boldHeading,
              ),
            ),
            Column(
              children: [
                CustomInput(
                  hintText: 'Email Address',
                  onChanged: (value) {
                    _registeremail = value;
                  },
                  isPassword: false,
                ),
                CustomInput(
                  hintText: 'Password',
                  onChanged: (value) {
                    _registerpassword = value;
                  },
                  isPassword: true,
                ),
                ElevatedButton(
                  child: Container(
                    child: Stack(children: [
                      Center(
                        child: Visibility(
                          visible: showregister,
                          child: Text('Register',
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center),
                        ),
                      ),
                      Center(
                        child: Visibility(
                          visible: isloading,
                          child: SizedBox(
                              height: 30.0,
                              width: 30.0,
                              child: CircularProgressIndicator()),
                        ),
                      )
                    ]),
                    height: 25.0,
                    width: 260.0,
                  ),
                  onPressed: () {
                    // _alertDialogBuilder();
                    _submitform();
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    )),
                  ),
                ),
                // CustomButton(
                //     createAccountText: 'Register',
                //     onPressed: () {
                //       //open the dialog
                //       _alertDialogBuilder();
                //     },
                //     outlineBtn: false)
              ],
            ),
            ElevatedButton(
              child: Container(
                child: Text('Back To Login',
                    style: Constants.regularDarkText,
                    textAlign: TextAlign.center),
                height: 25.0,
                width: 260.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        side: BorderSide(color: Colors.black, width: 2.0))),
              ),
            ),
            SizedBox(
              height: 2.0,
            )
            // CustomButton(
            //     createAccountText: "Create New Account",
            //     onPressed: () {
            //       print('click');
            //     },
            //     outlineBtn: true,
            //   ),
          ],
        ),
      ),
    );
  }
}
