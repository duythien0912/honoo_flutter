
import 'Model/Honoo.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';

Map<String,dynamic> honooListToJson(List<Honoo> l) {
  Map<String,dynamic> map = Map<String,dynamic>();

  l.forEach((element) {
     map["element ${l.indexOf(element)}"] = element.toJson();
  });

  return map;
}


List<Honoo> honooListFomJson(Map<String,dynamic> json)  {

  var iterablelist = [];
  json.forEach((key,value) async {
    iterablelist.add( Honoo.fromJson(value));
  });
  return List.from(iterablelist);
}



String saveFile(File fileToSave ) {
  if (fileToSave == null) return "";
  Uint8List bytes = fileToSave.readAsBytesSync();
  String base64Image = base64Encode(bytes);
  return base64Image;
}

Future<String> getFilePathForData(String data,{String extension = '.png'}) async {
  List l = data.codeUnits;
  var bytes = Uint8List.fromList(l);
  var dir = (await getTemporaryDirectory()).path;
  var file = new File("$dir/image"+DateTime.now().millisecondsSinceEpoch.toString()+extension);
  await file.writeAsBytes(bytes);
  return file.path;
}