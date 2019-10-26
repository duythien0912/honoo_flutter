import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honoo/View/HonooView.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:honoo/View/BottomSheet.dart' ;

class NewHonoo extends StatefulWidget {
  @override
  _NewHonooState createState() => _NewHonooState();

  static _NewHonooState of(BuildContext context, {bool nullOk = false}) {
    assert(nullOk != null);
    assert(context != null);
    final _NewHonooState result = context.ancestorStateOfType(const TypeMatcher<_NewHonooState>());
    if(result != null)
      return result;
    throw FlutterError(
        "NewHonoo.of(context) called with a context that does not contain NewHonoo"
    );
  }

}


class _NewHonooState extends State<NewHonoo> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new HonooView();
  }
}




