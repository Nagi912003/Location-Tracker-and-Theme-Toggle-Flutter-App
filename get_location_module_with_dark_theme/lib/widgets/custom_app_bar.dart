import 'package:flutter/material.dart';

Widget customAppBar(BuildContext context, Color textColor) {
  return RichText(
    text: TextSpan(
      children: [
        WidgetSpan(
          child: Container(
            width: 30,
          ),
        ),
        TextSpan(
          text: '  Your ',
          style: TextStyle(
            color: textColor,
            fontSize: 22,
          ),
        ),
        TextSpan(
          text: 'Coordinates',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        WidgetSpan(
          child: Container(
            width: double.infinity,
          ),
        ),
      ],
    ),
  );
}