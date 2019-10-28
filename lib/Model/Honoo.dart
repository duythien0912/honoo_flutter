import 'dart:io';

import 'package:honoo/Model/AppState.dart';


class Honoo {
  final String text;
  final File photo;
  final Theme theme;
  String info;

  Honoo({this.text, this.photo, this.theme,this.info});

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