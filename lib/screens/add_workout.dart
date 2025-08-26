import 'package:flutter/material.dart';
import '../utils/database_helper.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({super.key});

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final List<TextEditingController> _exerciseControllers = [
    TextEditingController(),
  ];
  final List<TextEditingController> _repsControllers = [
    TextEditingController(),
  ];
  final List<TextEditingController> _setsControllers = [
    TextEditingController(),
  ];

  @override
  void dispose() {
    _titleController.dispose();
    for (var controller in _exerciseControllers) {
      controller.dispose();
    }
    for (var controller in _repsControllers) {
      controller.dispose();
    }
    for (var controller in _setsControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addExerciseField() {
    setState(() {
      _exerciseControllers.add(TextEditingController());
      _repsControllers.add(TextEditingController());
      _setsControllers.add(TextEditingController());
    });
  }

  void _removeExerciseField(int index) {
    setState(() {
      if (_exerciseControllers.length > 1) {
        _exerciseControllers[index].dispose();
        _repsControllers[index].dispose();
        _setsControllers[index].dispose();
        _exerciseControllers.removeAt(index);
        _repsControllers.removeAt(index);
        _setsControllers.removeAt(index);
      }
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      final workoutId = await DatabaseHelper.instance.insertWorkout({
        'name': title,
        'date': DateTime.now().toIso8601String(),
      });

      int exerciseCount = 0;
      for (int i = 0; i < _exerciseControllers.length; i++) {
        final name = _exerciseControllers[i].text.trim();
        final reps = _repsControllers[i].text.trim();
        final sets = _setsControllers[i].text.trim();
        if (name.isNotEmpty && reps.isNotEmpty && sets.isNotEmpty) {
          exerciseCount++;
          await DatabaseHelper.instance.database.then((db) {
            db.insert('exercises', {
              'workout_id': workoutId,
              'name': name,
              'reps': reps,
              'sets': sets,
            });
          });
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Workout "$title" with $exerciseCount exercises added!',
          ),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 255, 7),
      appBar: AppBar(
        title: const Text(
          'Add Workout',
          style: TextStyle(
            color: Color.fromARGB(255, 36, 36, 36),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 218, 255, 7),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Workout Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Please enter a workout title'
                    : null,
              ),
              const SizedBox(height: 24),
              const Text(
                'Exercises:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ..._exerciseControllers.asMap().entries.map((entry) {
                int idx = entry.key;
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: entry.value,
                                decoration: InputDecoration(
                                  labelText: 'Exercise ${idx + 1}',
                                  border: const OutlineInputBorder(),
                                ),
                                validator: (value) =>
                                    value == null || value.trim().isEmpty
                                    ? 'Enter exercise name'
                                    : null,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                              onPressed: () => _removeExerciseField(idx),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _repsControllers[idx],
                                decoration: const InputDecoration(
                                  labelText: 'Reps',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) =>
                                    value == null || value.trim().isEmpty
                                    ? 'Enter reps'
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: _setsControllers[idx],
                                decoration: const InputDecoration(
                                  labelText: 'Sets',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) =>
                                    value == null || value.trim().isEmpty
                                    ? 'Enter sets'
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
              TextButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add Exercise'),
                onPressed: _addExerciseField,
              ),
              const SizedBox(height: 24),
              OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Color.fromARGB(255, 36, 36, 36),
                  ),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 16),
                  ),
                  textStyle: WidgetStateProperty.all(
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                onPressed: _submitForm,
                child: const Text('Save Workout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
