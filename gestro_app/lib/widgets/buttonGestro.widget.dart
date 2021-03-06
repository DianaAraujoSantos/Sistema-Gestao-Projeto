import 'package:flutter/material.dart';
import 'package:gestro_app/themes/globals.themes.dart';

class ButtonGestro extends StatelessWidget {
  final String text;
  String textKey;

  ButtonGestro({@required this.text, this.textKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(this.textKey),
      width: MediaQuery.of(context).size.width / 1.1,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        color: purpleSecudary,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      margin: EdgeInsets.only(top: 15),
      child: Center(
        child: Container(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
