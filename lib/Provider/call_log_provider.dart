import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CallLogProvider extends ChangeNotifier{
  Iterable<CallLogEntry>? _callLogEntries = null;

  Iterable<CallLogEntry>? get callLogEntries{
    if (_callLogEntries == null){
      queryCallLog();
    }
    return _callLogEntries;
  }

  void queryCallLog() async {
    var isGranted = await Permission.phone.isGranted;
    if (isGranted){
      _callLogEntries = await CallLog.get();
    }
    else{
      _callLogEntries = null;
    }
    notifyListeners();
  }
}