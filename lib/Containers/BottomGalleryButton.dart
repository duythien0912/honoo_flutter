import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:honoo/Model/AppState.dart';
import 'package:honoo/Reducers/Actions/ImageSourceActions.dart';
import 'package:redux/redux.dart';

class BottomGalleryButton extends StatelessWidget {
  BottomGalleryButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, VoidCallback>(
      converter: (Store<AppState> store) {
        return () {
          store.dispatch(new SetGallery());
        };
      },
      builder: (BuildContext context, VoidCallback changeSource) {
        return new MaterialButton(
          onPressed: changeSource,

          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Icon(Icons.photo_library,size: 70),
              Padding(padding: EdgeInsets.only(top:5,bottom: 5)),
              Text("Galleria",style:TextStyle(fontSize: 20, fontWeight: FontWeight.w600))
            ],
          ),
        );
      },
    );
  }
}

