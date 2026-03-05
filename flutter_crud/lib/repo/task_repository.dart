import '../database/database_helper.dart';
import '../models/task.dart';

class TaskRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<List<Task>> getTasks() async {
    final db = await dbHelper.database;

    final result = await db.query('tasks');

    return result.map((e) => Task.fromMap(e)).toList();
  }

  Future<int> insertTask(Task task) async {
    final db = await dbHelper.database;

    return await db.insert('tasks', task.toMap());
  }

  Future<int> updateTask(Task task) async {
    final db = await dbHelper.database;

    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await dbHelper.database;

    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
