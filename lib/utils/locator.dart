import 'package:flutter_todo_app/models/todo.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_todo_app/utils/local_storage.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(TodoStorage());
  locator.registerSingleton(TodoListModel());
}