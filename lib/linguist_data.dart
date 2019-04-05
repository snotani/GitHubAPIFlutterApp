import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinguistResults{
  var resultsData;
  var resultsSize;

  Widget showResults(BuildContext context) {
    return resultsData != null
        ? Text("Languages used: \n$resultsData \n\nLines of Code (estimate): $resultsSize",
        style: TextStyle(fontSize: MediaQuery.of(context).size.height/50.0),
        )
        : CircularProgressIndicator();
  }

  Widget unableToGetResults(BuildContext context, String user, String repo){
    return Column(
      children: <Widget>[
        new Text("Ups, looks like you entered the incorrect repo name or "
          "your repo is private. \n\nYou can change your repo to public by clicking on the link below: \n",
            style: TextStyle(fontSize: MediaQuery.of(context).size.height/50.0)),
        new InkWell(
          child: new Text("https://github.com/"+user+"/"+repo+"/settings",
              style: TextStyle(fontSize: MediaQuery.of(context).size.height/50.0,
              color: Colors.blue)),
          onTap: () async {
            if (await canLaunch("https://github.com/"+user+"/"+repo+"/settings")) {
              await launch("https://github.com/"+user+"/"+repo+"/settings");
            }
          },
        ),
      ],
    );
  }
}