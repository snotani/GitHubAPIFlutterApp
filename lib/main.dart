import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'user_data.dart';
import 'linguist_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.blueAccent,
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
  UserData newUser = new UserData();
  String _language;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Language Identifier"),
        centerTitle: true,
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
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: new Text("Enter your GitHub username and repository name below to find out "
                          "the languages used in your project! \n\n"
                          "Try it out with this project details below:\n"
                          "Username: snotani \nRepo name: LinguistAPIFlutterApp"),
                    ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your GitHub username',
                      labelText: 'GitHub username',
                    ),
                    validator: (val) => val.isEmpty ? 'GitHub username is required' : null,
                    onSaved: (val) => newUser.username = val,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.folder_open),
                      hintText: 'Enter your GitHub repository name (case sensitive)',
                      labelText: 'GitHub repository name',
                    ),
                    validator: (val) => val.isEmpty ? 'GitHub repo name is required' : null,
                    onSaved: (val) => newUser.repoName = val,
                  ),
                  new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        child: const Text('Check my code!'),
                        onPressed: _submitForm,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: new Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: _language != null
                            ? Text('$_language',
                            style: TextStyle(
                              fontSize: 34.0,
                              height: 1.25,
                            ))
                            : null,
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }

  Future<void> _submitForm() async {
    String url = 'https://api.github.com/repos/snotani/FridgeBuddy';
    try {
      http.Response response = await http.get(url);
      var myQuote = LanguageInfo.fromJson(jsonDecode(response.body));
      setState(() {
        _language = myQuote.language;
      });
    } catch (e) {}
  }
}