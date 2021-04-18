import 'package:coursera_clone/Signup/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseUser user;
  String name;
  String email;
  String imageUrl;
  String currentUid;

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoUrl != null);

/*** Info we get from user object */
    name = user.displayName;
    email = user.email;
    imageUrl = user.photoUrl;
    currentUid = user.uid;

    final FirebaseUser currentUser = await _auth.currentUser();

    assert(user.uid == currentUser.uid);

    return user;
  }

  void signOutGoogle(context) async {
    await googleSignIn.signOut().then((value) async {
    });
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => SignUpScreen()));

    print("User Sign Out");
  }

  getCurrenUser() async {
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    return uid;
  }
}
