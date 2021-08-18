import 'package:call_log/call_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nien_luan/Controller/call_controller.dart';
import 'package:nien_luan/Controller/calllog_controller.dart';
import 'package:nien_luan/Provider/call_log_provider.dart';
import 'package:provider/provider.dart';
import 'package:nien_luan/View/component/search_textfield.dart';

class CallLogPage extends StatelessWidget{
  CallLogController cl = CallLogController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // title: SearchTextForm(),
        ),
        body: ListView.builder(
            itemBuilder: (context, index) {
              return context.watch<CallLogProvider>().callLogEntries != null
                  ? _buildRow(context, index)
                  :Container();
            },
        itemCount: context.watch<CallLogProvider>().callLogEntries != null?context.watch<CallLogProvider>().callLogEntries!.length:0,)

    );
  }

  _buildRow(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: ListTile(
        title: cl.getTitle(context.watch<CallLogProvider>().callLogEntries!.elementAt(index)),
        subtitle: Row(
          children: [
            IconCallType(context.watch<CallLogProvider>().callLogEntries!.elementAt(index).callType!),
            Text(
                cl.getTime(context.watch<CallLogProvider>().callLogEntries!.elementAt(index).duration!).toString()
                    + '\n' +
                    cl.formatDate(
                        new DateTime.fromMillisecondsSinceEpoch(
                            context.watch<CallLogProvider>().callLogEntries!.elementAt(index).timestamp!)))
          ],
        ),
        trailing: IconButton(icon: Icon(Icons.call),
          onPressed: (){
            print(context.watch<CallLogProvider>().callLogEntries!.elementAt(index).number!);
            CallController.call(context.watch<CallLogProvider>().callLogEntries!.elementAt(index).number!);
          },),),
    );
  }

  Widget IconCallType(CallType type){
    Icon res;
    if (type == CallType.incoming){
      res = Icon(Icons.call_received, color: Colors.blue,);
    }
    else if (type == CallType.outgoing){
      res = Icon(Icons.call_made, color: Colors.green,);

    }
    else if (type == CallType.missed){
      res = Icon(Icons.call_missed, color: Colors.redAccent,);
    }
    else{
      res = Icon(null);
    }
    return res;
  }

}