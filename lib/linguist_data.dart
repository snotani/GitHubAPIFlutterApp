import 'package:flutter/material.dart';

class LinguistResults{
  var resultsData;

  Widget showResults() {
    return resultsData != null
        ? Text('$resultsData',
        style: TextStyle(
          fontSize: 34.0,
          height: 1.25,
        ))
        : CircularProgressIndicator();
  }
}