import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_app/models/todo.dart';
import 'package:flutter_todo_app/utils/local_storage.dart';
import 'package:flutter_todo_app/utils/locator.dart';

class TaskModel extends ChangeNotifier {
  final TodoStorage _todoStorage = locator<TodoStorage>();
  final TodoListModel _todoListModel = locator<TodoListModel>();

  int id = DateTime.now().microsecondsSinceEpoch;
  String title;
  bool isDone = false;
  bool isImportant = false;

  TaskModel(this.title);

  static TaskModel copy(taskData) {
    TaskModel task = TaskModel(taskData['title']);
    task.id = taskData['id'];
    task.isDone = taskData['isDone'];
    task.isImportant = taskData['isImportant'];
    return task;
  }

  void toggleCompleted() {
    isDone = !isDone;
    print(_todoListModel.todoList);
    _todoStorage.update(_todoListModel.toJSONString());
    notifyListeners();
  }

  void toggleImportant() {
    isImportant = !isImportant;
    _todoStorage.update(_todoListModel.toJSONString());
    notifyListeners();
  }

  void delete() {
    _todoListModel.delete(this);
  }

  String toJSONString() {
    Map<String, dynamic> task = {
      'id': id,
      'title': title,
      'isDone': isDone,
      'isImportant': isImportant,
    };

    return jsonEncode(task);
  }
}