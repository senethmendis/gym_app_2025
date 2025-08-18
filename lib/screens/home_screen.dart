import 'package:flutter/material.dart';
import 'package:gym_app/models/hero_images.dart';
import '../utils/database_helper.dart';
import 'add_workout.dart';
import 'workout_detail.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Map<String, dynamic>>>? _workoutsFuture;
  int _workoutReloadKey = 0;

  @override
  void initState() {
    super.initState();
    _workoutsFuture = DatabaseHelper.instance.queryAllWorkouts();
  }

  void _loadWorkouts() {
    setState(() {
      _workoutReloadKey++;
      _workoutsFuture = DatabaseHelper.instance.queryAllWorkouts();
    });
  }

  Future<void> _navigateToAddWorkout() async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const AddWorkoutScreen()));
    _loadWorkouts();
  }

  @override
  Widget build(BuildContext context) {
    Widget reloadButton = Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: _loadWorkouts,
        child: const Text('Reload Data'),
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 255, 7),
      body: Column(
        children: [
          SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 36, 36, 36),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add),
                        tooltip: 'Add',
                        onPressed: _navigateToAddWorkout,
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        tooltip: 'Refresh',
                        onPressed: _loadWorkouts,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          CarouselSlider(
            options: CarouselOptions(height: 200.0),
            items: heroImages.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 218, 255, 7),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(i.url),
                        fit: BoxFit.cover,
                      ),
                    ),

                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Chip(
                        backgroundColor: Color.fromARGB(255, 218, 255, 7),
                        label: Text(
                          '${i.title}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),

          SizedBox(height: 20),

          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _workoutsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [const CircularProgressIndicator(), reloadButton],
                  );
                } else if (snapshot.hasError) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('Error: ${snapshot.error}'), reloadButton],
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No workouts added yet.'),
                      reloadButton,
                    ],
                  );
                }
                final workouts = snapshot.data!;
                return RefreshIndicator(
                  onRefresh: () async {
                    _loadWorkouts();
                    await _workoutsFuture;
                  },
                  child: ListView.builder(
                    key: ValueKey(_workoutReloadKey),
                    itemCount: workouts.length,
                    itemBuilder: (context, index) {
                      final workout = workouts[index];
                      return Dismissible(
                        key: Key('workout_${workout['id']}'),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,

                          color: Colors.red,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        confirmDismiss: (direction) async {
                          return await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Workout'),
                              content: const Text(
                                'Are you sure you want to delete this workout?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          );
                        },
                        onDismissed: (direction) async {
                          await DatabaseHelper.instance.deleteWorkout(
                            workout['id'],
                          );
                          _loadWorkouts();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Workout deleted',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              backgroundColor: Color.fromARGB(255, 36, 36, 36),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 8,
                          ),
                          child: ListTile(
                            title: Text(workout['name'] ?? ''),
                            subtitle: Text(workout['date'] ?? ''),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Color.fromARGB(255, 36, 36, 36),
                                  ),
                                  tooltip: 'Edit',
                                  onPressed: () async {
                                    final result = await Navigator.of(context)
                                        .push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                WorkoutDetailScreen(
                                                  workout: workout,
                                                ),
                                          ),
                                        );
                                    if (result == true) _loadWorkouts();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
