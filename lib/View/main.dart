import 'package:flutter/material.dart';
import 'package:nien_luan/View/page/call_log_page.dart';
import 'package:nien_luan/View/page/contacts_page.dart';
import 'package:nien_luan/View/page/edit_info_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'component/number_keyboard.dart';

void main() {
  runApp(MaterialApp(
    title: "My App",
    home: MyApp(),
    // home: EditInfoPage()
  ));
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }

}
class MyAppState extends State<MyApp> {
  int _selectIndex = 0;
  late Widget _contacts = ContactsPage(key: UniqueKey(),);
  late Widget _callLog = CallLogPage(key: UniqueKey());

  @override
  void initState(){
    super.initState();
    checkPermission().then((value) => setState((){
      _contacts = ContactsPage(key: UniqueKey());
      _callLog = CallLogPage(key: UniqueKey());
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectIndex,
        children: [
          _contacts,
          _callLog,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.perm_contact_cal), label: 'Danh bạ'),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'nhật ký')
        ],
        currentIndex: _selectIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: (n){setState(() {
          _selectIndex = n;
        });},
      ),
      floatingActionButton: MyFloatingActionButton(),
    );
  }

  Future checkPermission() async{
    var ContactsStatus = await Permission.contacts.status;
    if (!ContactsStatus.isGranted){
      await Permission.contacts.request();
    }

    var PhoneStatus = await Permission.phone.status;
    if (!PhoneStatus.isGranted){
      await Permission.phone.request();
    }
  }
}

class MyFloatingActionButton extends StatefulWidget {
  @override
  State<MyFloatingActionButton> createState() => _MyFloatingActionButtonState();
}

class _MyFloatingActionButtonState extends State<MyFloatingActionButton> {
  bool showFab = true;
  @override
  Widget build(BuildContext context) {
    return showFab
        ? FloatingActionButton(
      child: const Icon(Icons.phone),
      onPressed: () {
        var bottomSheetController = showBottomSheet(
            context: context,
            builder: (context) => NumberKeyboard());
        showFloatingActionButton( false);
        bottomSheetController.closed.then((value) {
          showFloatingActionButton(true);
        });
      },
    )
        : Container();
  }

  void showFloatingActionButton(bool value) {
    setState(() {
      showFab = value;
    });
  }

}
