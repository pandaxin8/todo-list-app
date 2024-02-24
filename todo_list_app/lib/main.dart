// main.dart
import 'package:flutter/material.dart';
import 'package:todo_list_app/task_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List App',
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<Task> tasks = [];
  TextEditingController taskController = TextEditingController();

  void addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        tasks.add(Task(id: tasks.length + 1, title: taskController.text));
        taskController.clear();
      });
    }
  }

  void removeTask(int taskId) {
    setState(() {
      tasks.removeWhere((task) => task.id == taskId);
    });
  }

  void toggleTaskCompletion(int taskId) {
    setState(() {
      tasks.firstWhere((task) => task.id == taskId).isCompleted =
          !tasks.firstWhere((task) => task.id == taskId).isCompleted;
    });
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Column(
        children: [
          TextField(
            controller: taskController,
            decoration: InputDecoration(
              labelText: 'New Task',
            ),
          ),
          ElevatedButton(
            onPressed: addTask,
            child: Text('Add Task'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index].title),
                  leading: Checkbox(
                    value: tasks[index].isCompleted,
                    onChanged: (_) => toggleTaskCompletion(tasks[index].id),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => removeTask(tasks[index].id),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
}