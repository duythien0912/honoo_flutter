
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:honoo/Model/Honoo.dart';

class ChangeImage{
  File image;
  ChangeImage({@required this.image});
}
class ChangeText{
  String newText;
  ChangeText({@required this.newText});
}
class ChangeTheme {
  Theme theme;
  ChangeTheme({@required this.theme});
}
