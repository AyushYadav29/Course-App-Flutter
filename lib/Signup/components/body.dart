import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coursera_clone/Signup/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../components/background.dart';
import '../components/or_divider.dart';
import '../components/social_icon.dart';
import 'package:flutter_svg/svg.dart';
import '../../Welcome.dart';
import 'auth.dart';

class Body extends StatelessWidget with ChangeNotifier {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseUser googleUser;
  final usersRef = Firestore.instance.collection('users');
  final mydoc = Firestore.instance.collection('mydoc');
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  getUser(user) {
    return user;
  }

  setFirebaseData(user) async {
    // final id = usersRef.document().documentID;
    usersRef.document(user.uid).setData({
      'id': user.uid,
      'displayName': user.displayName,
      'photoUrl': user.photoUrl,
      'email': user.email,
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final auth = Provider.of<Auth>(context, listen: false);
    final auth = Auth();
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),

            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                hintText: 'Enter your email',
              ),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                hintText: 'Enter your password',
              ),
            ),
            // RoundedPasswordField(
            //   onChanged: (value) {},
            // ),

            RoundedButton(
              text: "SIGNUP",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),

            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {
                    auth.signInWithGoogle().then((FirebaseUser user) {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return Welcome();
                      }));
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  signUpUsingEmail(String email, String password, BuildContext context) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((signedInUser) async {
      setFirebaseData(signedInUser.user);
    });
  }
}
