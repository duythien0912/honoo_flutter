import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'Honoo.dart';

class AppState {

  final Honoo currentHonoo;
  final ImageSource imageSource;
  final List<Honoo> myHonoos;

  AppState({this.currentHonoo,this.imageSource,this.myHonoos});

  AppState copyWith(Honoo currentHonoo, List<Honoo> myHonoos, ImageSource imageSource){
    return new AppState(
      currentHonoo: currentHonoo ?? this.currentHonoo,
      imageSource: imageSource ?? this.imageSource,
      myHonoos: myHonoos ?? this.myHonoos

    );
  }


}




