import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  final Color color;
  final double thickness;

  const OrDivider({Key key, this.color, this.thickness}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            color: color ?? Colors.black,
            height: thickness ?? 3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "OR",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: color ?? Colors.black,
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: color ?? Colors.black,
            height: thickness ?? 3,
          ),
        ),
      ],
    );
  }
}
