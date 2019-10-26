import 'dart:io';

import 'package:honoo/Model/AppState.dart';


class Honoo {
  final String text;
  final File photo;
  final Theme theme;

  Honoo({this.text, this.photo, this.theme});

  @override
  String toString() {
    // TODO: implement toString
    return "Honoo: $text, photo: $photo";
  }

}

enum Theme {
  light,
  dark
}