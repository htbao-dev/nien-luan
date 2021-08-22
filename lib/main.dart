import 'package:flutter/material.dart';
import 'package:nien_luan/Provider/call_log_provider.dart';
import 'package:nien_luan/Provider/contact_provider.dart';
import 'package:nien_luan/Provider/home_page_provider.dart';
import 'package:nien_luan/View/page/Contacts/contacts_app.dart';
import 'package:provider/provider.dart';

import 'View/page/Weather/weather_app.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HomePageProvider()),
      ChangeNotifierProvider(create: (_) => ContactProvider()),
      ChangeNotifierProvider(create: (_) => CallLogProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
      builder: (context) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              createAppIcon(context, Icons.contacts, "Danh bạ", ContactApp()),
              createAppIcon(context, Icons.wb_sunny, "Thời tiết", WheatherApp())
            ],
          ),
        ),
      ),
    ));
  }

  Widget createAppIcon(
      BuildContext context, IconData IconData, String Title, Widget App) {
    return MaterialButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => App,
              ));
        },
        child: Column(
          children: [Icon(IconData), Text(Title)],
        ));
  }
}
