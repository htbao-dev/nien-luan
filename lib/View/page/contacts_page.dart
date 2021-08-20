import 'package:flutter/material.dart';
import 'package:nien_luan/Controller/contacts_controller.dart';
import 'package:nien_luan/Provider/contact_provider.dart';
import 'package:nien_luan/View/component/contact_avatar.dart';
import 'package:nien_luan/View/component/search_textfield.dart';
import 'package:nien_luan/View/page/person_info_page.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:provider/provider.dart';

class ContactPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchTextForm(onTextChanged: (String value){
          context.read<ContactProvider>().queryContacts(query: value);
        },),
        actions: <Widget>[
          IconButton(onPressed: (){
            context.read<ContactProvider>().addContact();
          }, icon: Icon(Icons.add),)
        ],),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return context.watch<ContactProvider>().contacts != null
          ? _buildRow(context, index)
          : Container();
        },
      itemCount: context.watch<ContactProvider>().contacts?.length??0,)
    );
  }

  Widget _buildRow(BuildContext context , int index) {
    return Container(
      margin: EdgeInsets.only(top: 7),
      child: ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PersonInfoPage(index)));
        },
        title: Text(context.watch<ContactProvider>().contacts!.elementAt(index).displayName!),
        leading: ContactAvatar(contact: context.watch<ContactProvider>().contacts!.elementAt(index), size: 50, fontSize: 20,),
      ),
    );
  }
}
