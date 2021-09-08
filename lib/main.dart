import 'package:ecommerce/screens/landingpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
      textTheme: GoogleFonts.poppinsTextTheme(
      Theme.of(context).textTheme,
      ),
      accentColor: Colors.pink[900],
      ),
      home: LandingPage(),
    );
  }
}

