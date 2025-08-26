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
  late List<TextEditingController> _repsControllers;
  late List<TextEditingController> _setsControllers;
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
    debugPrint('Loaded exercises:');
    for (var e in exercises) {
      debugPrint(e.toString());
    }
    _exerciseControllers = exercises
        .map((e) => TextEditingController(text: (e['name'] ?? '') as String))
        .toList();
    _repsControllers = exercises
        .map((e) => TextEditingController(text: (e['reps'] ?? '').toString()))
        .toList();
    _setsControllers = exercises
        .map((e) => TextEditingController(text: (e['sets'] ?? '').toString()))
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
        {
          'name': _exerciseControllers[i].text.trim(),
          'reps': _repsControllers[i].text.trim(),
          'sets': _setsControllers[i].text.trim(),
        },
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
    for (var c in _repsControllers) {
      c.dispose();
    }
    for (var c in _setsControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 218, 255, 7),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 218, 255, 7),
        elevation: 0,
        title: const Text(
          'Workout Details',
          style: TextStyle(
            color: Color(0xFF242424),
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          if (!_isEditMode)
            IconButton(
              icon: const Icon(Icons.edit, color: Color(0xFF242424)),
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
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: _isEditMode
                            ? TextField(
                                controller: _titleController,
                                decoration: InputDecoration(
                                  labelText: 'Workout Title',
                                  labelStyle: TextStyle(
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF242424),
                                ),
                              )
                            : Text(
                                _titleController.text.toUpperCase(),
                                style: const TextStyle(
                                  color: Color(0xFF242424),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.1,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'Exercises:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF242424),
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _exerciseControllers.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 1,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 14,
                            ),
                            child: _isEditMode
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextField(
                                        controller: _exerciseControllers[index],
                                        decoration: InputDecoration(
                                          labelText: 'Exercise ${index + 1}',
                                          labelStyle: TextStyle(
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.bold,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF242424),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller:
                                                  _repsControllers[index],
                                              decoration: const InputDecoration(
                                                labelText: 'Reps',
                                                border: OutlineInputBorder(),
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: TextField(
                                              controller:
                                                  _setsControllers[index],
                                              decoration: const InputDecoration(
                                                labelText: 'Sets',
                                                border: OutlineInputBorder(),
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _exerciseControllers[index].text,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF242424),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Text(
                                            'Reps: ${_repsControllers[index].text}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFF242424),
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Text(
                                            'Sets: ${_setsControllers[index].text}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFF242424),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    if (_isEditMode)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF242424),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: _saveWorkout,
                          child: const Text('Save Changes'),
                        ),
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
