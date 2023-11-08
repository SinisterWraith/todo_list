// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_list/components/edit_alert.dart';
import 'package:todo_list/data/database.dart';
import './components/dialog_box.dart';
import './components/todo_tile.dart';

void main() async {
  // Initialazing the hive
  await Hive.initFlutter();

  // Opening a box that's basically the start of a database
  var box = await Hive.openBox('theBox');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Content(),
    theme: ThemeData(primaryColor: Colors.yellow),
  ));
}

// Making a stateful widget becasue we need items in the app to change
class Content extends StatefulWidget {
  Content({super.key});
  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  //List of todo items that's in the database file now
  TaskDatabase db = TaskDatabase();

  // Reference to the hive box
  final thebox = Hive.box("theBox");

  // Setting up for the first run
  @override
  void initState() {
    if (thebox.get("TODOLIST") == null) {
      db.creatInitalData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  // Initializing the controller to get user text input from the dialog box
  final theController = TextEditingController();

  // Method to add new tasks
  void saveNewTasks() {
    setState(() {
      db.toDoList.add([theController.text, false]);
      theController.text = "";
      Navigator.of(context).pop();
    });

    db.updateDatabase();
  }

  // Method to delete old task
  void deleteTheTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });

    db.updateDatabase();
  }

  // Method to edit tasks
  void editTasks(int index) {
    // This easy method confirms the edits made to a task
    void confirmEdit() {
      setState(() {
        db.toDoList[index][0] = theController.text;
        db.toDoList[index][1] = false;

        theController.text = "";

        Navigator.of(context).pop();
      });
    }

    showDialog(
        context: context,
        builder: (context) {
          return EditAlert(
            ctrl: theController,
            onConfirm: confirmEdit,
            onCancel: clearText,
          );
        });

    db.updateDatabase();
  }

  // Method to clear text from the text area
  void clearText() {
    setState(() {
      theController.text = "";
      Navigator.of(context).pop();
    });
  }

  // Checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });

    db.updateDatabase();
  }

  // Method to create a new task with the floating action button
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            ctrl: theController,
            onSave: saveNewTasks,
            onCancel: clearText,
          );
        });

    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "To Do",
          style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontFamily: 'Josefin',
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: ListView.builder(
        //Items
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            TaskName: db.toDoList[index][0],
            TaskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteTask: (context) => deleteTheTask(index),
            editTask: (context) => editTasks(index),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
          onPressed: () {
            createNewTask();
          },
          backgroundColor: Colors.orange,
          child: Icon(
            Icons.add,
            color: Colors.black,
          )),
    );
  }
}