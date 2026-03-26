import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TodoListPage(),
    );
  }
}

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 背景を白にして清潔感を出す
      appBar: _buildCustomAppBar(),
      body: ListView(
        padding: const EdgeInsets.only(
          top: 50,
          left: 25,
          right: 25,
        ),
        children: [
          // デザインを確認するためにいくつか並べてみる
          _buildTodoItem('課題', '10:00', 'Flutterのレイアウトを完成させる'),
          _buildTodoItem('買い物', '13:00', '駅前のスーパーで食材を買う'),
          _buildTodoItem('散歩', '16:00', '近所の公園を一周する'),
          _buildTodoItem('読書', '21:00', '技術書を15ページ読む'),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildCustomAppBar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 237, 252, 255),
      elevation: 1,
      shadowColor: const Color.fromARGB(255, 0, 0, 0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildDateSection(),
          _buildWeatherSection(),
        ],
      ),
    );
  }

  Widget _buildDateSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          '2026年',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 0, 145, 218),
          ),
        ),
        Text(
          '3月26日(木)',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 0, 145, 218),
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherSection() {
    return Row(
      children: const [
        Icon(Icons.wb_sunny, color: Colors.orange, size: 22),
        SizedBox(width: 4),
        Text(
          '晴れ',
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }

  // --- 今回作ったTodo1行分のパーツ ---
  Widget _buildTodoItem(String title, String time, String content) {
    return Card(
      margin: const EdgeInsets.only(
        left: 0,
        top: 50,
        bottom: 0,
        right: 0,
      ),
      elevation: 5,

      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color.fromARGB(255, 204, 123, 2),
          width: 1.5,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(19), // 左上
          bottomLeft: Radius.circular(25), // 左下
          topRight: Radius.circular(25),
          bottomRight: Radius.circular(19),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 55, 218, 0),
                ),
              ),
            ),
            SizedBox(
              width: 60,
              child: Text(
                time,
                style: const TextStyle(
                  color: Color.fromARGB(192, 0, 0, 0),
                  fontSize: 13,
                ),
              ),
            ),
            Expanded(child: Text(content)),
          ],
        ),
      ),
    );
  }
}
