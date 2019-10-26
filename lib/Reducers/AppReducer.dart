import 'package:honoo/Model/AppState.dart';
import 'package:honoo/Reducers/HonooListReducer.dart';
import 'package:honoo/Reducers/HonooReducer.dart';
import 'package:honoo/Reducers/ImageSourceReducer.dart';
AppState appReducer(AppState state, action)  {
  return new AppState(
    currentHonoo:  honooReducer(state.currentHonoo,action),
    imageSource: imageSourceReducer(state.imageSource, action),
    myHonoos: honooListReducer(state.myHonoos, action)
  );


}

