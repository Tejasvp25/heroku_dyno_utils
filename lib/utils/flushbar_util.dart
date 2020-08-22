import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';

void showMsg(BuildContext context, String msg) {
  Flushbar(
    message: msg,
    duration: const Duration(seconds: 3),
    flushbarStyle: FlushbarStyle.FLOATING,
  ).show(context);
}
