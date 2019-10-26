import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:honoo/Model/AppState.dart';
import 'package:honoo/Model/Honoo.dart' as prefix0;
import 'package:honoo/View/NewHonoo.dart';
import 'package:honoo/View/MyHonoo.dart';
import 'package:honoo/my_flutter_app_icons.dart';
import 'package:redux/redux.dart';                              // new
import 'package:flutter_redux/flutter_redux.dart';
import 'Reducers/AppReducer.dart';
import 'Model/Honoo.dart';
import 'ViewModel/HonooViewModel.dart';
import 'package:honoo/Reducers/Actions/HonooListActions.dart';
import 'dart:math';
import 'View/ProfilePage.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  Store store;

  @override
  Widget build(BuildContext context) {


    store = new Store<AppState> (
        appReducer,
        initialState: AppState(
            currentHonoo: Honoo(theme: prefix0.Theme.light),
            myHonoos: []),
        middleware: []
    );

    return StoreProvider<AppState> (

       store: store,

       child: new MaterialApp(
        title: 'honoo',
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          primarySwatch: Colors.blue,
          canvasColor: Colors.transparent,
          fontFamily: 'Arvo',
        ),
        home: HomePage(),
      ),
    );
  }
}



class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {

  var pages = [
    MyHonoo(),
    NewHonoo(),
    ProfilePage()
  ];

  var selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      appBar: AppBar(
        actions: <Widget>[
         selectedIndex == 1 ?  MyIconButton() : Container()
        ],
        title: Padding(
            child:Image.asset('assets/logotype.png',fit: BoxFit.cover),
            padding: EdgeInsets.only(bottom: 5),

        ),
        backgroundColor: Colors.black,


      ),
      body: pages[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            title: Text("", style: TextStyle(color: selectedIndex == 0 ? Colors.white : Colors.grey)),
            icon: Padding(
                child: Icon(Icons.favorite,color: selectedIndex == 0 ? Colors.white : Colors.grey,size:30),
                padding: EdgeInsets.only(
                    bottom: 5
                )
            ),
          ),
          BottomNavigationBarItem(
            title: Text("",style: TextStyle(color: selectedIndex == 1 ? Colors.white : Colors.grey)),
            icon: Padding(
                child: Icon(CustomIcons.fire,color: selectedIndex == 1 ? Colors.white : Colors.grey,size:30),
                padding: EdgeInsets.only(
                    bottom: 5
                )
            ),
          ),

          /*
          /// PROFILO UTENTE CON FOTO E DATI PERSONALI DELLO STUDENTE

          BottomNavigationBarItem(
            title: Text(""),
            icon: Padding(
                child: Icon(Icons.person,color: selectedIndex == 2 ? Colors.white : Colors.grey,size:30),
                padding: EdgeInsets.only(
                    bottom: 5
                )
            ),
          )*/

        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        currentIndex: selectedIndex,
        backgroundColor: Colors.black,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
    );
  }
}



class MyIconButton extends StatelessWidget {


  Function _showDialog(BuildContext context,Honoo honoo) {

    if (honoo.text == null || honoo.text == "" || honoo.photo == null) {
      showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text("Honoo incompleto"),
          content: Text("Per salvare il tuo honoo esso deve contenere un immagine e un testo"),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        )
      );
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return StoreConnector<AppState, Function>(
                converter: (Store<AppState> store) {
                  return (honoo) {
                    store.dispatch(new SaveHonoo(honoo: honoo));
                    Navigator.pop(context);
                  };
                },

                builder: (BuildContext context, Function callback) {
                  return CupertinoAlertDialog(
                    title: Text("Salva honoo"),
                    content: Text(
                        "Vuoi aggiungere questo honoo alla tua collezione?"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Annulla"),
                      ),
                      FlatButton(
                        onPressed: () => callback(honoo),
                        child: Text("Salva",
                            style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black)),
                      ),
                    ],
                  );
                }
            );
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: HonooViewModel.fromStore,
      builder: (BuildContext context, HonooViewModel model){
        return IconButton(
          icon: Icon(Icons.favorite),
          iconSize: 25,
          onPressed: () => _showDialog(context, Honoo(text: model.text,photo: model.image,theme: model.theme)),
        );
      },
    );
  }
}

