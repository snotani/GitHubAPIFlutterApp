import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinguistResults{
  var resultsLangSize;
  var resultsLang;
  var resultsSize;

  Widget showResults(BuildContext context) {
    return SafeArea(
      child: resultsLang != null
          ? Text("Language used: $resultsLang ($resultsLangSize kB) \n\nLines of Code (estimate): $resultsSize")
          : CircularProgressIndicator(),
    );
  }

  Widget unableToGetResults(BuildContext context, String user, String repo){
    return SafeArea(
      child: Column(
        children: <Widget>[
          new Text("Ups, looks like you entered the incorrect credentials or "
            "your repo is private. Please check your username and repo name again."
              "\n\nIf your repo is private, you can change it to public by clicking on the link below:\n"),
          new InkWell(
            child: new Text("https://github.com/"+user+"/"+repo+"/settings",
                style: TextStyle(color: Colors.blue)),
            onTap: () async {
                await launch("https://github.com/"+user+"/"+repo+"/settings");
            },
          ),
        ],
      ),
    );
  }
}