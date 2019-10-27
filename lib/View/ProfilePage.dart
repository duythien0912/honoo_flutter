import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:honoo/ViewModel/ProfilePageViewModel.dart';
import 'package:honoo/Model/AppState.dart';
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    child: InkWell(
                      child: model.profilePic == null ? Image.file(model.profilePic) : Image.asset('assets/honooIcon'),
                      onTap: () {
                        //TODO: Choose profile pic
                      },
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Nome",
                      focusColor: Colors.black
                    ),
                    onSubmitted: (text) {
                      //TODO: Set user name
                    },
                    controller: TextEditingController(text: model.name ?? ""),
                    textCapitalization: TextCapitalization.words,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "email",
                      focusColor: Colors.black
                    ),
                    onSubmitted: (text){
                      //TODO: Set email address
                    },
                    controller: TextEditingController(text: model.contacts["email"] ?? ""),
                    textCapitalization: TextCapitalization.none,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "telefono",
                      focusColor: Colors.black,

                    ),
                    onSubmitted: (text) {
                      //TODO: Set telephone number
                    },
                    controller: TextEditingController(text: model.contacts["telefono"] ?? ""),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "telegram",
                      focusColor: Colors.black,
                    ),
                    onSubmitted: (text){
                      //TODO: Set telegram
                    },
                    controller: TextEditingController(text: model.contacts["telegram"] ?? ""),
                    textCapitalization: TextCapitalization.none,
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Includi informazioni negli honoo alla condivisione"),
                      Switch(
                        value: model.settings["includeInfo"],
                        onChanged: (value){
                          //TODO: set value
                        },
                      )
                    ],
                  )

                ],
              )
            );
          }
        );
      }
    );
  }
}




