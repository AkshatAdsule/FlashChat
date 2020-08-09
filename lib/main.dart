import 'package:flutter/material.dart';
import 'screens/chat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

var currentMessages;
void callBackDispatcher() {
  Workmanager.executeTask((taskName, inputData) {
    print("background");
    return Future.value(true);
  });
}

void main() {
  runApp(FlashChat());
//  Workmanager.initialize(callBackDispatcher, isInDebugMode: false);
//  Workmanager.registerPeriodicTask(
//    "check_messages",
//    "simpleTask",
//    frequency: Duration(minutes: 15),
//    constraints: Constraints(
//    networkType: NetworkType.connected,
//    ),
//  );
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
      },
      theme: ThemeData.light().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }
}
