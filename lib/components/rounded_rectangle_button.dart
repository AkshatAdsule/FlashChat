import 'package:flutter/material.dart';

class RoundedRectangleButton extends StatelessWidget {
  RoundedRectangleButton(
      {@required this.buttonText, this.color, @required this.onPress});
  final String buttonText;
  final Color color;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: color,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        onPressed: onPress,
        minWidth: 200.0,
        height: 42.0,
        child: Text(
          buttonText,
        ),
      ),
    );
  }
}
