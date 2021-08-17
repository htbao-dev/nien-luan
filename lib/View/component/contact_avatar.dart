import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class ContactAvatar extends StatelessWidget {
  ContactAvatar({required this.contact, required this.size, required this.fontSize});
  final Contact contact;
  final double size;
  final double fontSize;
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
            child: Text(contact.initials(), style: TextStyle(color: Colors.white, fontSize: fontSize),),
          backgroundColor: Colors.cyan,
            ));
  }
}