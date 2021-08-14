import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class NumberKeyboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NumberKeyboardState();
  }
}

class NumberKeyboardState extends State<NumberKeyboard> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.8),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ]),
      child: Wrap(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: TextFieldPhoneNumber(_controller, ()=>_backspace()
            ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NumberButton(
                  number: "1",
                  onButtonTap: (String number) =>_insertNumber(number)
                ),
                NumberButton(
                  number: "2",
                  onButtonTap: (String number) =>_insertNumber(number)
                ),
                NumberButton(
                  number: "3",
                  onButtonTap: (String number) =>_insertNumber(number)
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NumberButton(
                  number: "4",
                  onButtonTap: (String number) =>_insertNumber(number)
                ),
                NumberButton(
                  number: "5",
                  onButtonTap: (String number) =>_insertNumber(number)
                ),
                NumberButton(
                  number: "6",
                  onButtonTap: (String number) =>_insertNumber(number)
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NumberButton(
                  number: "7",
                  onButtonTap: (String number) =>_insertNumber(number)
                ),
                NumberButton(
                  number: "8",
                  onButtonTap: (String number) =>_insertNumber(number)
                ),
                NumberButton(
                  number: "9",
                  onButtonTap: (String number) =>_insertNumber(number)
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NumberButton(
                  number: "*",
                  onButtonTap: (String number) =>_insertNumber(number)
                ),
                NumberButton(
                  number: "0",
                  onButtonTap: (String number) =>_insertNumber(number)
                ),
                NumberButton(
                  number: "#",
                  onButtonTap: (String number) =>_insertNumber(number)
                ),
              ],
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10, 8, 10, 13),
                child: RawMaterialButton(
                  onPressed: ()  {
                    final phoneNumber = _controller.text;
                    // print(PhoneNumber);
                    FlutterPhoneDirectCaller.callNumber(phoneNumber);
                    // launch(("tel://$PhoneNumber"));
                  },
                    padding:  const EdgeInsets.all(12),
                    child: const Icon(
                      Icons.phone,
                      size: 33,
                      color: Colors.white,
                    ),
                    fillColor: Colors.green,
                    shape: const CircleBorder()))
          ],
        ),
      ]),
    );
  }

  void _insertNumber(String number){
    setState(() {
      final start = _controller.selection.start;
      final end = _controller.selection.end;
      final length = _controller.text.length;
      final text = _controller.text;
      final newText = text.substring(0,start) + number + text.substring(end, length);
      _controller.text = newText;
      _controller.selection = TextSelection.fromPosition(TextPosition(offset: start+1));
    });
  }

  void _backspace(){
    setState(() {
      final start = _controller.selection.start;
      final end = _controller.selection.end;
      if (end - start > 0){
        final newText = _controller.text.replaceRange(start, end, "");
        _controller.text = newText;
        _controller.selection = TextSelection.fromPosition(TextPosition(offset: start));
      }

      else if (start == 0) {
        return;
      } else{
        final newText = _controller.text.replaceRange(start-1, end, "");
        _controller.text = newText;
        _controller.selection = TextSelection.fromPosition(TextPosition(offset: start-1));
      }
    });
  }
}

class NumberButton extends StatelessWidget {
  final String number;
  Function(String) onButtonTap;
  NumberButton({required this.number, required this.onButtonTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: RawMaterialButton(
          onPressed: () => onButtonTap(number),
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Text(
            number,
            style: const TextStyle(fontSize: 33, color: Colors.white),
          ),
          fillColor: Colors.blue,
          shape: const CircleBorder()),
    );
  }
}

class TextFieldPhoneNumber extends StatelessWidget {
  final TextEditingController _controller;
  Function() onBackspaceTap;
  TextFieldPhoneNumber(this._controller, this.onBackspaceTap);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                maxLines: null,
                style: const TextStyle(fontSize: 25),
                controller: _controller,
                readOnly: true,
                showCursor: true,
                autofocus: true,
                decoration: const InputDecoration(
                    border: InputBorder.none
                ),
              ),
            ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: IconButton(onPressed: () {onBackspaceTap();}, icon: const Icon(Icons.backspace)),
            ),
          )
        ],
      )
    );
  }
}
