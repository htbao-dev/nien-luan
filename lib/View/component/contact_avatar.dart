import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class ContactAvatar extends StatelessWidget {
  ContactAvatar(this.contact, this.size);
  final Contact contact;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            shape: BoxShape.circle),
        child: (contact.avatar != null && contact.avatar!.length > 0)
            ? CircleAvatar(
          backgroundImage: MemoryImage(contact.avatar!),
        )
            : CircleAvatar(
            child: Text(contact.initials(), style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.cyan,
            ));
  }
}