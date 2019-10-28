import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:honoo/Reducers/Actions/UserActions.dart';
import 'package:redux/redux.dart';
import 'package:honoo/ViewModel/ProfilePageViewModel.dart';
import 'package:honoo/Model/AppState.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuple/tuple.dart';

class ProfilePage extends StatefulWidget {
  _ProfilePageState createState() => _ProfilePageState();
}




class _ProfilePageState extends State<ProfilePage> {
  double height = 600;
  var scrollController = ScrollController();
  var nameFocusNode;
  var mailFocusNode ;
  var phoneFocusNode;
  var telegramFocusNode;

  @override
  void initState() {

    nameFocusNode = FocusNode();
    mailFocusNode = FocusNode();
    phoneFocusNode= FocusNode();
    telegramFocusNode = FocusNode();


    nameFocusNode.addListener(() {
      if(nameFocusNode.hasFocus) {
        setState(() {
          height = 800;
        });
        scrollController.animateTo(60, duration: Duration(milliseconds: 300) , curve: Curves.easeInOut);
      }

    });
    mailFocusNode.addListener(() {
      if(mailFocusNode.hasFocus) {
        setState(() {
          height = 800;
        });
        scrollController.animateTo(80, duration: Duration(milliseconds: 300) , curve: Curves.easeInOut);
      }
    });
    phoneFocusNode.addListener(() {
      if(phoneFocusNode.hasFocus) {
        setState(() {
          height = 800;
        });
        scrollController.animateTo(100, duration: Duration(milliseconds: 300) , curve: Curves.easeInOut);
      }
    });
    telegramFocusNode.addListener(() {
      if(telegramFocusNode.hasFocus){
        setState(() {
          height = 800;
        });
        scrollController.animateTo(120, duration: Duration(milliseconds: 300) , curve: Curves.easeInOut);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,Function>(
      converter: (Store<AppState> store) {
        return (action) {
          store.dispatch(action);
        };
      },

      builder: (BuildContext context, Function callback) {
        return StoreConnector<AppState, ProfilePageViewModel>(
          converter: ProfilePageViewModel.fromStore,
          builder: (BuildContext context, ProfilePageViewModel model) {
            var nameController = TextEditingController(text: model.name ?? "");
            var mailController = TextEditingController(text: model.contacts['email'] ?? "");
            var phoneController =  TextEditingController(text: model.contacts["telephone"] ?? "");
            var telegramController = TextEditingController(text: model.contacts["telegram"] ?? "");


            return Scaffold(
              body: SingleChildScrollView(
                controller: scrollController,
                child: Container(
                  height: height,
                  child: Padding(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 10,bottom: 10)),
                        Container(
                          width: 200,
                          height: 200,
                          child: InkWell(
                            child: model.profilePic != null ? Image.file(model.profilePic,fit: BoxFit.cover) : Image.asset('assets/photo-camera.png',fit: BoxFit.scaleDown,scale: 6),
                            onTap: () async {
                              callback(ChangeProfilePic(pic: await ImagePicker.pickImage(source: ImageSource.gallery)));
                            },
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white,width: 1),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black45,
                                  spreadRadius: 5,
                                  blurRadius: 10
                              )
                            ]
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 10)),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Nome",
                            focusColor: Colors.black
                          ),

                          onSubmitted: (text) {
                            FocusScope.of(context).requestFocus(mailFocusNode);
                            callback(ChangeName(name: text));
                          },
                          controller: nameController,
                          focusNode: nameFocusNode,
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.done,

                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "email",
                            focusColor: Colors.black
                          ),
                          keyboardType: TextInputType.emailAddress,
                          focusNode: mailFocusNode,
                          onSubmitted: (text){
                            FocusScope.of(context).requestFocus(phoneFocusNode);
                            callback(ChangeContact(contact: Tuple2<String,String>('email',text)));
                          },

                          controller: mailController,
                          textCapitalization: TextCapitalization.none,
                          textInputAction: TextInputAction.done,
                        ),

                        TextField(
                          decoration: InputDecoration(
                            labelText: "Telefono",
                            focusColor: Colors.black,

                          ),

                          onSubmitted: (text) {
                            FocusScope.of(context).requestFocus(telegramFocusNode);
                            callback(ChangeContact(contact: Tuple2<String,String>('telephone',text)));
                          },

                          focusNode: phoneFocusNode,
                          controller: phoneController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Telegram",
                            focusColor: Colors.black,
                          ),
                          onSubmitted: (text) {
                            setState(() {
                              height = 600;
                            });
                            callback(ChangeContact(contact: Tuple2<String,String>('telegram',text)));
                          },
                          focusNode: telegramFocusNode,
                          controller: telegramController,
                          textCapitalization: TextCapitalization.none,
                          textInputAction: TextInputAction.done,
                        ),
                        Padding(padding: EdgeInsets.only(top: 10,bottom: 10)),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Includi info nei tuoi honoo",style: TextStyle(fontSize: 14),),
                            Switch(
                              value: model.settings["includeInfo"],
                              activeColor: Colors.red,
                              onChanged: (value){
                                callback(ChangeSetting(setting: Tuple2<String,dynamic>('includeInfo',value)));
                              },
                            )
                          ],
                        )

                      ],
                    ),
                    padding: EdgeInsets.all(20),
                  )
                ),
              ),
              resizeToAvoidBottomPadding: false,
            );
          }
        );
      }
    );
  }
}




