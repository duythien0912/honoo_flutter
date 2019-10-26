

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:honoo/Model/AppState.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:honoo/Model/Honoo.dart';

class HonooViewModel {
  final File image;
  final String text;
  final Theme theme;

  HonooViewModel({@required this.image, @required this.text,@required this.theme});

  static HonooViewModel fromStore(Store<AppState> store) {
    return new HonooViewModel(image: store.state.currentHonoo.photo, text: store.state.currentHonoo.text ?? "", theme: store.state.currentHonoo.theme);
  }

}