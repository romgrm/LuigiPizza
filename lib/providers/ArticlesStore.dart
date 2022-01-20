import 'dart:collection';

import 'package:flutter/material.dart';

class ArticlesStore extends ChangeNotifier {
  List store = [];

  void removeItem(index) {
    store.removeAt(index);
    notifyListeners();
  }

  void addItem(List item) {
    store = item;
    print(store);
    notifyListeners();
  }
}
