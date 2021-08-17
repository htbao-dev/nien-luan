import 'package:flutter/material.dart';
import 'package:nien_luan/Provider/contact_provider.dart';
import 'package:nien_luan/Provider/home_page_provider.dart';
import 'package:nien_luan/View/page/home_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=> HomePageProvider()),
      ChangeNotifierProvider(create: (_)=> ContactProvider()),
    ],
    child: MyApp1(),
  ));
}

class MyApp1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyApp1State();
  }
}

class MyApp1State extends State<MyApp1>{
  late Widget _homePage = HomePage(key: UniqueKey());

  @override
  void initState() {
    super.initState();
    checkPermission().then((value) => setState(() {
      _homePage = HomePage(key: UniqueKey());
    }));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _homePage,
    );
  }

  Future checkPermission() async {
    var ContactsStatus = await Permission.contacts.status;
    print(ContactsStatus);
    print(ContactsStatus.isGranted);
    if (!ContactsStatus.isGranted) {
      await Permission.contacts.request();
    }

    var PhoneStatus = await Permission.phone.status;
    if (!PhoneStatus.isGranted) {
      await Permission.phone.request();
    }
  }
}
