import 'package:image_picker/image_picker.dart';
import 'dart:core';
import 'Honoo.dart';
import 'dart:io';
class AppState {

  final Honoo currentHonoo;
  final ImageSource imageSource;
  final List<Honoo> myHonoos;
  final Map<String,dynamic> settings;
  final User userData;

  AppState({this.currentHonoo,this.imageSource,this.myHonoos,this.settings,this.userData});

  AppState copyWith(Honoo currentHonoo, List<Honoo> myHonoos, ImageSource imageSource,Map<String,dynamic> settings,User userData){
    return new AppState(
      currentHonoo: currentHonoo ?? this.currentHonoo,
      imageSource: imageSource ?? this.imageSource,
      myHonoos: myHonoos ?? this.myHonoos,
      settings: settings ?? this.settings,
      userData: userData ?? this.userData
    );
  }


}

class User {
  final String name;
  final Map<String,String> contacts;
  final File profilePic;
  User({this.name,this.contacts,this.profilePic});
}

