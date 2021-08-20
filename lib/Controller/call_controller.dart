import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class CallController{
  static void call(String text) async{
    await FlutterPhoneDirectCaller.callNumber(text);
  }
}