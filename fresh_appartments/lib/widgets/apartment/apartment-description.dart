import 'package:flutter/material.dart';

class ApartmentDescription extends StatelessWidget {
  final String description;
  final TextStyle style;
  final EdgeInsetsGeometry margin;

  const ApartmentDescription(
      {Key key, this.description, this.style, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[Expanded(child: Text(description, style: style))],
        ));
  }
}
