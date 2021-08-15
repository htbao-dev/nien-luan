import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditInfoPage extends StatefulWidget {
  bool isCreateNew;
  Contact? contact;
  EditInfoPage({required this.isCreateNew, this.contact});
  @override
  State<StatefulWidget> createState() {
    return EditInfoPageState(contact: contact);
  }
}

class EditInfoPageState extends State<EditInfoPage> {
  late Contact? contact;
  late _TextFieldInfo _tf_name;
  late _TextFieldInfo _tf_familyName;
  late List<_TextFieldInfo> _tf_phones;
  EditInfoPageState({this.contact}) {
    String name = "", familyName = "";
    Iterable<Item>? phones;
    _tf_phones = List.empty(growable: true);

    if (contact == null) {
      contact = Contact();
    }
    name = contact!.givenName!;
    familyName = contact!.familyName!;
    phones = contact!.phones;

    _tf_name = _TextFieldInfo(
      hintText: "Tên",
      text: name,
    );
    _tf_familyName = _TextFieldInfo(
      hintText: "Họ",
      text: familyName,
    );
    for (var phone in phones!) {
      _tf_phones.add(_TextFieldInfo(
        hintText: "Số điện thoại",
        text: phone.value!,
        keyboardType: TextInputType.number,
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _Close(context);
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (isChangedData()) {
                      _Save();
                    }
                  },
                  child: Text(
                    "Lưu",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.normal),
                  ))
            ],
          ),
          body: Padding(
            padding: EdgeInsets.only(right: 60, left: 20, top: 30),
            child: Column(
              children: [
                _ContainerInfo(
                    Icon(Icons.person_outline), [_tf_name, _tf_familyName]),
                _ContainerInfo(Icon(Icons.phone_outlined), _tf_phones),
              ],
            ),
          )),
    );
  }

  void _Close(BuildContext context) async {
    var shouldPop = await _onBackPressed(context);
    if (shouldPop) {
      Navigator.of(context).pop();
    }
  }

  void _Save() async {
    print("Save");
    if (widget.isCreateNew) {

    } else {
      contact!.familyName = _tf_familyName.text;
      contact!.givenName = _tf_name.text;
      for (int i = 0; i < contact!.phones!.length; i++){
        contact!.phones!.elementAt(i).value = _tf_phones.elementAt(i).text;
        _tf_phones.elementAt(i).isChanged = false;
      }
      _tf_familyName.isChanged = false;
      _tf_name.isChanged = false;
      await ContactsService.updateContact(contact!);
      setState(() {

      });
    }
  }

  bool isChangedData() {
    bool isChanged = _tf_familyName.isChanged | _tf_name.isChanged;
    for (var _tf_phone in _tf_phones) {
      isChanged |= _tf_phone.isChanged;
    }
    return isChanged;
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    if (!isChangedData()) return true;
    final shouldPop = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("Các thay đổi của bạn chưa được lưu"),
              actions: [
                TextButton(
                  child: Text("Loại bỏ"),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
                TextButton(
                  child: Text("tiếp tục"),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              ],
            ));
    return shouldPop;
  }
}

class _TextFieldInfo extends StatelessWidget {
  late String hintText;
  String text = "";
  bool isChanged = false;
  TextInputType? keyboardType = TextInputType.text;
  _TextFieldInfo(
      {required this.hintText, required this.text, this.keyboardType});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        onChanged: (value) {
          text = value;
          isChanged = true;
        },
        keyboardType: keyboardType,
        controller: TextEditingController(text: text),
        decoration: InputDecoration(
            hintText: hintText,
            labelText: hintText,
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(10)),
        style: TextStyle(fontSize: 18),
      ),
      margin: EdgeInsets.only(
        bottom: 10,
      ),
    );
  }
}

Widget _ContainerInfo(Icon? icon, List<_TextFieldInfo> listTextField) {
  return Container(
    margin: EdgeInsets.only(bottom: 20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: icon,
          margin: EdgeInsets.only(top: 10),
        ),
        Expanded(
            child: Container(
          child: Column(
            children: listTextField,
          ),
          margin: EdgeInsets.only(left: 15),
        ))
      ],
    ),
  );
}
