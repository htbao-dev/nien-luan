import 'package:call_log/call_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nien_luan/Controller/call_controller.dart';
import 'package:nien_luan/Controller/calllog_controller.dart';
import 'package:nien_luan/Provider/call_log_provider.dart';
import 'package:provider/provider.dart';
import 'package:nien_luan/View/component/search_textfield.dart';

class CallLogPage extends StatelessWidget {
  CallLogController cl = CallLogController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // title: SearchTextForm(),
            ),
        body: SafeArea(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return context.watch<CallLogProvider>().callLogEntries != null
                  ? _buildRow(
                      context,
                      context
                          .watch<CallLogProvider>()
                          .callLogEntries!
                          .elementAt(index))
                  : Container();
            },
            itemCount:
                context.watch<CallLogProvider>().callLogEntries?.length ?? 0,
          ),
        ));
  }

  _buildRow(BuildContext context, CallLogEntry callLogEntry) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: ListTile(
        title: cl.getTitle(callLogEntry),
        subtitle: Row(
          children: [
            IconCallType(callLogEntry.callType!),
            Text(cl.getTime(callLogEntry.duration!).toString() +
                '\n' +
                cl.formatDate(new DateTime.fromMillisecondsSinceEpoch(
                    callLogEntry.timestamp!)))
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.call),
          onPressed: () {
            CallController.call(callLogEntry.number!).then((value) {
              if (value ?? false) {
                context.read<CallLogProvider>().queryCallLog();
              }
            });
          },
        ),
      ),
    );
  }

  Widget IconCallType(CallType type) {
    Icon res;
    if (type == CallType.incoming) {
      res = Icon(
        Icons.call_received,
        color: Colors.blue,
      );
    } else if (type == CallType.outgoing) {
      res = Icon(
        Icons.call_made,
        color: Colors.green,
      );
    } else if (type == CallType.missed) {
      res = Icon(
        Icons.call_missed,
        color: Colors.redAccent,
      );
    } else {
      res = Icon(null);
    }
    return res;
  }
}
