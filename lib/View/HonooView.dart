

import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:honoo/Model/AppState.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:honoo/Reducers/Actions/HonooActions.dart';
import 'package:honoo/my_flutter_app_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';
import 'BottomSheet.dart';
import 'package:honoo/View/BottomSheet.dart' ;
import 'package:honoo/ViewModel/HonooViewModel.dart';
import 'package:honoo/Model/Honoo.dart' as Honoo;



class HonooView extends StatelessWidget {

  CustomBottomSheet bottomSheet = CustomBottomSheet();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build


        return StoreConnector<AppState, HonooViewModel>(
          converter: HonooViewModel.fromStore,
          builder: (BuildContext context, HonooViewModel model){
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                    flex: 2,
                    child: TextContainerWidget()
                ),

                Expanded(
                    flex: 3,
                    child: HonooImage(),
                ),

              ],
            );
          },
        );
      }
}




class TextContainerWidget extends StatefulWidget {
  _TextContainerWidgetState createState () => _TextContainerWidgetState();
}

class _TextContainerWidgetState extends State<TextContainerWidget> {
  FocusNode _focusNode;
  TextEditingController controller;
  Honoo.Theme theme = Honoo.Theme.light;
  int charCount = 0;

  void countChars (text) {
    setState(() {
      charCount = text.length;
    });
  }

  void changeTheme() {
    setState(() {
      theme == Honoo.Theme.light ? theme = Honoo.Theme.dark : theme = Honoo.Theme.light;
    });
  }


  var editing = false;

  @override
  void initState() {

    _focusNode = FocusNode();
    controller = TextEditingController();

    _focusNode.addListener( () {
      if (_focusNode.hasFocus) {
        setState(() {
          editing = true;
        });
      } else if(!_focusNode.hasFocus && charCount == 0) {
        setState(() {
          editing = false;
        });
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StoreConnector<AppState, Function>(
        converter: (Store <AppState> store) {
          return (text) {
            store.dispatch(ChangeText(newText:text));
          };
        },
      builder: (BuildContext context, Function callback){
          return StoreConnector<AppState,HonooViewModel>(
            converter: HonooViewModel.fromStore,
            builder: (BuildContext context, HonooViewModel model){
              if (model.text != "" && model.text != null && !editing) {
                controller.text = model.text;
                charCount = controller.text.length;
              }
              return Container(
                child: Stack(
                  children: [
                    Center(
                      child:TextField(
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          hintText: editing ? "" : "Scrivi qui il tuo messaggio",
                          hintMaxLines: 1,
                          hintStyle:  TextStyle(fontSize: 16,color: model.theme == Honoo.Theme.light ? Colors.black54 : Colors.white54),
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 45),
                          border: InputBorder.none,
                          counterText: "",
                        ),

                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: model.theme == Honoo.Theme.light ? Colors.black : Colors.white) ,
                        maxLines: 6,
                        maxLength: 144,
                        scrollPadding: EdgeInsets.zero,
                        controller: controller,
                        onChanged: countChars,
                        onSubmitted: callback,
                        cursorWidth: 1.4,
                        textInputAction: TextInputAction.done,
                        scrollPhysics: NeverScrollableScrollPhysics(),
                        textCapitalization: TextCapitalization.sentences,
                      ),

                    ),
                    Positioned(
                      child: ChangeThemeButton(theme: model.theme,action: changeTheme),
                      bottom: 5,
                      left: 5,
                    ),
                    Positioned(
                      child: CounterWidget(count: charCount),
                      bottom: 5,
                      right: 5,
                    )
                  ],
                ),
                color: model.theme == Honoo.Theme.dark ? Colors.black : Colors.white,
              );

            },
          );
      }

    );
  }
}


class CounterWidget extends StatelessWidget {
  int count;
  
  CounterWidget({@required this.count});
  @override
  Widget build(BuildContext context) {
    int left = 144-count;
    return StoreConnector<AppState,HonooViewModel>(
      converter: HonooViewModel.fromStore,
      builder: (BuildContext context, HonooViewModel model){
        return Container(
          width: 37,
          height: 37,
          child: Center(
            child: Text("$left", style: TextStyle(fontSize: 15, color: count > 134 ? Colors.red : model.theme == Honoo.Theme.light ? Colors.white : Colors.black)),
          ),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: model.theme == Honoo.Theme.light? Colors.black : Colors.white
          ),
        ) ;
      },
    );
  }
}


class ChangeThemeButton extends StatelessWidget {
  Honoo.Theme theme;
  Function action;
  ChangeThemeButton({@required this.theme, @required this.action});
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Function> (
      converter: (Store<AppState> store) {
        return (theme) {

          store.dispatch(ChangeTheme(theme: theme));
        };
      },
      builder: (BuildContext context, Function callback) {
        return StoreConnector<AppState,HonooViewModel>(
          converter: HonooViewModel.fromStore,
          builder: (BuildContext context, HonooViewModel model){
            return GestureDetector(
              child: Container(
                width: 37,
                height: 37,
                child: Center(
                  child: Text("ab", style: TextStyle(fontSize: 15, color: model.theme == Honoo.Theme.light ? Colors.white : Colors.black)),
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: model.theme == Honoo.Theme.light? Colors.black : Colors.white
                ),
              ),
              onTap: () {
                model.theme == Honoo.Theme.dark ?  callback(Honoo.Theme.light) : callback(Honoo.Theme.dark);
              },
            );
          },
        );
      },
    );
  }
}

class HonooImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreConnector<AppState, HonooViewModel>(
      converter: HonooViewModel.fromStore,
      builder: (BuildContext context, HonooViewModel model) {
        return  Container(
          child: GestureDetector(
            child: model.image == null ?  UploadButton() :ImageButton(image: model.image),
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },

          ),
          color: Colors.black,

        );
      }
    );
  }
}


class UploadButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VoidCallback>(
        converter: (Store<AppState> store) {
          return () async {
            store.dispatch(ChangeImage(image: await ImagePicker.pickImage(
                source: ImageSource.gallery)));
          };
        },

        builder: (BuildContext context, VoidCallback callback) {
          return Padding(

            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    child:Image.asset("assets/uploadIcon.png"),
                    onTap: callback
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text("Carica qui la tua foto", style: TextStyle(
                      fontSize: 16,
                      color: Colors.white))
                ],
              ),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.rectangle
              ),

            ),

            padding: EdgeInsets.only(
                top: 120, right: 100, left: 100, bottom: 10),
          );
        }
    );
  }
}


class ImageButton extends StatelessWidget {
  File image;
  ImageButton({this.image});

  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState,VoidCallback>(
      converter: (Store <AppState> store) {
        return () async {
         store.dispatch(ChangeImage(image: await ImagePicker.pickImage(source: ImageSource.gallery)));
        };
      },

      builder: (BuildContext context, VoidCallback callback) {
        return GestureDetector(
          child: Image.file(image,fit: BoxFit.fill,),
          onTap: callback,
        );
      }
    );
  }
}



