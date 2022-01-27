import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/todo.dart';
import 'package:flutter_todo_app/utils/locator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todo_app/screens/home.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    TodoListModel todoListModel = locator<TodoListModel>();

    return ChangeNotifierProvider(
      create: (context) {
        todoListModel.initialize();
        return todoListModel;
      },
      child: MaterialApp(
        title: 'Flutter Todo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Home(),
      ),
    );
  }
}