import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:tuple/tuple.dart';

class ChangeName {
  String name;
  ChangeName({@required this.name});
}

class ChangeProfilePic {
  File pic;
  ChangeProfilePic({@required this.pic});
}

class ChangeContact {
  Tuple2<String,String> contact;
  ChangeContact({@required this.contact});
}

class ChangeSetting {
  Tuple2<String,dynamic> setting;
  ChangeSetting({@required this.setting});
}