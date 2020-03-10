import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:official_app/image.dart';
import 'auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:official_app/ResturantMap.dart';
import 'wallet_list.dart';
import 'googleSignIn.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Signin APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

      ),
      home: Scaffold(
        appBar: AppBar(title:Text("Stacked In")),
        body:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//            GoogleSignApp(),
            FBLogin(),
          ],
        )
      )

    );
  }
}




class FacebookSignApp extends StatefulWidget{
  @override
  _FacebookSignAppState createState() =>_FacebookSignAppState();

}

class _FacebookSignAppState extends State<FacebookSignApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width:250.0,
      child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Color(0xffffffff),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,

              children: <Widget>[
                Icon(FontAwesomeIcons.facebookF, color: Color(0xff4754de),),
                SizedBox(width: 10.0),
                Text(
                  'Sign in with Facebook',
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                ),
              ],),
//            onPressed: () =>  _loginWithFB(),
    ),
    );
  }
}


class FBLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FBLoginState();
  }
}

class _FBLoginState extends State<FBLogin> {
  bool _isLoggedIn = false;
  Map userProfile;
  final facebookLogin = FacebookLogin();

  _loginWithFB() async{
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          userProfile = profile;
          _isLoggedIn = true;
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new RestaurantMap(),
            ),
          );

        });
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => _isLoggedIn = false );
        break;
      case FacebookLoginStatus.error:
        setState(() => _isLoggedIn = false );
        break;
    }

  }

  _logout(){
    facebookLogin.logOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
            child: _isLoggedIn
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(userProfile["picture"]["data"]["url"], height: 50.0, width: 50.0,),
                Text(userProfile["name"]),
                OutlineButton( child: Text("Logout"), onPressed: (){
                  _logout();
                },)
              ],
            )
                : SizedBox(
              width:250.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                color: Color(0xffffffff),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: <Widget>[
                    Icon(FontAwesomeIcons.facebookF, color: Color(0xff4754de),),
                    SizedBox(width: 10.0),
                    Text(
                      'Sign in with Facebook',
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                  ],),
                onPressed: () =>  _loginWithFB(),
              ),
            ),
    );
  }
}