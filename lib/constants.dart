import 'package:flutter/material.dart';

const huge = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const big = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const regular = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const small = TextStyle(
  fontSize: 20.0,
  fontFamily: 'Spartan MB',
);

const conditionstyle = TextStyle(
  fontSize: 100.0,
);

const textdecor = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);
