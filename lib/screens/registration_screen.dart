import 'package:flash_chat/components/rounded_rectangle_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String password;
  String passwordConfirm;
  bool showSpinner = false;

  final _auth = FirebaseAuth.instance;

  Future<void> _registrationError() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Registration Failed!',
              style: TextStyle(color: Colors.black),
            ),
            content: SingleChildScrollView(
              child: Text(
                'Please give a valid email and make sure your password has more than 6 digits and that you entered the password correctly. Also make sure you have not already made an account.',
                style: TextStyle(color: Colors.black),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Login'),
                onPressed: () {
                  Navigator.popAndPushNamed(context, LoginScreen.id);
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

  @override
  Widget build(BuildContext context) {
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
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
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
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  passwordConfirm = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Confirm Password',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Hero(
                  tag: 'registerButton',
                  child: RoundedRectangleButton(
                    buttonText: 'Register',
                    onPress: () async {
                      if (password == passwordConfirm) {
                        //print(email);
                        //print(password);
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                          Navigator.pushNamed(context, ChatScreen.id);
                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          print('Flutter error dialog $e');
                          _registrationError();
                        }
                      } else {
                        _registrationError();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
