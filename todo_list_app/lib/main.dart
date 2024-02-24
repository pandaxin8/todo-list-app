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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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

  void toggleTaskImportance(int taskId) {
    setState(() {
      tasks.firstWhere((task) => task.id == taskId).isImportant =
          !tasks.firstWhere((task) => task.id == taskId).isImportant;
    });
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text('To-Do List'),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20.0), // add some space at top

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: 'New Task',
              ),
              style: TextStyle(fontFamily: 'RobotoMono', fontSize: 20.0),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => addTask(), // call addTask() when Enter is pressed
            ),
          ),
          // TextField(
          //   controller: taskController,
          //   decoration: InputDecoration(
          //     labelText: 'New Task',
          //   ),
          //   style: TextStyle(fontFamily: 'RobotoMono', fontSize: 20.0),
          //   textInputAction: TextInputAction.done,
          // ),
          SizedBox(height: 10.0), // add some space between text field and button
          ElevatedButton(
            onPressed: addTask,
            child: Text('Add Task'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index].title,
                  style: TextStyle(fontFamily: 'SourceSansPro')),
                  leading: Checkbox(
                    value: tasks[index].isCompleted,
                    onChanged: (_) => toggleTaskCompletion(tasks[index].id),
                  ),
                  // trailing: IconButton(
                  //   icon: Icon(Icons.delete),
                  //   onPressed: () => removeTask(tasks[index].id),
                  // ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min, // Compact trailing icons
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => removeTask(tasks[index].id),
                      ),
                      IconButton(
                        icon: Icon(Icons.star,
                          color: tasks[index].isImportant
                              ? Colors.amber
                              : Colors.grey[600],
                        ), // Add star icon for important tasks
                        onPressed: () => toggleTaskImportance(tasks[index].id),
                      )
                    ]
                  )
                );
              },
            ),
          ),
          SizedBox(height: 10.0),
        ],
      ),
      backgroundColor: Colors.grey[200], // Light grey background
    );
  }
  
}