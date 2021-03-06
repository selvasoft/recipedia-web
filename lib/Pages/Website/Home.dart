import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recipedia/Providers/ApiService.dart';
import 'package:recipedia/keys.dart' as keys;

class WebHome extends StatefulWidget {
  WebHome({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _WebHomeState createState() => _WebHomeState();
}

class _WebHomeState extends State<WebHome> {
//int _counter = 0;
  ApiProvider test = ApiProvider();

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
    clientId: keys.clientID,
  );

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Floating NavBar Example'),
        centerTitle: true,
      ),
      //If you want to show body behind the navbar, it should be true
      extendBody: true,
      body: Center(
        child: RaisedButton(
          child: Text("index:"),
          onPressed: () {
            // test.createRecipe(null, null);
            //test.rate("5f19b5e7e00f343fcc0a36fd", 1);
            //test.like("5f19b5e7e00f343fcc0a36fd");
            _handleSignIn();
          },
        ),
      ),
    );
  }
}
