import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  final _mybox = Hive.box('mybox');
  List data = [];

  void initialData_tutorial() {
    data = [
      ['Tutorial', false]
    ];
  }

  void loadData() {
    data = _mybox.get("todolist");
  }

  void updateData() {
    _mybox.put("todolist", data);
  }
}
