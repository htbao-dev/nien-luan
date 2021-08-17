import 'package:flutter/material.dart';
import 'package:nien_luan/Provider/home_page_provider.dart';
import 'package:nien_luan/View/component/number_keyboard.dart';
import 'package:provider/provider.dart';

import 'contacts_page.dart';

class HomePage extends StatelessWidget{
  HomePage({required Key key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: context.watch<HomePageProvider>().selectIndex,
        children: [
          ContactPage1(),
          Container()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_contact_cal), label: 'Danh bạ'),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time), label: 'nhật ký')
        ],
        currentIndex: context.watch<HomePageProvider>().selectIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: (n) {
          context.read<HomePageProvider>().selectIndex = n;
        },
      ),
      floatingActionButton: MyFloatingActionButton(),
    );
  }
}

class MyFloatingActionButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return context.watch<HomePageProvider>().showFab
        ? FloatingActionButton(
      child: const Icon(Icons.phone),
      onPressed: () {
        var bottomSheetController = showBottomSheet(
            context: context, builder: (context) => NumberKeyboard());
        context.read<HomePageProvider>().showFab = false;
        bottomSheetController.closed.then((value) {
          context.read<HomePageProvider>().showFab = true;
        });
      },
    )
        : Container();
  }

}