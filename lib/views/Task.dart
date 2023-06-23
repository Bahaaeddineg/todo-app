import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import 'home.dart';

class Task extends StatefulWidget {
  final int index;
  final String taskName;
  final bool checkbox;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunc;
  Task(
      {required this.index,
      required this.taskName,
      required this.onChanged,
      required this.deleteFunc,
      required this.checkbox});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
              flex: 1,
              foregroundColor: Colors.white,
              backgroundColor: Colors.transparent,
              icon: Icons.delete,
              label: 'Delete Task',
              onPressed: widget.deleteFunc),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: size.height * .1,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Colors.grey[900], borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RoundCheckBox(
                onTap: widget.onChanged,
                isChecked: widget.checkbox,
                size: 30,
                animationDuration: const Duration(seconds: 1),
                uncheckedColor: Colors.white,
                borderColor: Colors.black),
            SizedBox(
              width: size.height * .01,
            ),
            Text(
              widget.taskName,
              style: TextStyle(
                  decoration: widget.checkbox
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: Colors.white,
                  fontSize: widget.taskName.length < 25 ? 20 : 13,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
