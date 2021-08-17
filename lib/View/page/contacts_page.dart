import 'package:flutter/material.dart';
import 'package:nien_luan/Controller/contacts_controller.dart';
import 'package:nien_luan/Provider/contact_provider.dart';
import 'package:nien_luan/View/component/contact_avatar.dart';
import 'package:nien_luan/View/component/search_textfield.dart';
import 'package:nien_luan/View/page/person_info_page.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:provider/provider.dart';

class ContactPage1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchTextForm(onTextChanged: onTextChanged,),
        actions: <Widget>[
          IconButton(onPressed: (){}, icon: Icon(Icons.add),)
        ],),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return context.watch<ContactProvider>().contacts != null
          ? _buildRow(context, index)
          : Container();
        },
      itemCount: context.watch<ContactProvider>().contacts != null? context.watch<ContactProvider>().contacts!.length:0,)
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
        leading: ContactAvatar(context.watch<ContactProvider>().contacts!.elementAt(index), 50),
      ),
    );
  }

  void onTextChanged(String value){

  }
}
//
// class ContactsPage extends StatefulWidget {
//   ContactsPage({required Key key}) : super(key: key);
//   @override
//   State<StatefulWidget> createState() {
//     return ContactsPageState();
//   }
// }

// class ContactsPageState extends State<ContactsPage> {
//   ContactsController ct = ContactsController();
//   late Future<Iterable<Contact>?> contacts;
//
//   @override
//   void initState() {
//     super.initState();
//     contacts = ct.getContacts();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: SearchTextForm(onTextChanged: onTextChanged,),
//         actions: <Widget>[
//           IconButton(onPressed: (){}, icon: Icon(Icons.add),)
//         ],),
//       body: FutureBuilder(
//           future: contacts,
//           builder: (context, snapshot) {
//             if (snapshot.hasData){
//               Iterable<Contact> entries = snapshot.data as Iterable<Contact>;
//               return ListView.builder(
//                   itemCount: entries.length,
//                   itemBuilder: (context, index) {
//                     return _buildRow(entries.elementAt(index));
//                   });
//             } else
//               return Container();
//           }),
//     );
//   }
//
//   Widget _buildRow(Contact contact) {
//     return Container(
//       margin: EdgeInsets.only(top: 7),
//       child: ListTile(
//         onTap: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => PersonInfoPage(index)));
//         },
//         title: Text(contact.displayName!),
//         leading: ContactAvatar(contact, 50),
//       ),
//     );
//   }
//
//   void onTextChanged(String value){
//     setState(() {
//       contacts = ct.getContacts(query: value);
//     });
//   }
// }
