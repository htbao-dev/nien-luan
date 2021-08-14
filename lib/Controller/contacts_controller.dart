import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsController{

  Future<Iterable<Contact>?> getContacts({String? query}) async {
    var isGranted = await Permission.contacts.isGranted;

      if (isGranted){
        if (query != null)
          return await ContactsService.getContacts(query: query);
        else
        return await ContactsService.getContacts();
      }
      else {
        return null;
      }
  }

  String? getName(Contact contact){
    return contact.displayName;
  }


}