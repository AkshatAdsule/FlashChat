import 'package:flash_chat/components/rounded_rectangle_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../constants.dart';
import 'welcome_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Future<void> _loginError() async {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Login Failed',
                style: TextStyle(color: Colors.black),
              ),
              content: SingleChildScrollView(
                child: Text(
                  'Please check your email and password. If you have not registred please do so.',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Register'),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, RegistrationScreen.id);
                  },
                ),
                FlatButton(
                  child: Text('Try Again'),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, WelcomeScreen.id);
                  },
                ),
              ],
            );
          });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email')),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Hero(
                  tag: 'loginButton',
                  child: RoundedRectangleButton(
                      buttonText: 'Login',
                      onPress: () async {
                        try {
                          setState(() {
                            showSpinner = true;
                          });
                          await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          Navigator.pushNamed(context, ChatScreen.id);

                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          print(e);
                          _loginError();
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
