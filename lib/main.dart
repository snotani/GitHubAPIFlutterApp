import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'linguist_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Detector GitHub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.teal[700],
        accentColor: Colors.tealAccent,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final userController = TextEditingController();
  final repoController = TextEditingController();
  LinguistResults results = new LinguistResults();
  var resBody;
  String user;
  String repo;
  bool isAvailable = true;

  Future _getUserAndRepo(String user, String repo) async {
    this.user = user;
    this.repo = repo;

    String url = "https://api.github.com/repos/"+user+"/"+repo+"/languages";
    var res = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    setState(() {
      resBody = json.decode(res.body);
    });

    if(resBody['message'] !=  "Not Found") {
      isAvailable = true;
      results.resultsData = resBody;
    }
    else{
      isAvailable = false;
    }
    //userController.clear();
    //repoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Language Detector GitHub"),
        centerTitle: true,
        //leading: new Image.asset('assets/logo.png'),
      ),
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: _formKey,
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: new Text("Enter your GitHub username and repository name below to find out "
                        "the languages used in your project! \n\n"
                        "Try it out with the details of this project below:\n"
                        "Username: snotani \nRepo name: LinguistAPIFlutterApp"),
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your GitHub username',
                      labelText: 'GitHub username',
                    ),
                    controller: userController,
                    validator: (val) => val.isEmpty ? 'GitHub username is required' : null,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.folder_open),
                      hintText: 'Enter your GitHub repository name',
                      labelText: 'GitHub repository name',
                    ),
                    controller: repoController,
                    validator: (val) => val.isEmpty ? 'GitHub repo name is required' : null,
                  ),
                  new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 40.0),
                      child: new RaisedButton(
                        child: const Text('Check my code!'),
                        onPressed: () {
                          _getUserAndRepo(userController.text, repoController.text);
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.all(80.0),
                    child: new Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: isAvailable ? results.showResults() : results.unableToGetResults(context, this.user, this.repo)
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}