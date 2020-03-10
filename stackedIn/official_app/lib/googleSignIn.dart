import "package:flutter/material.dart";
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleSignApp extends StatefulWidget{
  @override
  _GoogleSignAppState createState() =>_GoogleSignAppState();

}

class _GoogleSignAppState extends State<GoogleSignApp> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _db =  Firestore.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  bool _isLoggedIn=false;

  Future<FirebaseUser> _signIn(BuildContext context) async {


    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser user = (await _firebaseAuth.signInWithCredential(credential)).user;
    DocumentReference ref=_db.collection('uses').document(user.uid);
    _isLoggedIn=true;
    return user;

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(

      child: SizedBox(
        width: 250.0,
        child:_isLoggedIn
            ?Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(_googleSignIn.currentUser.photoUrl),
            Text(_googleSignIn.currentUser.displayName),
            OutlineButton(
              child: Text("continue with google"),
              onPressed:(){},
            ),
            OutlineButton(

                child: Text("log out"),
                onPressed:(){
                  setState(() {
                    _isLoggedIn=false;
                  });
                }
            ),
          ],
        ): RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          color: Color(0xffffffff),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(FontAwesomeIcons.google,color: Color(0xffCE107C),),
              SizedBox(width:10.0),
              Text(
                'Sign in with Google',
                style: TextStyle(color: Colors.black,fontSize: 18.0),
              ),
            ],),
          onPressed:(){
            _signIn(context)
                .then((FirebaseUser user) => print(user))
                .catchError((e) => print(e));
          },
        ),
      ),
    );

  }
}