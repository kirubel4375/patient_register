import 'package:flutter/cupertino.dart';

class ChangingState extends ChangeNotifier{
  List<bool> pending = [];

  void toggleValue({required int index, required List<bool> value}){
    pending = value;
    pending[index] = !pending[index];
    notifyListeners();
  }
  void assignValue(List<bool> value){
    pending = value;
    notifyListeners();
  }
}