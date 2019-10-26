import 'package:flutter/rendering.dart';
import 'package:honoo/Reducers/Actions/ImageSourceActions.dart';
import 'package:image_picker/image_picker.dart';

ImageSource imageSourceReducer(ImageSource currentSource, action) {
  if (action is SetCamera) {
    currentSource = ImageSource.camera;
    return currentSource;
  } else if (action is SetGallery) {
    currentSource = ImageSource.gallery;
    return currentSource;
  } else {
    return currentSource;
  }
}
