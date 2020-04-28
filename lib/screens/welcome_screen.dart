import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:flash_chat/components/rounded_rectangle_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation logoAnimation;
  Animation backgroundAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(milliseconds: 1250),
      vsync: this,
    );

    logoAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    );

    backgroundAnimation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.forward();
    controller.addListener(() {
      setState(() {});
      //print(logoAnimation.value);
      //print(backgroundAnimation.value);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundAnimation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: logoAnimation.value * 75,
                  ),
                ),
                Text(
                  'Flash Chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Hero(
                tag: 'loginButton',
                child: RoundedRectangleButton(
                  buttonText: 'Log in',
                  color: Colors.lightBlueAccent,
                  onPress: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Hero(
                  tag: 'registerButton',
                  child: RoundedRectangleButton(
                      buttonText: 'Register',
                      color: Colors.blueAccent,
                      onPress: () {
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      })),
            ),
          ],
        ),
      ),
    );
  }
}
