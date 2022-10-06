import 'package:flutter/cupertino.dart';

class Utils {
  // static validateFields(String textfield1, String textfield2, Function actions,
  //     Function errorMessage) {
  //   (textfield1 == '' && textfield2 == '') ? errorMessage : actions;
  // }

  static String? isValidPassword(String value) {
    value = value.trim();
    if (value.trim().isEmpty) {
      return "Password is required";
    } else if (value.trim().length < 6) {
      return "Password is too short";
    } else if (!value.trim().contains(RegExp(r'[0-9]'))) {
      return "Password must contain a number";
    } else if (!value.trim().toUpperCase().contains(RegExp(r'[A-Z]'))) {
      return "Password must contain a letter";
    }
    return null;
  }
}

void push(BuildContext context, Widget view, {bool dialog = false}) {
  Navigator.push<void>(
      context,
      CupertinoPageRoute<dynamic>(
          builder: (BuildContext context) => view, fullscreenDialog: dialog));
}

void pushReplacement(BuildContext context, Widget view, {bool dialog = false}) {
  Navigator.pushReplacement(
      context,
      CupertinoPageRoute<dynamic>(
          builder: (BuildContext context) => view, fullscreenDialog: dialog));
}

void pushAndRemoveUntil(BuildContext context, Widget view,
    {bool dialog = false}) {
  Navigator.pushAndRemoveUntil(
    context,
    CupertinoPageRoute<dynamic>(
        builder: (BuildContext context) => view, fullscreenDialog: dialog),
    (Route<dynamic> route) => false,
  );
}
