import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_app/models/task.dart';

class TodoModal extends ChangeNotifier {
  final List<Task> _todoList = [];

  UnmodifiableListView<Task> get incomplete {
    final incompletedTodoList = _todoList.where((todo) => !todo.isDone).toList();
    print('list rebuild');
    return UnmodifiableListView(incompletedTodoList);
  }

  UnmodifiableListView<Task> get completion {
    final completedTodoList = _todoList.where((todo) => todo.isDone).toList();
    return UnmodifiableListView(completedTodoList);
  }

  UnmodifiableListView<Task> get importance {
    final importantTodoList = _todoList.where((todo) => todo.isImportant).toList();
    return UnmodifiableListView(importantTodoList);
  }

  void add(Task task) {
    _todoList.add(task);
    notifyListeners();
  }

  void delete(int id) {
    _todoList.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  void handleTaskUpdateEvent() => notifyListeners();

  String toJSONString() {
    return jsonEncode(_todoList.map((task) => task.toJSONString()).toList());
  }
}