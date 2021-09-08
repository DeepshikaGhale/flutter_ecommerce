import 'package:ecommerce/screens/registerpage.dart';
import 'package:ecommerce/widgets/customInput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isloading = false;
  bool showLogin = true;

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

  Future<String?> _signintoAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginemail, password: _loginpassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
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
      showLogin = false;
    });
    //if account is created
    String? _signIntoAccountFeedback = await _signintoAccount();

    //if the string is not null
    if (_signIntoAccountFeedback != null) {
      _alertDialogBuilder(_signIntoAccountFeedback);

      //bring back to regular state
      setState(() {
        isloading = false;
        showLogin = true;
      });
    }
  }

  //form input field values
  String _loginemail = "";
  String _loginpassword = "";

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
                "Welcome User, \n Login to you account.",
                textAlign: TextAlign.center,
                style: Constants.boldHeading,
              ),
            ),
            Column(
              children: [
                CustomInput(
                  hintText: 'Email Address',
                  onChanged: (value) {
                    _loginemail = value;
                  },
                  isPassword: false,
                ),
                CustomInput(
                  hintText: 'Password',
                  onChanged: (value) {
                    _loginpassword = value;
                  },
                  isPassword: true,
                ),
                ElevatedButton(
                  child: Container(
                    child: Stack(children: [
                      Center(
                        child: Visibility(
                          visible: showLogin,
                          child: Text('Login',
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
                //     createAccountText: 'Login',
                //     onPressed: () {
                //       print("Click the register Button");
                //     },
                //     outlineBtn: false)
              ],
            ),
            ElevatedButton(
              child: Container(
                child: Text('Create New Account',
                    style: Constants.regularDarkText,
                    textAlign: TextAlign.center),
                height: 25.0,
                width: 260.0,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage()));
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
