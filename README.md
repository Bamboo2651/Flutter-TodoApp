# Flutter Todo App

Flutter入門後の最初の自作アプリ。学習記録として制作。

---

## 機能

- Todoの一覧表示
- Todoの追加（タイトル・時間・内容）
- Todoの削除（左スワイプ）
- 完了チェック（タップで取り消し線）

---

## 使用技術

- Flutter / Dart
- StatefulWidget + setState による状態管理

---

## 学んだこと

### クラスとインスタンス
データの設計図をクラスで定義し、実際のデータをインスタンスとして生成する考え方を学んだ。

```dart
class Todo {
  final String title;
  final String time;
  final String content;

  const Todo({required this.title, required this.time, required this.content});
}
```

### データとUIの分離
TodoデータをListで管理し、`.map()` でUIに変換するパターンを学んだ。直接ウィジェットにデータを埋め込む書き方から脱却できた。

```dart
children: todos.map((todo) {
  return _buildTodoItem(todo.title, todo.time, todo.content);
}).toList(),
```

### StatefulWidget への変換
画面の状態が変わる場合は `StatefulWidget` と `State` クラスの2つに分ける必要があることを学んだ。

### setState
データを変更したあとに `setState()` を呼ぶことで画面が再描画される仕組みを理解した。

```dart
setState(() {
  todos = [...todos, newTodo];
});
```

### TextEditingController
テキストフィールドの入力値を取得・クリアするための仕組みを学んだ。

### Dismissible（スワイプ削除）
`Dismissible` ウィジェットでカードを左スワイプしたときに削除する機能を実装した。`where()` を使って削除対象以外のTodoだけ残す方法を学んだ。

```dart
Dismissible(
  key: Key(todo.title),
  direction: DismissDirection.endToStart,
  onDismissed: (direction) {
    setState(() {
      todos = todos.where((t) => t != todo).toList();
    });
  },
  child: ...,
)
```

### GestureDetector と三項演算子（完了チェック）
`GestureDetector` でタップを検知し、`isDone` フラグを反転させることで完了状態を切り替えた。三項演算子でUIを動的に変える方法も学んだ。

```dart
// isDoneがtrueなら取り消し線、falseなら通常表示
decoration: isDone ? TextDecoration.lineThrough : null,
```

---

## 今後追加したい機能

- [x] Todoの削除
- [x] 完了チェック機能
- [ ] データの永続化（端末を閉じても消えないように）
- [ ] 日付・天気の動的取得