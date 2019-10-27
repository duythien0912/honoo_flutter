import 'dart:io';
import 'package:redux/redux.dart';
import 'package:honoo/Model/AppState.dart';

class ProfilePageViewModel {
  final Map<String,dynamic> settings;
  final String name;
  final File profilePic;
  final Map<String,String> contacts;


  ProfilePageViewModel({this.settings,this.name,this.profilePic,this.contacts});

  static ProfilePageViewModel fromStore(Store<AppState> store) {
    return ProfilePageViewModel(
      settings: store.state.settings,
      name: store.state.userData.name,
      profilePic: store.state.userData.profilePic,
      contacts: store.state.userData.contacts
    );
  }
}