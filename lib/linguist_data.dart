import 'package:flutter/material.dart';

class LinguistResults{
  Widget showResults(String text) {
    return (text != null) ? new Text('$text') : new CircularProgressIndicator();
  }
}