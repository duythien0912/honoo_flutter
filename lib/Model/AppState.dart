import 'package:image_picker/image_picker.dart';
import 'dart:core';
import 'Honoo.dart';
import 'dart:io';
import 'package:honoo/Helpers.dart';

class AppState {

  Honoo currentHonoo;
  final List<Honoo> myHonoos;
  final Map<String,dynamic> settings;
  User userData;

  AppState({this.currentHonoo,this.myHonoos,this.settings,this.userData});

  AppState copyWith(Honoo currentHonoo, List<Honoo> myHonoos,Map<String,dynamic> settings,User userData){
    return new AppState(
      currentHonoo: currentHonoo ?? this.currentHonoo,
      myHonoos: myHonoos ?? this.myHonoos,
      settings: settings ?? this.settings,
      userData: userData ?? this.userData,
    );
  }

  static final voidState =  AppState(
      currentHonoo: Honoo(theme: Theme.light),
      myHonoos: [],
      userData: User(
        name: "",
        contacts: {'email':'','telegram':'','telephone':''},

      ),
      settings: {"includeInfo": false}
  );

  static AppState fromJson(json) {
    if (json == null) return voidState;
    var state = AppState(
        currentHonoo : Honoo(theme: Theme.light),
        myHonoos : honooListFomJson(json['myHonoos']),
        settings : json['settings'],
        userData : User.fromJson(json['userData'])
    );
    return state;
  }


  Map<String,dynamic> toJson() => {
    'myHonoos': honooListToJson(myHonoos),
    'settings': settings ?? {"":""},
    'userData': userData.toJson(),
  };
}



class User {
  final String name;
  final Map<String,String> contacts;
  final File profilePic;
  String profilePicURL;
  User({this.name,this.contacts,this.profilePic,this.profilePicURL});

  Map<String,dynamic> toJson() => {
    'profilePicURL': profilePicURL,
    'name': name ,
    'contacts':contacts,
  };


  static User fromJson(Map<String,dynamic> json) {
    return User(
        name: json['name'],
        contacts: {'email':json['contacts']['email'], 'telephone':json['contacts']['telephone'], 'telegram':json['contacts']['telegram']},
        profilePicURL: json['profilePicURL']
    );
  }


}



