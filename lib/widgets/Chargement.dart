import 'package:flutter/material.dart';
import 'package:fungola_app/utils/ColorPage.dart';

Widget Chargement([bool isVisible=false] ){
  return Visibility(
    visible: isVisible,
    child: Align(
        alignment: Alignment.center,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          //color: Colors.grey.withOpacity(0.4),
          color: Colors.black38,
          child: Center(
            child: CircularProgressIndicator(color: Utils.COLOR_VIOLET,),
          ),
        )
    ),
  ) ;
}