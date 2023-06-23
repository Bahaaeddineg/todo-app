import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'Task.dart';
import '../Data/Data.dart';

final _mybox = Hive.box('MyBox');
ToDoDataBase db = ToDoDataBase();

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (_mybox.get("todolist") == null) {
      db.initialData_tutorial();
    } else {
      db.loadData();
    }
  }

  void checkBoxFunc(int index) {
    setState(() {
      db.data[index][1] = !db.data[index][1];
    });
  }

  void deleteTask(int index) {
    setState(() {
      db.data.removeAt(index);
    });
    db.updateData();
  }

  void saveFunc() {
    setState(() {
      db.data.add([_controller.text, false]);
      _controller.clear();
    });
    db.updateData();
  }

  void cancelFunc() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.menu),
              Text('Your tasks',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              CircleAvatar(
                  child: Image(
                image: AssetImage(''),
              )),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        const Text("Your tasks",
                            style:
                                TextStyle(fontSize: 30, color: Colors.white)),
                        ...db.data
                            .map((e) => Task(
                                  checkbox: db.data[db.data.indexOf(e)][1],
                                  index: db.data.indexOf(e),
                                  taskName: db.data[db.data.indexOf(e)][0],
                                  onChanged: (_) =>
                                      checkBoxFunc(db.data.indexOf(e)),
                                  deleteFunc: (context) =>
                                      deleteTask(db.data.indexOf(e)),
                                ))
                            .toList(),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurStyle: BlurStyle.inner,
                            color: Colors.white,
                            offset: Offset(-5, 0),
                            blurRadius: 3,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                              hintText: "Add a new task",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.task,
                                color: Colors.black,
                              ))),
                    ),
                  ),
                  InkWell(
                    onTap: () => saveFunc(),
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }

  Container searchBox() {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: const TextField(
          decoration: InputDecoration(
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ))),
    );
  }
}