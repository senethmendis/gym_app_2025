import 'package:flutter/material.dart';
import '../utils/database_helper.dart';

class MealPlanDetailScreen extends StatefulWidget {
  const MealPlanDetailScreen({super.key});

  @override
  State<MealPlanDetailScreen> createState() => _MealPlanDetailScreenState();
}

class _MealPlanDetailScreenState extends State<MealPlanDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dayController = TextEditingController();

  // Morning
  final TextEditingController _morningTitleController = TextEditingController();
  final TextEditingController _morningProteinController =
      TextEditingController();
  final TextEditingController _morningCarbsController = TextEditingController();
  final TextEditingController _morningFatController = TextEditingController();
  final TextEditingController _morningDescController = TextEditingController();

  // Lunch
  final TextEditingController _lunchTitleController = TextEditingController();
  final TextEditingController _lunchProteinController = TextEditingController();
  final TextEditingController _lunchCarbsController = TextEditingController();
  final TextEditingController _lunchFatController = TextEditingController();
  final TextEditingController _lunchDescController = TextEditingController();

  // Dinner
  final TextEditingController _dinnerTitleController = TextEditingController();
  final TextEditingController _dinnerProteinController =
      TextEditingController();
  final TextEditingController _dinnerCarbsController = TextEditingController();
  final TextEditingController _dinnerFatController = TextEditingController();
  final TextEditingController _dinnerDescController = TextEditingController();

  @override
  void dispose() {
    _dayController.dispose();
    _morningTitleController.dispose();
    _morningProteinController.dispose();
    _morningCarbsController.dispose();
    _morningFatController.dispose();
    _morningDescController.dispose();
    _lunchTitleController.dispose();
    _lunchProteinController.dispose();
    _lunchCarbsController.dispose();
    _lunchFatController.dispose();
    _lunchDescController.dispose();
    _dinnerTitleController.dispose();
    _dinnerProteinController.dispose();
    _dinnerCarbsController.dispose();
    _dinnerFatController.dispose();
    _dinnerDescController.dispose();
    super.dispose();
  }

  Future<void> _saveMealPlan() async {
    if (_formKey.currentState!.validate()) {
      final mealPlan = {
        'day': _dayController.text,
        'morning_title': _morningTitleController.text,
        'morning_protein': double.tryParse(_morningProteinController.text) ?? 0,
        'morning_carbs': double.tryParse(_morningCarbsController.text) ?? 0,
        'morning_fat': double.tryParse(_morningFatController.text) ?? 0,
        'morning_description': _morningDescController.text,
        'lunch_title': _lunchTitleController.text,
        'lunch_protein': double.tryParse(_lunchProteinController.text) ?? 0,
        'lunch_carbs': double.tryParse(_lunchCarbsController.text) ?? 0,
        'lunch_fat': double.tryParse(_lunchFatController.text) ?? 0,
        'lunch_description': _lunchDescController.text,
        'dinner_title': _dinnerTitleController.text,
        'dinner_protein': double.tryParse(_dinnerProteinController.text) ?? 0,
        'dinner_carbs': double.tryParse(_dinnerCarbsController.text) ?? 0,
        'dinner_fat': double.tryParse(_dinnerFatController.text) ?? 0,
        'dinner_description': _dinnerDescController.text,
      };
      await DatabaseHelper.instance.insertMealPlan(mealPlan);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Meal plan saved!')));
      Navigator.pop(context, true);
    }
  }

  Widget _mealSection({
    required String label,
    required TextEditingController titleController,
    required TextEditingController proteinController,
    required TextEditingController carbsController,
    required TextEditingController fatController,
    required TextEditingController descController,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Meal Title'),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Enter meal title' : null,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: proteinController,
                    decoration: const InputDecoration(labelText: 'Protein (g)'),
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Enter protein' : null,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: carbsController,
                    decoration: const InputDecoration(labelText: 'Carbs (g)'),
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Enter carbs' : null,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: fatController,
                    decoration: const InputDecoration(labelText: 'Fat (g)'),
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Enter fat' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 2,
              validator: (v) =>
                  v == null || v.isEmpty ? 'Enter description' : null,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Meal Plan'),
        backgroundColor: Color.fromARGB(255, 218, 255, 7),
      ),
      backgroundColor: Color.fromARGB(255, 218, 255, 7),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            TextFormField(
              controller: _dayController,
              decoration: const InputDecoration(labelText: 'Day (e.g. Monday)'),
              validator: (v) => v == null || v.isEmpty ? 'Enter day' : null,
            ),
            _mealSection(
              label: 'Morning',
              titleController: _morningTitleController,
              proteinController: _morningProteinController,
              carbsController: _morningCarbsController,
              fatController: _morningFatController,
              descController: _morningDescController,
            ),
            _mealSection(
              label: 'Lunch',
              titleController: _lunchTitleController,
              proteinController: _lunchProteinController,
              carbsController: _lunchCarbsController,
              fatController: _lunchFatController,
              descController: _lunchDescController,
            ),
            _mealSection(
              label: 'Dinner',
              titleController: _dinnerTitleController,
              proteinController: _dinnerProteinController,
              carbsController: _dinnerCarbsController,
              fatController: _dinnerFatController,
              descController: _dinnerDescController,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveMealPlan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 36, 36, 36),
                  foregroundColor: Color.fromARGB(255, 218, 255, 7),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Save Meal Plan',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
