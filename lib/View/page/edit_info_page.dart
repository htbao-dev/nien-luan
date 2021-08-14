import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditInfoPage extends StatelessWidget {
  late Contact? contact;
  _TextFieldInfo tf_name = _TextFieldInfo("Tên");
  _TextFieldInfo tf_familyName = _TextFieldInfo("Họ");
  _TextFieldInfo tf_phoneNumber = _TextFieldInfo("Số điện thoại");
  EditInfoPage({this.contact}) {
    if (contact != null) contact = Contact();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>_onBackPressed(context),
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.close), onPressed: () { _Close(context);},),
            actions: [TextButton(onPressed: (){_Save();}, child: Text("Lưu", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.normal),))],
          ),
          body: Padding(
            padding: EdgeInsets.only(right: 60, left: 20, top: 30),
            child: Column(
              children: [
                _ContainerInfo(Icon(Icons.person_outline), [tf_name, tf_familyName]),
                _ContainerInfo(Icon(Icons.phone_outlined), [tf_phoneNumber]),
              ],
            ),
          )),
    );
  }

  void _Close(BuildContext context)async{
    var shouldPop = await _onBackPressed(context);
    if(shouldPop){
      Navigator.of(context).pop();
    }
  }

  void _Save(){

  }

  Future<bool> _onBackPressed(BuildContext context) async {
    if (tf_phoneNumber.text.isEmpty && tf_familyName.text.isEmpty && tf_name.text.isEmpty){
      return true;
    }
    final shouldPop = await showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          content: Text("Các thay đổi của bạn chưa được lưu"),
          actions: [
            TextButton(
              child: Text("Loại bỏ"),
              onPressed: ()=>Navigator.of(context).pop(true),
            ),
            TextButton(
              child: Text("tiếp tục"),
              onPressed: ()=>Navigator.of(context).pop(false),
            ),
          ],
        ));
    return shouldPop;
  }
}

class  _TextFieldInfo extends StatelessWidget {
  late String? hintText;
   String text = "";
  _TextFieldInfo(this.hintText);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        onChanged: (value) {
          text = value;
        },
        decoration: InputDecoration(
            hintText: hintText!,
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

Widget _ContainerInfo(Icon? icon, List<_TextFieldInfo> listTextField){
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

