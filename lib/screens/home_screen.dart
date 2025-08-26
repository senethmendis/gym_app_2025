import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/models/hero_images.dart';
import 'package:gym_app/screens/meal_plan_detail_screen.dart';
import '../utils/database_helper.dart';
import 'add_workout.dart';
import 'workout_detail.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Map<String, dynamic>>>? _workoutsFuture;
  Future<List<Map<String, dynamic>>>? _mealPlansFuture;
  int _workoutReloadKey = 0;
  final int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _workoutsFuture = DatabaseHelper.instance.queryAllWorkouts();
    _mealPlansFuture = DatabaseHelper.instance.queryAllMealPlans();
  }

  void _loadWorkouts() {
    setState(() {
      _workoutReloadKey++;
      _workoutsFuture = DatabaseHelper.instance.queryAllWorkouts();
    });
  }

  void _loadMealPlans() {
    setState(() {
      _mealPlansFuture = DatabaseHelper.instance.queryAllMealPlans();
    });
  }

  Future<void> _navigateToAddWorkout() async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const AddWorkoutScreen()));
    _loadWorkouts();
  }

  Future<void> _navigateToMealPlanList() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const MealPlanDetailScreen()),
    );
    _loadMealPlans();
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

    return DefaultTabController(
      length: 2,
      initialIndex: _selectedTabIndex,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 218, 255, 7),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 218, 255, 7),
          title: const Text(
            'Workout and Meal Plan',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          bottom: const TabBar(
            indicatorColor: Color.fromARGB(255, 36, 36, 36),
            labelColor: Color.fromARGB(255, 36, 36, 36),
            unselectedLabelColor: Color.fromARGB(255, 197, 197, 197),
            tabs: [
              Tab(icon: Icon(Icons.fitness_center), text: 'Workouts'),
              Tab(icon: Icon(Icons.restaurant_menu), text: 'Meal Plans'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            /// -------------------- Workouts Tab --------------------
            Column(
              children: [
                const SizedBox(height: 20),

                /// Hero Images Carousel
                CarouselSlider(
                  options: CarouselOptions(
                    height: 150.0,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 2),
                  ),
                  items: heroImages.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 218, 255, 7),
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(i.url),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Image(image: AssetImage(i.url)),
                        );
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                /// Exercise Tutorials Section
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Exercise Tutorials',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                CarouselSlider(
                  options: CarouselOptions(height: 100.0),
                  items: List.generate(exersiceTutorials.length, (index) {
                    final i = exersiceTutorials[index];
                    return Builder(
                      builder: (BuildContext context) {
                        return InkWell(
                          onTap: () async {
                            if (i.video != null && i.video!.isNotEmpty) {
                              await launchUrlString(i.video!);
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 26, 26, 26),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                  Color.fromRGBO(
                                    0,
                                    0,
                                    0,
                                    0.5,
                                  ), // or any color you want
                                  BlendMode.darken,
                                ),
                                opacity: 0.5,
                                image: AssetImage(i.url),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (i.description != null &&
                                      i.description!.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        i.title ?? '',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                            221,
                                            255,
                                            255,
                                            255,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),

                /// Workouts List
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 16.0,
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'List of Workouts',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _navigateToAddWorkout,
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: _workoutsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(),
                              reloadButton,
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Error: ${snapshot.error}'),
                              reloadButton,
                              Text(
                                'Debug: ${snapshot.error}',
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('No workouts added yet.'),
                              reloadButton,
                            ],
                          ),
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
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
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
                                        onPressed: () =>
                                            Navigator.pop(context, true),
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
                                  const SnackBar(
                                    content: Text(
                                      'Workout deleted',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Color.fromARGB(
                                      255,
                                      36,
                                      36,
                                      36,
                                    ),
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
                                          color: Color.fromARGB(
                                            255,
                                            36,
                                            36,
                                            36,
                                          ),
                                        ),
                                        tooltip: 'Edit',
                                        onPressed: () async {
                                          final result =
                                              await Navigator.of(context).push(
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

            /// -------------------- Meal Plans Tab --------------------
            Column(
              children: [
                const SizedBox(height: 20),

                /// Meal Hero Carousel
                CarouselSlider(
                  options: CarouselOptions(height: 200.0),
                  items: healthyMeals.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 218, 255, 7),
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(i.url),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Chip(
                              backgroundColor: const Color.fromARGB(
                                255,
                                218,
                                255,
                                7,
                              ),
                              label: Text(
                                i.title ?? "",
                                style: const TextStyle(
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

                /// Meal Plans List
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 16.0,
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'List of Meal Plans',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _navigateToMealPlanList,
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: _mealPlansFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('No meal plans added yet.'),
                        );
                      }
                      final mealPlans = snapshot.data!;
                      return ListView.builder(
                        itemCount: mealPlans.length,
                        itemBuilder: (context, index) {
                          final meal = mealPlans[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            child: ListTile(
                              title: Text(
                                meal['day'] ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Morning: ${meal['morning_title']}'),
                                  Text('Lunch: ${meal['lunch_title']}'),
                                  Text('Dinner: ${meal['dinner_title']}'),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () async {
                                      await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const MealPlanDetailScreen(),
                                        ),
                                      );
                                      _loadMealPlans();
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      await DatabaseHelper.instance
                                          .deleteMealPlan(meal['id']);
                                      _loadMealPlans();
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Meal plan deleted'),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(meal['day'] ?? ''),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Morning: ${meal['morning_title']}',
                                          ),
                                          Text(
                                            'Protein: ${meal['morning_protein']}g, Carbs: ${meal['morning_carbs']}g, Fat: ${meal['morning_fat']}g',
                                          ),
                                          Text(
                                            'Description: ${meal['morning_description']}',
                                          ),
                                          const SizedBox(height: 8),
                                          Text('Lunch: ${meal['lunch_title']}'),
                                          Text(
                                            'Protein: ${meal['lunch_protein']}g, Carbs: ${meal['lunch_carbs']}g, Fat: ${meal['lunch_fat']}g',
                                          ),
                                          Text(
                                            'Description: ${meal['lunch_description']}',
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Dinner: ${meal['dinner_title']}',
                                          ),
                                          Text(
                                            'Protein: ${meal['dinner_protein']}g, Carbs: ${meal['dinner_carbs']}g, Fat: ${meal['dinner_fat']}g',
                                          ),
                                          Text(
                                            'Description: ${meal['dinner_description']}',
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
