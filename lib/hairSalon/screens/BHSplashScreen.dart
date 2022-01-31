import 'dart:async';
import 'package:booking/hairSalon/screens/BHWalkThroughScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import'package:booking/hairSalon/screens/BHWalkThroughScreen.dart';

class BHSplashScreen extends StatefulWidget {
  static String tag = '/BHSplashScreen';

  @override
  BHSplashScreenState createState() => BHSplashScreenState();
}

class BHSplashScreenState extends State<BHSplashScreen> {
  @override
  void initState() {
    super.initState();

    addAuthListener();
    init();

    signInTestUser();
  }

  signInTestUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: "test@test.com",
          password: "test12345"
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
  addAuthListener() async {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      if (user == null) {
        print('****User is currently signed out!***');
      } else {
        print('User is signed in! ${user.email}', );
      }
    });
  }
  init() async{
    Timer(Duration(seconds: 2), () {
      finish(context);
      BHWalkThroughScreen().launch(context);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset('images/hairSalon/bh_logo.svg', height: 250, width: 250, color: Colors.red.withOpacity(0.7)),
      ),
    );
  }
}