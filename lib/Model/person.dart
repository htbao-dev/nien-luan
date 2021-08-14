import 'dart:math';

class Person{
  late String _name;
  late List<String> _phoneNumber = List.empty(growable: true);
  late String? _avatarPath;

  String? get avatarPath => _avatarPath;

  set avatarPath(String? value) {
    _avatarPath = value;
  }

  Person(this._name, this._phoneNumber);

  List<String> get phoneNumber => _phoneNumber;
  String get name => _name;

  set phoneNumber(List<String> phoneNumber) {
    _phoneNumber = phoneNumber;
  }
  set name(String name) {
    _name = name;
  }

  List<Person> getListDemo(){
    List<Person> res = List.empty(growable: true);
    res.add(Person("Person test 2", ["123456", "355645"]));
    for (int i = 1; i < 2; i++){
      res.add(Person("Person $i", [Random().nextInt(10000).toString()]));
    }
    return res;
  }
}