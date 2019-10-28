import'package:honoo/Model/AppState.dart';
import 'dart:io';
import 'package:honoo/Reducers/Actions/UserActions.dart';

Map<String,dynamic> settingsReducer(Map<String,dynamic> settings, action) {

  if (action is ChangeSetting) {
    var newSettings = settings;
    newSettings[action.setting.item1] = action.setting.item2;
    return newSettings;
  } else {
    return settings;
  }
}