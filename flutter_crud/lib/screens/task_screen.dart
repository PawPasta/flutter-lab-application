import 'package:flutter/material.dart';
import '../screens/edit_task_screen.dart';
import '../models/task.dart';
import '../repo/task_repository.dart';
import '../widgets/task_item.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final repo = TaskRepository();

  List<Task> tasks = [];

  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() async {
    final data = await repo.getTasks();

    setState(() {
      tasks = data;
    });
  }

  void addTask() async {
    if (controller.text.isEmpty) return;

    await repo.insertTask(Task(title: controller.text));

    controller.clear();

    loadTasks();
  }

  void deleteTask(int id) async {
    await repo.deleteTask(id);

    loadTasks();
  }

  Future<void> editTask(Task task) async {
    final updatedTitle = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => EditTaskScreen(initialTitle: task.title),
      ),
    );

    if (updatedTitle == null) return;

    await repo.updateTask(Task(id: task.id, title: updatedTitle));
    loadTasks();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task Manager")),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(hintText: "Enter task"),
                  ),
                ),

                IconButton(icon: const Icon(Icons.add), onPressed: addTask),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];

                return TaskItem(
                  task: task,
                  onDelete: () => deleteTask(task.id!),
                  onEdit: () => editTask(task),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
