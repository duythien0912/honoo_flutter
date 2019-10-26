

import 'package:honoo/Model/Honoo.dart';
import 'Actions/HonooActions.dart';

Honoo honooReducer(Honoo currentHonoo, action) {

  if (action is ChangeImage) {
    return new Honoo(
      text: currentHonoo.text,
      photo: action.image,
      theme: currentHonoo.theme
    );

  } else if (action is ChangeText) {
    return new Honoo(
      text: action.newText,
      photo: currentHonoo.photo,
      theme: currentHonoo.theme
    );

  } else if (action is ChangeTheme) {
    return new Honoo(
      text: currentHonoo.text,
      photo: currentHonoo.photo,
      theme: action.theme
    );
  } else {
    return currentHonoo;
  }
}