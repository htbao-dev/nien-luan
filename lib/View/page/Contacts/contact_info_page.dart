import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nien_luan/Provider/call_log_provider.dart';
import 'package:nien_luan/Provider/contact_provider.dart';
import 'package:nien_luan/View/component/contact_avatar.dart';
import 'package:provider/provider.dart';

class ContactInfoPage extends StatelessWidget {
  var _tapPosition;
  int index;
  ContactInfoPage(this.index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
            Container(
              //person's avatar
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: ContactAvatar(
                size: 100,
                contact:
                    context.watch<ContactProvider>().contacts!.elementAt(index),
                fontSize: 40,
              ),
            ),
            Container(
              // person's name
              margin: const EdgeInsets.fromLTRB(15, 0, 0, 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context
                      .watch<ContactProvider>()
                      .contacts!
                      .elementAt(index)
                      .displayName!,
                  style: const TextStyle(fontSize: 30),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Container(
              // action buttons
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              decoration: _borderBotTop,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // call button
                    margin: const EdgeInsets.fromLTRB(0, 5, 40, 5),
                    child: IconButton(
                        onPressed: () async {
                          String phoneNumber = "";
                          final listPhoneNumber = context
                              .watch<ContactProvider>()
                              .contacts!
                              .elementAt(index)
                              .phones!
                              .toList()
                              .map((e) => e.value);
                          if (listPhoneNumber.length > 1) {
                            phoneNumber = await showDialogChoosePhoneNumber(
                                context, listPhoneNumber);
                          } else if (listPhoneNumber.length == 1) {
                            phoneNumber = listPhoneNumber.elementAt(0)!;
                          }
                          if (phoneNumber.isNotEmpty)
                            FlutterPhoneDirectCaller.callNumber(phoneNumber).then((value){
                              context.read<CallLogProvider>().queryCallLog();
                            });
                        },
                        icon: Icon(
                          Icons.call_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        iconSize: 28),
                  ),
                  Container(
                    // message button
                    margin: const EdgeInsets.fromLTRB(40, 5, 0, 5),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.message_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        iconSize: 28),
                  )
                ],
              ),
            ),
            SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: context
                      .watch<ContactProvider>()
                      .contacts!
                      .elementAt(index)
                      .phones!
                      .length,
                  itemBuilder: (context, indexPhone) => _buildRow(
                      context,
                      context
                          .watch<ContactProvider>()
                          .contacts!
                          .elementAt(index)
                          .phones!
                          .elementAt(indexPhone)
                          .value!),
                ))
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _edit(context);
        },
        label: const Text("Chỉnh sửa liên hệ"),
        icon: const Icon(Icons.edit),
      ),
    );
  }

  void _edit(BuildContext context) {
    context.read<ContactProvider>().editContact(index);
    context.read<ContactProvider>().queryContacts();

    // Navigator.push(context, MaterialPageRoute(builder: (context) => EditInfoPage(isCreateNew: false, contact: contact),))
  }

  // void _delete(BuildContext context) {
  //   context.read<ContactProvider>().deleteContact(index);
  //   Navigator.pop(context);
  // }

  Widget _buildRow(BuildContext context, String phoneNumber) {
    double _iconSize = 25;
    return GestureDetector(
      onTapDown: _storePosition,
      child: ListTile(
          onTap: () {
            FlutterPhoneDirectCaller.callNumber(phoneNumber);
          },
          onLongPress: () async {
            final RenderBox? overlay =
                Overlay.of(context)!.context.findRenderObject() as RenderBox?;
            int? value = await showMenu(
                context: context
                position: RelativeRect.fromRect(
                    _tapPosition & Size(40, 40), Offset.zero & overlay!.size),
                items: [
                  PopupMenuItem<int>(
                    child: Text("copy"),
                    value: 1,
                    textStyle: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ]);
            if (value == 1) {
              Clipboard.setData(ClipboardData(text: phoneNumber));
              Fluttertoast.showToast(
                  msg: "Đã copy!",
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: 16.0);
            }
          },
          title: Row(
            children: [
              Icon(
                Icons.phone,
                size: _iconSize,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: Text(
                  phoneNumber,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.message_outlined,
                    color: Theme.of(context).primaryColor,
                    size: _iconSize,
                  )),
            ],
          )),
    );
  }

  Future<String> showDialogChoosePhoneNumber(
      BuildContext context, Iterable<String?> listPhoneNumber) async {
    String res = "";
    List<Widget> listChildren = List.empty(growable: true);
    for (var element in listPhoneNumber) {
      listChildren.add(DialogPhoneNumberOption(element!, (str) {
        res = element;
        Navigator.pop(context);
      }));
    }
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Container(
              padding: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(width: 0.5))),
              alignment: Alignment.center,
              child: const Text("Chọn số điện thoại"),
            ),
            children: listChildren,
          );
        });
    return res;
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  final BoxDecoration _borderBotTop = const BoxDecoration(
      border: Border(
          bottom: BorderSide(width: 0.15), top: BorderSide(width: 0.15)));
}

class DialogPhoneNumberOption extends StatelessWidget {
  DialogPhoneNumberOption(this.phoneNumber, this.onTap);
  String phoneNumber;
  Function(String) onTap;
  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
        onPressed: () => onTap(phoneNumber),
        child: Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: Row(
            children: [
              const Icon(Icons.phone),
              Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: Text(
                    phoneNumber,
                    style: const TextStyle(fontSize: 18),
                  ))
            ],
          ),
        ));
  }
}
