import 'package:coursera_clone/Signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coursera',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      // home: SignUpScreen(),
    );
  }
}
