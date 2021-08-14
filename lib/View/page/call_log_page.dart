import 'package:call_log/call_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nien_luan/Controller/call_controller.dart';
import 'package:nien_luan/Controller/calllog_controller.dart';
import 'package:nien_luan/View/component/search_textfield.dart';

class CallLogPage extends StatefulWidget {
  CallLogPage({required Key key}):super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CallLogPageState();
  }
}

class CallLogPageState extends State<CallLogPage> {
  CallLogController cl = CallLogController();
  late Future<Iterable<CallLogEntry>?> logs;

  @override
  void initState() {
    super.initState();
    logs = cl.getCallLogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // title: SearchTextForm(),
        ),
        body: FutureBuilder(
          future: logs,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Iterable<CallLogEntry>? entries =
                  snapshot.data as Iterable<CallLogEntry>?;
              return ListView.builder(
                  itemCount: entries!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: ListTile(
                        title: cl.getTitle(entries.elementAt(index)),
                        subtitle: Row(
                          children: [
                            IconCallType(entries.elementAt(index).callType!),
                            Text(
                                cl.getTime(entries.elementAt(index).duration!).toString()
                                    + '\n' +
                                    cl.formatDate(
                                        new DateTime.fromMillisecondsSinceEpoch(
                                            entries.elementAt(index).timestamp!)))
                          ],
                        ),
                        trailing: IconButton(icon: Icon(Icons.call),
                          onPressed: (){
                          print(entries.elementAt(index).number!);
                            CallController.call(entries.elementAt(index).number!);
                          },),),
                    );
                  });
            } else {
              return Center(
                child: Text("No Data"),
              );
            }
          },
        )
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
