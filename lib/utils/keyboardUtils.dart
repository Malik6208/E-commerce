import 'package:flutter/cupertino.dart';

class KeyBoardUtils{
  static void hideKeyBoard(BuildContext context){
    FocusNode currentFocus=FocusScope.of(context);
    if(!currentFocus.hasPrimaryFocus)
      {
        currentFocus.unfocus();
      }
  }
}