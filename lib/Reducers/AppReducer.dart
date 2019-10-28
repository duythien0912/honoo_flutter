import 'package:honoo/Model/AppState.dart';
import 'package:honoo/Reducers/HonooListReducer.dart';
import 'package:honoo/Reducers/HonooReducer.dart';
import 'package:honoo/Reducers/ImageSourceReducer.dart';
import 'package:honoo/Reducers/SettingsReducer.dart';
import 'package:honoo/Reducers/UserReducer.dart';

AppState appReducer(AppState state, action)  {

  return new AppState(
    currentHonoo:  honooReducer(state.currentHonoo,action),
    imageSource: imageSourceReducer(state.imageSource, action),
    myHonoos: honooListReducer(state.myHonoos, action),
    userData: userReducer(state.userData, action),
    settings: settingsReducer(state.settings, action),
  );

}

