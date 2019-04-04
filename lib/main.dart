import 'package:flutter/material.dart';
import 'user_data.dart';
import 'linguist_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  UserData newUser = new UserData();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
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
                  new Text("Enter your GitHub username and repository name below to find out"
                      "the languages used in your project! "
                      "(Try it out with this project -> "
                      "Username: snotani, Repo name: LinguistAPIFLutterApp"),
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
                ],
              ))),
    );
  }

  void _submitForm() {
    String url = 'https://api.github.com/repos/' + newUser.username + '/'
    + newUser.repoName + '/languages';

    Future<Post> getPost() async{
      final response = await http.get('$url/1');
      return postFromJson(response.body);
    }
  }
}
