
import 'package:flutter/material.dart';
import 'package:honoo/Model/Honoo.dart' as Honoo;



class HonooCard extends StatelessWidget {

  final Honoo.Honoo honoo;


  HonooCard({@required this.honoo});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 300,
      height: 550,

      decoration: BoxDecoration(
          color: honoo.theme == Honoo.Theme.dark ? Colors.black : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              spreadRadius: 5,
              blurRadius: 10
            )
          ]
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            flex: 2 ,
            child: Padding(
              child: Container(

                child: Center(
                  child: Padding(
                      child: Text(honoo.text,maxLines: 6,textAlign: TextAlign.center,style: TextStyle(fontSize: 16,color: honoo.theme == Honoo.Theme.light ? Colors.black : Colors.white,)),
                      padding: EdgeInsets.only(left:35,right: 35)),
                ),
                decoration: BoxDecoration(
                    color: honoo.theme == Honoo.Theme.dark ? Colors.black : Colors.white,
                    border: Border.all(
                      color:  honoo.theme == Honoo.Theme.light ? Colors.black : Colors.white,
                    )
                ),
              ),
              padding: EdgeInsets.only(top: 5,left: 5,right: 5),
            )
          ),
          Expanded(
              flex: 3,
              child: Padding(
                  child: Container(
                    child: Image.file(honoo.photo,fit: BoxFit.fill),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color:  honoo.theme == Honoo.Theme.light ? Colors.black : Colors.white,
                        )
                    ),
                  ),
                  padding: EdgeInsets.all(5))
          )
        ],
      ),
    );
  }
}
