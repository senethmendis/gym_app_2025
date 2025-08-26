class HeroImage {
  final String url;
  final String? title;
  final String? description;
  final String? video;

  const HeroImage({
    required this.url,
    this.title,
    this.description,
    this.video,
  });
}

const List<HeroImage> heroImages = [
  HeroImage(
    url: 'assets/images/1.png',
    title: 'Strength Training',
    description: 'A person lifting weights in the gym.',
  ),
  HeroImage(
    url: 'assets/images/2.jpg',
    title: 'Cardio Session',
    description: 'Running on a treadmill.',
  ),
  HeroImage(
    url: 'assets/images/3.jpg',
    title: 'Yoga Practice',
    description: 'Yoga mat and stretching.',
  ),
  HeroImage(
    url: 'assets/images/4.jpg',
    title: 'Outdoor Workout',
    description: 'Exercising in nature.',
  ),
  HeroImage(
    url: 'assets/images/5.jpg',
    title: 'Team Training',
    description: 'Group fitness session.',
  ),
];

const List<HeroImage> healthyMeals = [
  HeroImage(
    url: 'assets/images/5.jpg',
    title: 'Protein Breakfast',
    description: 'Eggs, avocado, and whole grain toast for a healthy start.',
  ),
  HeroImage(
    url: 'assets/images/5.jpg',
    title: 'Fresh Salad Lunch',
    description: 'Mixed greens, grilled chicken, and vinaigrette dressing.',
  ),
  HeroImage(
    url: 'assets/images/5.jpg',
    title: 'Vegetarian Dinner',
    description: 'Grilled vegetables and quinoa for a light evening meal.',
  ),
  HeroImage(
    url: 'assets/images/5.jpg',
    title: 'Fruit Snack',
    description: 'A bowl of fresh seasonal fruits for a healthy snack.',
  ),
  HeroImage(
    url: 'assets/images/5.jpg',
    title: 'Hydration',
    description: 'Refreshing infused water with lemon and mint.',
  ),
];

const List<HeroImage> exersiceTutorials = [
  HeroImage(
    url:
        'https://images.unsplash.com/photo-1598971639058-fab3c3109a00?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8cHVzaCUyMHVwfGVufDB8fDB8fHww',
    video: 'https://youtu.be/IODxDxX7oi4?si=OL3UmxYECNZAU87W',
    title: 'Push-Up Tutorial',
    description:
        'Step-by-step guide to perfect push-up form for chest, shoulders, and triceps.',
  ),
  HeroImage(
    url:
        'https://images.unsplash.com/photo-1541600383005-565c949cf777?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8c3F1YXR8ZW58MHx8MHx8fDA%3D',
    video: 'https://youtu.be/gcNh17Ckjgg?si=N2T6kWH9E4DkxxaX',
    title: 'Squat Tutorial',
    description:
        'Learn proper squat technique for building strong legs and glutes.',
  ),
  HeroImage(
    url:
        'https://images.unsplash.com/photo-1652363722833-509b3aac287b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YmVuY2glMjBwcmVzc3xlbnwwfHwwfHx8MA%3D%3D',
    video: 'https://youtu.be/4Y2ZdHCOXok?si=mJ2sbHYc0COgO5oe',
    title: 'Bench Press Tutorial',
    description:
        'Master the bench press for chest, triceps, and shoulder strength.',
  ),
  HeroImage(
    url:
        'https://images.unsplash.com/photo-1597452573811-85e7383195a6?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8YmljZXAlMjBjdXJsfGVufDB8fDB8fHww',
    video: 'https://youtu.be/GNO4OtYoCYk?si=TQqacQTDmSxa0D-y',
    title: 'Bicep Tutorial',
    description: 'How to perform bicep curls for bigger and stronger arms.',
  ),
  HeroImage(
    url:
        'https://plus.unsplash.com/premium_photo-1683120903102-ca698a2abc20?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fGJhY2slMjBleGVyY2lzZXxlbnwwfHwwfHx8MA%3D%3D',
    video: 'https://youtu.be/O94yEoGXtBY?si=zLcJzQVLHtd1MunO',
    title: 'Lat Pull Down Routine',
    description: 'Learn the lat pulldown for a strong and wide back.',
  ),
];
