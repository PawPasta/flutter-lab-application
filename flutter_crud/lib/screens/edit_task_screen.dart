import 'package:flutter/material.dart';

class EditTaskScreen extends StatefulWidget {
  final String initialTitle;

  const EditTaskScreen({super.key, required this.initialTitle});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialTitle);
  }

  void confirmUpdate() {
    final updatedTitle = controller.text.trim();
    if (updatedTitle.isEmpty) return;
    Navigator.pop(context, updatedTitle);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Enter new task title',
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: confirmUpdate,
                child: const Text('Confirm'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
