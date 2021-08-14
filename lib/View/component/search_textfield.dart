import 'package:flutter/material.dart';

class SearchTextForm extends StatelessWidget {
  late Function(String)? onTextChanged;
  SearchTextForm({this.onTextChanged});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
          icon: Icon(Icons.search, color: Colors.white),
          hintText: "Tìm Kiếm",
          hintStyle: TextStyle(color: Colors.white)),
      autofocus: false,
      onChanged: (value) {
        onTextChanged!(value);
      },
    );
  }
}
