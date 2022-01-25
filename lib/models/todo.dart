import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_app/models/task.dart';

class TodoModal extends ChangeNotifier {
  final List<Task> _todoList = [];

  UnmodifiableListView<Task> get incomplete {
    final uncompletedTodoList = _todoList.where((todo) => !todo.isDone).toList();
    return UnmodifiableListView(uncompletedTodoList);
  }

  UnmodifiableListView<Task> get completion {
    final completedTodoList = _todoList.where((todo) => todo.isDone).toList();
    return UnmodifiableListView(completedTodoList);
  }

  UnmodifiableListView<Task> get importance {
    final importantTodoList = _todoList.where((todo) => todo.isImportant).toList();
    return UnmodifiableListView(importantTodoList);
  }

  void toggleCompleted(Task task) {
    task.toggleCompleted();
    notifyListeners();
  }

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