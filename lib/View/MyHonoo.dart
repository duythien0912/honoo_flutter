import 'dart:io';
import 'dart:typed_data';
import 'package:honoo/View/HonooDetail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:honoo/Model/AppState.dart';
import 'package:honoo/Reducers/Actions/HonooListActions.dart';
import 'package:honoo/View/HonooCard.dart';
import 'package:flutter/material.dart';
import 'package:honoo/ViewModel/HonooListViewModel.dart';
import 'package:honoo/Model/Honoo.dart';
import 'package:redux/redux.dart';
import 'package:honoo/TransparentRoute.dart';

class MyHonoo extends StatefulWidget {
  _MyHonooState createState() => _MyHonooState();

}


class _MyHonooState extends State<MyHonoo> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreConnector<AppState,HonooListViewModel>(
      converter: HonooListViewModel.fromStore,
      builder: (BuildContext context, HonooListViewModel model) {
         return model.honoos.isNotEmpty ? ListView.separated(
            itemBuilder: (_,index) => Padding(child: _ListViewCell(honoo: List.from(model.honoos.reversed)[index]),padding: EdgeInsets.all(20)),
            itemCount: model.honoos.length,
            separatorBuilder: (_,__) => Divider(thickness: 1, height: 0,indent: 50, endIndent: 50,),
        ) : Center(child: EmptyView(),);
      }
    );
  }
}

class EmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(60)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            flex: 3,
            child: Container(
              child: Image.asset('assets/honooIcon.png', fit: BoxFit.fill),
            ),
          ),
          Flexible(
            flex: 1,
            child: Text("Non hai ancora realizzato alcun honoo",textAlign: TextAlign.center,)
          ),
        ],
      ),
    );
  }
}





class _ListViewCell extends StatelessWidget {
  final Honoo honoo;
  _ListViewCell({@required this.honoo});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreConnector<AppState,Function>(
        converter: (Store<AppState> store){
          return (action) {
            store.dispatch(action);
          };
        },
      builder: (BuildContext context, Function callback){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:[
              GestureDetector(
                child:HonooCard(honoo: honoo),
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HonooDetailView(honoo: this.honoo))
                  );
                },
              ),
              
              Padding(padding: EdgeInsets.all(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete,color: Colors.red),
                    onPressed: () => callback(RemoveHonoo(honoo: honoo)),
                    iconSize: 35,
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      //TODO: Navigation to editing page
                    },
                    iconSize: 35,

                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    iconSize: 35,
                    onPressed: () async {
                        //TODO: Show share sheet
                      var image = "assets/logotype.png";
                      await _shareImage(image);
                    },
                  )
                ],
              ),
            ],
          );
      },
    );
  }
}


void _shareImage(image) async {

  try {

    final ByteData bytes = await rootBundle.load(image);
    final Uint8List list = bytes.buffer.asUint8List();

    final tmpDir = await getApplicationDocumentsDirectory();
    final file = await File("${tmpDir.path}/logotype.png").create();
    file.writeAsBytesSync(list);

    final channel = MethodChannel("channel:honoo.share/share");
    channel.invokeMethod("shareFile", "logotype.png");

  } catch (e) {

   FlutterError(e.toString());
  }
}