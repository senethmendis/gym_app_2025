import 'package:flutter/material.dart';
import '../utils/database_helper.dart';

class WorkoutDetailScreen extends StatefulWidget {
  final Map<String, dynamic> workout;
  const WorkoutDetailScreen({super.key, required this.workout});

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  late TextEditingController _titleController;
  late List<TextEditingController> _exerciseControllers;
  late List<Map<String, dynamic>> _exercisesMeta;
  bool _isLoading = true;
  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.workout['name'] ?? '',
    );
    _loadExercises();
  }

  Future<void> _loadExercises() async {
    final db = await DatabaseHelper.instance.database;
    final exercises = await db.query(
      'exercises',
      where: 'workout_id = ?',
      whereArgs: [widget.workout['id']],
    );
    _exerciseControllers = exercises
        .map((e) => TextEditingController(text: (e['name'] ?? '') as String))
        .toList();
    _exercisesMeta = exercises;
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveWorkout() async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'workouts',
      {'name': _titleController.text.trim()},
      where: 'id = ?',
      whereArgs: [widget.workout['id']],
    );
    // Save exercises
    for (int i = 0; i < _exerciseControllers.length; i++) {
      final exerciseId = _exercisesMeta[i]['id'];
      await db.update(
        'exercises',
        {'name': _exerciseControllers[i].text.trim()},
        where: 'id = ?',
        whereArgs: [exerciseId],
      );
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Workout updated!')));
    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    _titleController.dispose();
    for (var c in _exerciseControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 255, 7),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 218, 255, 7),
        title: const Text(
          'Workout Details',
          style: TextStyle(
            color: Color.fromARGB(255, 36, 36, 36),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (!_isEditMode)
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Color.fromARGB(255, 36, 36, 36),
              ),
              tooltip: 'Edit',
              onPressed: () {
                setState(() {
                  _isEditMode = true;
                });
              },
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _isEditMode
                      ? TextField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            labelText: 'Workout Title',
                            border: OutlineInputBorder(),
                          ),
                        )
                      : Text(
                          _titleController.text.toUpperCase(),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 36, 36, 36),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  const SizedBox(height: 24),
                  const Text(
                    'Exercises:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 36, 36, 36),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _exerciseControllers.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: _isEditMode
                              ? TextField(
                                  controller: _exerciseControllers[index],
                                  decoration: InputDecoration(
                                    labelText: 'Exercise ${index + 1}',
                                    border: const OutlineInputBorder(),
                                  ),
                                )
                              : Text(
                                  _exerciseControllers[index].text,
                                  style: const TextStyle(fontSize: 18),
                                ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_isEditMode)
                    ElevatedButton(
                      onPressed: _saveWorkout,
                      child: const Text('Save Changes'),
                    ),
                ],
              ),
            ),
    );
  }
}
