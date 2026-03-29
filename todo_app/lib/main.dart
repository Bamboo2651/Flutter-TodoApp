import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Todo {
  final String title;
  final String time;
  final String content;
  final bool isDone;

  const Todo({
    required this.title,
    required this.time,
    required this.content,
    this.isDone = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'time': time,
      'content': content,
      'isDone': isDone,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'],
      time: json['time'],
      content: json['content'],
      isDone: json['isDone'] ?? false,
    );
  }
}

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

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('todos');
    print('読み込んだjson : $jsonString');
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      setState(() {
        todos = jsonList.map((j) => Todo.fromJson(j)).toList();
      });
    }
  }

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = jsonEncode(todos.map((t) => t.toJson()).toList());
    print('保存するjsonString: $jsonString');
    await prefs.setString('todos', jsonString);
  }

  List<Todo> todos = const [
    // Todo(title: '課題', time: '10:00', content: 'Flutterのレイアウトを完成させる'),
    // Todo(title: '買い物', time: '13:00', content: '駅前のスーパーで食材を買う'),
    // Todo(title: '散歩', time: '16:00', content: '近所の公園を一周する'),
    // Todo(title: '読書', time: '21:00', content: '技術書を15ページ読む'),
  ];
  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildCustomAppBar(),
      body: ListView(
        padding: const EdgeInsets.only(
          top: 10,
          left: 50,
          right: 50,
        ),
        children: todos.map((todo) {
          return Dismissible(
            key: Key(todo.title),
            direction: DismissDirection.horizontal,
            onDismissed: (direction) {
              setState(() {
                todos = todos.where((t) => t != todo).toList();
              });
              _saveTodos();
            },
            child: GestureDetector(
              onTap: () {
                setState(() {
                  todos = todos.map((t) {
                    if (t == todo) {
                      return Todo(
                        title: t.title,
                        time: t.time,
                        content: t.content,
                        isDone: !t.isDone, // trueならfalse、falseならtrueに反転
                      );
                    }
                    return t;
                  }).toList();
                });
                _saveTodos();
              },
              child: _buildTodoItem(
                todo.title,
                todo.time,
                todo.content,
                todo.isDone,
              ),
            ),
          );
        }).toList(),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTodo();
        },
        child: const Icon(Icons.add),
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

  void _addTodo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Todoを追加'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'タイトル'),
              ),
              TextField(
                controller: _timeController,
                decoration: const InputDecoration(labelText: '時間（例: 10:00）'),
              ),
              TextField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: '内容'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  todos = [
                    ...todos,
                    Todo(
                      title: _titleController.text,
                      time: _timeController.text,
                      content: _contentController.text,
                    ),
                  ];
                });
                _saveTodos();
                _titleController.clear();
                _timeController.clear();
                _contentController.clear();
                Navigator.pop(context);
              },
              child: const Text('追加'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTodoItem(
    String title,
    String time,
    String content,
    bool isDone,
  ) {
    return Card(
      margin: const EdgeInsets.only(
        left: 0,
        top: 10,
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
          topLeft: Radius.circular(19),
          bottomLeft: Radius.circular(25),
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
            Expanded(
              child: Text(
                content,
                style: TextStyle(
                  decoration: isDone ? TextDecoration.lineThrough : null,
                  color: isDone ? Colors.grey : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
