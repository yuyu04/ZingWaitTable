import 'dart:convert';

class Waiting {
  int number;
  String title;

  Waiting(Map jsonObj, int number) {
    this.number = number;
    this.title = jsonObj["title"] == null ? "" : jsonObj["title"];
  }
}