// ignore_for_file: prefer_const_constructors, sort_child_properties_last, must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String TaskName;
  final bool TaskCompleted;
  Function (bool?)? onChanged;
  Function(BuildContext)? editTask;
  Function(BuildContext)? deleteTask;
  
  ToDoTile({
    super.key, 
    required this.TaskName,
    required this.TaskCompleted,
    required this.onChanged,
    required this.editTask,
    required this.deleteTask,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, top: 20),

        child: Slidable(
          startActionPane: ActionPane(motion: StretchMotion(), children: [
            SlidableAction(
              label: "Edit",
              onPressed: editTask,
              icon: Icons.edit,
              backgroundColor: Colors.blue,
              borderRadius: BorderRadius.circular(15),
              ),
          ]),


          endActionPane: ActionPane(motion: StretchMotion(), children: [
            SlidableAction(
              onPressed: deleteTask,
              label: "Delete",
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(15),
            ),
          ],
          
          ),
          
          child: Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
              
                //Checkbox
                Checkbox(
                  value: TaskCompleted, 
                  onChanged: onChanged,
                  activeColor: Colors.black,
                  ),
              
                //Name of task
                Text(
                  TaskName,
                  style: TextStyle(
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis,
                    // This is the enhanced if function to make the task strikethrough after completing them
                    decoration: TaskCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                    ),
                  ),
              ],
            ),

            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(12)
            ),
          ),

        ),
      );
}}