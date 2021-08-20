import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactProvider extends ChangeNotifier{
  Iterable<Contact>? _contacts = null;

  Iterable<Contact>? get contacts{
    if (_contacts == null)
      queryContacts();
    return _contacts;
  }

  void queryContacts({String? query}) async {
    var isGranted = await Permission.contacts.isGranted;

    if (isGranted){
      if (query != null)
        _contacts = await ContactsService.getContacts(query: query);
    else
      _contacts = await ContactsService.getContacts();
    }
    else {
      _contacts = null;
    }
    notifyListeners();
  }

  void upDateContact(Contact contact) async {
    await ContactsService.updateContact(contact);
    queryContacts();
  }

  void editContact(int index) async {
    try{
      await ContactsService.openExistingContact(contacts!.elementAt(index));
      queryContacts();
    }
    on FormOperationException catch (e){
      queryContacts();
      print(e.errorCode);
    }
    finally{
      queryContacts();
      print(_contacts!.length);
    }
  }

  void deleteContact(int index) async{
    await ContactsService.deleteContact(contacts!.first);
    queryContacts();
    // print(_contacts!.length);
  }

  void addContact() async{
    await ContactsService.openContactForm();
    queryContacts();
  }
}