import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:honoo/Model/AppState.dart';
import 'HonooCard.dart';
import 'package:honoo/Model/Honoo.dart';
import 'package:flutter/material.dart';
import 'package:honoo/Reducers/Actions//HonooListActions.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';


class HonooDetailView  extends StatelessWidget {
  final Honoo honoo;
  HonooDetailView({@required this.honoo});
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
            HonooCard(honoo: honoo),
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