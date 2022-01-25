import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_app/models/task.dart';

class TodoModal extends ChangeNotifier {
  final List<Task> _todoList = [];

  UnmodifiableListView<Task> get all => UnmodifiableListView(_todoList);

  void add(Task task) {
    _todoList.add(task);
    notifyListeners();
  }

  void delete(int id, [bool neededRebuilding = true]) {
    _todoList.removeWhere((todo) => todo.id == id);

    if(neededRebuilding) {
      notifyListeners();
    }
  }

  String toJSONString() {
    return jsonEncode(_todoList.map((task) => task.toJSONString()).toList());
  }
}