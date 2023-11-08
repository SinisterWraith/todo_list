// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, prefer_const_constructors_in_immutables, must_be_immutable, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:todo_list/components/buttons.dart';

class DialogBox extends StatelessWidget {
  final ctrl;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({super.key, required this.ctrl, required this.onSave, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
        
        height: 120,

        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            //Getting user input
            TextField(

              controller: ctrl,

              decoration: InputDecoration
                (
                  border: OutlineInputBorder(),
                  hintText: "Enter a new task",
                  prefixIcon: Icon(Icons.add),
                ),
            ),

            SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Save Button
                 SomeButtons(text: "Save", onPressed: onSave),

                // Cancel Button
                 SomeButtons(text: "Cancel", onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}