import 'package:flutter/material.dart';
import 'auth.dart';
//import com.facebook.FacebookSdk;
//import com.facebook.appevents.AppEventsLogger;


class FBLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.0)),
      minWidth: 200,
      onPressed: () => authService.googleSignIn(),
      color: Colors.blue,
      textColor: Colors.white,
      child: Text('Sign in with Facebook'),
    );
  }
}