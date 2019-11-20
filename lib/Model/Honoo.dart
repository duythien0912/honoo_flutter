import 'dart:io';
import 'package:honoo/Helpers.dart';
import 'package:json_annotation/json_annotation.dart';


class Honoo {
  final String text;
  final File photo;
  final Theme theme;
  String info;
  String photoURL;

  Honoo({this.text, this.photo, this.theme,this.info,this.photoURL});

  @override
  String toString() {
    return "Honoo: $text, photo: $photo";
  }

  static Honoo fromJson(Map<String,dynamic> json) {
    return Honoo(
        text: json['text'],
        theme: json['theme'] == 0 ? Theme.light : Theme.dark,
        info: json['info'],
        photoURL: json['photoURL'],
    );
  }



  Map<String,dynamic> toJson() => {
    'text': text ?? "",
    'photoURL': photoURL,
    'theme': theme == Theme.light? 0:1,
    'info': info ?? ""
  };
}

enum Theme {
  light,
  dark
}