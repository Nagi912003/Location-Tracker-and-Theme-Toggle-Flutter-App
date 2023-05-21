import 'package:flutter/material.dart';

import '../providers/my_colors_provider.dart';

Widget viewCoordinates(double latitude, double longitude, Color myCardColor, Color myGrey, Color myText) {
  return SizedBox(
    width: 300,
    height: 500,
    child: Card(
      color: myCardColor,
      child: Center(
        child: RichText(
          text: TextSpan(
            text: 'Latitude: ',
            style: TextStyle(
              color: myGrey,
              fontSize: 20,
            ),
            children: <TextSpan>[
              TextSpan(
                text: latitude.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: myText,
                  fontSize: 20,
                ),
              ),
              TextSpan(
                text: '\nLongitude: ',
                style: TextStyle(
                  color: myGrey,
                  fontSize: 20,
                ),
              ),
              TextSpan(
                text: longitude.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: myText,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}