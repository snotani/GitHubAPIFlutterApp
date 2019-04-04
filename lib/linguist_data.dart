// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) {
  final jsonData = json.decode(str);
  return Post.fromJson(jsonData);
}

String postToJson(Post data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Post {
  int dart;
  int objectiveC;
  int java;

  Post({
    this.dart,
    this.objectiveC,
    this.java,
  });

  factory Post.fromJson(Map<String, dynamic> json) => new Post(
    dart: json["Dart"],
    objectiveC: json["Objective-C"],
    java: json["Java"],
  );

  Map<String, dynamic> toJson() => {
    "Dart": dart,
    "Objective-C": objectiveC,
    "Java": java,
  };
}
