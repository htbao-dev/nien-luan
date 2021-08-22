import 'package:flutter/material.dart';
import 'package:nien_luan/View/page/Contacts/home_page.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContactAppState();
  }
}

class _ContactAppState extends State<ContactApp> {
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
