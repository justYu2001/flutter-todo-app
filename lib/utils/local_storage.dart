import 'dart:convert';

import 'package:flutter_todo_app/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoStorage {
  final _key = 'todo';

  TodoStorage();

  Future<List<TaskModel>> getTodoList() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    String todoListJSONString = sharedPreferences.getString(_key) ?? '[]';
    final List<dynamic> taskJSONStringList = jsonDecode(todoListJSONString);

    final todoList = taskJSONStringList.map((taskJSONString) {
      final task = jsonDecode(taskJSONString);
      return TaskModel.copy(task);
    }).toList();

    return todoList;
  }

  Future<void> update(todoListJSONString) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_key, todoListJSONString);
  }
}