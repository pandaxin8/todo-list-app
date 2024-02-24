// task_model.dart

class Task {
  final int id;
  final String title;
  bool isCompleted;
  bool isImportant = false;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });
}