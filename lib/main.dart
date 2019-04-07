import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'linguist_data.dart';

void main() => runApp(GitHubAPIFlutterApp());

class GitHubAPIFlutterApp extends StatelessWidget {

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code Language and Lines Detector GitHub',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final userController = TextEditingController();
  final repoController = TextEditingController();
  LinguistResults results = new LinguistResults();
  Map resBody, resSize;
  String user, repo;
  bool isAvailable = true;

  Future _getUserAndRepo(String user, String repo) async {
    this.user = user;
    this.repo = repo;

    String url = "https://api.github.com/repos/"+user+"/"+repo;
    var resLang = await http.get(Uri.encodeFull(url));
    var resLangSize = await http.get(Uri.encodeFull(url+"/languages"));
    setState(() {
      resBody = json.decode(resLang.body);
      resSize = json.decode(resLangSize.body);
    });

    if(resBody['message'] !=  "Not Found") {
      isAvailable = true;
      results.resultsLang = resBody['language'];
      results.resultsLangSize = (resSize['Dart']/1000).toStringAsFixed(2);
      results.resultsSize = ((resBody['size']/100) * 40).round();
    }
    else{
      isAvailable = false;
    }
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Code Language and Lines Detector GitHub", style: TextStyle(fontSize: MediaQuery.of(context).size.width/20.6)),
      ),
      body: new SafeArea(
          child: new Form(
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: new Text("Enter your GitHub username and repository name below to find out "
                        "the language and lines of code in your project! \n\n"
                        "Try it out with the following sample details:\n"
                        "Username: snotani \nRepo name: GitHubAPIFlutterApp"),
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      labelText: 'GitHub username',
                    ),
                    controller: userController,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.folder_open),
                      labelText: 'GitHub repository name',
                    ),
                    controller: repoController,
                  ),
                  new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 40.0),
                      child: new RaisedButton(
                        child: const Text('Check my code!'),
                        onPressed: () {_getUserAndRepo(userController.text, repoController.text);},
                      )),
                  Padding(
                    padding: const EdgeInsets.all(60.0),
                    child: new Container(
                      child: Align(
                        child: isAvailable ? results.showResults(context) : results.unableToGetResults(context, this.user, this.repo)
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}