import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../components/Components.dart';
import 'Task.dart';
import '../Data/Data.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mybox = Hive.box('MyBox');
  ToDoDataBase db = ToDoDataBase();
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

  checkBoxFunc(int index) {
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
    Navigator.of(context).pop();
  }

  void cancelFunc() {
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey,
            actions: [
              Column(
                children: [
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                        hintText: 'TYPE THE NAME OF THE TASK HERE'),
                  ),
                  Row(
                    children: [
                      CustomMaterialButton(saveFunc, 'save'),
                      CustomMaterialButton(cancelFunc, 'cancel')
                    ],
                  )
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[700],
        floatingActionButton: FloatingActionButton(
            onPressed: createNewTask,
            backgroundColor: Colors.amber,
            child: const Icon(Icons.add)),
        appBar: AppBar(
          title: const Text('ToDo',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
        ),
  body:Center(
    child: SizedBox(
      height: 1000,
      child: CarouselSlider(    
      
                items: 
                    db.data.map(				
                      (e) => 
                      Task(
                      checkbox: e[1],
                      index: db.data.indexOf(e),
                      taskName: e[0],
                      onChanged: (_) => checkBoxFunc(db.data.indexOf(e)),
                      deleteFunc: (context) => deleteTask(db.data.indexOf(e))
                    ))
                    .toList(),
                options: CarouselOptions(initialPage: 0,scrollDirection: Axis.vertical,enableInfiniteScroll: false),
              ),
    ),
  ), 
    );
  }}

//         body: ListView.builder(
//             itemCount: db.data.length,
//             itemBuilder: (context, index) => Task(
//                   checkbox: db.data[index][1],
//                   index: index,
//                   taskName: db.data[index][0],
//                   onChanged: (_) => checkBoxFunc(index),
//                   deleteFunc: (context) => deleteTask(index),
//                 )));
//   }
// }
