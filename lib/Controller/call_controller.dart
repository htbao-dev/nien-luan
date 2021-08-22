import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class CallController{
  static Future<bool?> call(String text) {
    return FlutterPhoneDirectCaller.callNumber(text);
  }
}