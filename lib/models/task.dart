import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Task extends ChangeNotifier {
  int id = DateTime.now().microsecondsSinceEpoch;
  String title;

  bool _isDone = false;
  bool get isDone => _isDone;

  bool _isImportant = false;
  bool get isImportant => _isImportant;

  Task(this.title);

  void toggleCompleted() {
    _isDone = !_isDone;
    notifyListeners();
  }

  void toggleImportant() {
    _isImportant = !_isImportant;
    notifyListeners();
  }

  String toJSONString() {
    Map<String, dynamic> task = {
      'id': id,
      'title': title,
      'isDone': _isDone,
      'isImportant': _isImportant,
    };

    return jsonEncode(task);
  }
}