import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:flutter_todo_app/utils/local_storage.dart';
import 'package:flutter_todo_app/utils/locator.dart';

class TodoListModel extends ChangeNotifier {
  final TodoStorage _todoStorage = locator<TodoStorage>();

  List<TaskModel> _todoList = [];
  List<TaskModel> get todoList => _todoList;

  TodoListModel();

  Future<void> initialize() async {
    _todoList = await _todoStorage.getTodoList();
    _todoList.removeWhere((todo) {
      final currentTime = DateTime.now();
      final todayStartTime = DateTime(currentTime.year, currentTime.month, currentTime.day);
      return todo.id < todayStartTime.microsecondsSinceEpoch;
    });
    notifyListeners();
  }

  String toJSONString() {
    final taskJSONStringList = _todoList.map((todo) => todo.toJSONString()).toList();
    return jsonEncode(taskJSONStringList);
  }

  void add(TaskModel task) {
    _todoList.add(task);
    print(_todoList);
    _todoStorage.update(toJSONString());
    notifyListeners();
  }

  void delete(TaskModel task) {
    _todoList.removeWhere((todo) => todo.id == task.id);
    _todoStorage.update(toJSONString());
    notifyListeners();
  }
}