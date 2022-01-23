import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_todo_app/models/todo.dart';
import 'package:flutter_todo_app/models/task.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const[
            TimeBar(),
            TitleBar(),
            TodoList(),
          ],
        ),
      ),
      // bottomSheet: const NewTaskButton(),
      bottomNavigationBar:const NewTaskButton(),
    );
  }
}

class TimeBar extends StatelessWidget {
  const TimeBar({Key? key}) : super(key: key);

  String getTodayDateString() {
    final today = DateTime.now();

    List<String> monthChineseString = [
      '',
      '一月',
      '二月',
      '三月',
      '四月',
      '五月',
      '六月',
      '七月',
      '八月',
      '九月',
      '十月',
      '十一月',
      '十二月'
    ];

    return '${monthChineseString[today.month]} ${today.day}, ${today.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child:
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            getTodayDateString(),
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
    );
  }
}

class TitleBar extends StatelessWidget {
  const TitleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          height: 76.0,
        ),
        const Text(
            '今日任務',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 36.0,
            )
        ),
      ],
    );
  }
}

class TodoItem extends StatelessWidget {
  const TodoItem({Key? key}) : super(key: key);

  void toggleImportantState(task) {
    if(task.isImportant) {
      task.markAsUnimportant();
    } else {
      task.markAsImportant();
    }
  }

  Icon getTrailingIcon(task) {
    if(task.isImportant) {
      return const Icon(
        Icons.star,
        color: Colors.yellow,
        size: 24.0,
      );
    } else {
      return const Icon(
        Icons.star_border,
        color: Colors.grey,
        size: 24.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var todo = context.watch<TodoModal>();
    var task = context.watch<Task>();

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 0.0,
            blurRadius: 2.6,
            offset: const Offset(1.95, 1.95), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 3.0,
        horizontal: 10.0,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 0.0,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 25.0,
            height: 25.0,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: const CircleBorder(),
                primary: Colors.white,
                side: const BorderSide(
                    color: Color.fromARGB(255, 200, 200, 200), width: 2.0
                ),
              ),
              child: const SizedBox(),
              onPressed: () {
                task.complete();
                todo.handleTaskUpdateEvent();
              },
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              task.title,
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          IconButton(
            icon: getTrailingIcon(task),
            alignment: const Alignment(3.0 ,0),
            splashColor: Colors.transparent,
            onPressed: () {
              toggleImportantState(task);
              todo.handleTaskUpdateEvent();
            },
          ),
        ],
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo = context.watch<TodoModal>();

    return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            vertical: 0.0,
            horizontal: 20.0,
          ),
          itemCount: todo.incomplete.length,
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: todo.incomplete[index],
            child: const TodoItem(),
          ),
        ),
    );
  }
}

class NewTaskInput extends StatelessWidget {
  final textFieldController = TextEditingController();

  NewTaskInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var todo = context.watch<TodoModal>();

    return Container(
      color: Colors.black.withAlpha(179),
      height: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
              ),
              child: Container(),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0)
                )
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 12.0,
            ),
            child: TextField(
              autofocus: true,
              controller: textFieldController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.add,
                  size: 28.0,
                ),
                hintStyle: TextStyle(fontSize: 18.0),
                hintText: '新增任務',
                contentPadding: EdgeInsets.only(
                  top: 12.0,
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 18.0,
              ),
              onSubmitted: (String value) {
                if(value != '') {
                  final newTask = Task(value);
                  todo.add(newTask);
                }

                Navigator.pop(context);
              },
            ),
          ),
        ],
      )
    );
  }
}


class NewTaskButton extends StatelessWidget {
  const NewTaskButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 0.0,
                blurRadius: 2.6,
                offset: const Offset(1.95, 1.95), // changes position of shadow
              ),
            ],
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
            child: Row(
              children: const [
                Icon(
                  Icons.add,
                  size: 28.0,
                  color: Colors.blue,
                ),
                SizedBox(width: 4.0),
                Text(
                  '新增任務',
                  style: TextStyle(
                    fontSize: 18.0,
                  )
                ),
              ],
            ),
            onPressed: () {
              showBottomSheet(
                context: context,
                builder: (context) => NewTaskInput(),
              );
            }
          ),
        )
    );
  }
}