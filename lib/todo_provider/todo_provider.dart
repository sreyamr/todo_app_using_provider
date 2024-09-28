import 'package:flutter/cupertino.dart';
import 'package:todo_using_provider/models/todo.dart';

class TodoProvider with ChangeNotifier {
  List<TodoModel> _todo = [];
  List<TodoModel> get todos => _todo;

  void addTodo(String title, String subTitle) {
    _todo.add(TodoModel(title: title, subTitle: subTitle));
    notifyListeners();
  }

  void removeTodo(int index){
    _todo.removeAt(index);
    notifyListeners();
  }

  void updateTodo(int index,String newTitle, String newSubTitle){
    _todo[index] = TodoModel(title: newTitle, subTitle: newSubTitle);
    notifyListeners();
  }
}
