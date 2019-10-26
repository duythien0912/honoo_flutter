import 'package:honoo/Model/Honoo.dart';
import 'package:flutter/material.dart';
import 'package:honoo/Model/AppState.dart';
import 'package:redux/redux.dart';

class HonooListViewModel {
  List<Honoo> honoos;
  HonooListViewModel({@required this.honoos});

  static HonooListViewModel fromStore(Store <AppState> store) {
    return HonooListViewModel(honoos: store.state.myHonoos);
  }
}