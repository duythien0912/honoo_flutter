import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honoo/Containers/BottomCameraButton.dart';
import 'package:honoo/Containers/BottomGalleryButton.dart';
import 'package:image_picker/image_picker.dart';


class CustomBottomSheet extends StatefulWidget {
  _CustomBottomSheetState createState() => _CustomBottomSheetState(source: source);
  ImageSource source;


  static _CustomBottomSheetState of(BuildContext context, {bool nullOk = false}) {
    assert(nullOk != null);
    assert(context != null);
    final _CustomBottomSheetState result = context.ancestorStateOfType(const TypeMatcher<_CustomBottomSheetState>());
    if(result != null)
      return result;
    throw FlutterError(
        "bottomSheet.of(context) called with a context that does not contain NewHonoo"
    );
  }
}


class _CustomBottomSheetState extends State<CustomBottomSheet> {
  BuildContext sourceContext;
  ImageSource source;

  _CustomBottomSheetState({this.source});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15,right: 15,bottom: 45),
      height: 200,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BottomCameraButton(),
          Padding(padding: EdgeInsets.all(30)),
          BottomGalleryButton()
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white70
      ),

    );
  }


}


