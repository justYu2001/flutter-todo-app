import 'package:flutter/material.dart';

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
          ],
        ),
      )
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
