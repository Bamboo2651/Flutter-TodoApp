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
      // 自作したAppBarパーツを呼び出す
      appBar: _buildCustomAppBar(),
      body: const Center(
        child: Text('ここにTodoリストが入る予定です'),
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
            fontWeight: FontWeight(600),
            color: Color.fromARGB(255, 0, 145, 218),
          ),
        ),
        Text(
          '3月26日(木)',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight(600),
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
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
