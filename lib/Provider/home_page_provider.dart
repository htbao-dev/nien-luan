import 'package:flutter/cupertino.dart';

class HomePageProvider extends ChangeNotifier{
  int _selectIndex = 0;
  bool _showFab = true;

  bool get showFab => _showFab;

  set showFab(bool value) {
    _showFab = value;
    notifyListeners();
  }

  int get selectIndex=>_selectIndex;

  set selectIndex(int value) {
    _selectIndex = value;
    notifyListeners();
  }


}