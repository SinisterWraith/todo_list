import 'package:hive_flutter/adapters.dart';

class TaskDatabase{

  // ToDo List array/list that was originally in the main.dart file
  List toDoList = [];

  //reference the box
  final box = Hive.box('thebox');

  // runn this method if this is the first time opening this app ever
  void creatInitalData(){
    toDoList = [
      ["Thank you for installing", true],
      ["Smile", true],  
    ];
  }

  // Loading data from the database
  void loadData(){
    toDoList = box.get("TODOLIST");
  }

  void updateDatabase(){
    box.put("TODOLIST", toDoList);
  }
}