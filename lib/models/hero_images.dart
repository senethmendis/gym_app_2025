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
    url:
        'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    title: 'Strength Training',
    description: 'A person lifting weights in the gym.',
  ),
  HeroImage(
    url:
        'https://images.unsplash.com/photo-1574680096145-d05b474e2155?q=80&w=1169&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    title: 'Cardio Session',
    description: 'Running on a treadmill.',
  ),
  HeroImage(
    url:
        'https://images.unsplash.com/photo-1558611848-73f7eb4001a1?q=80&w=1171&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    title: 'Yoga Practice',
    description: 'Yoga mat and stretching.',
  ),
  HeroImage(
    url:
        'https://images.unsplash.com/photo-1594381898411-846e7d193883?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    title: 'Outdoor Workout',
    description: 'Exercising in nature.',
  ),
  HeroImage(
    url:
        'https://images.unsplash.com/photo-1434682772747-f16d3ea162c3?q=80&w=1174&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    title: 'Team Training',
    description: 'Group fitness session.',
  ),
];

const List<HeroImage> healthyMeals = [
  HeroImage(
    url:
        'https://images.unsplash.com/photo-1627955280978-f54fff2f316a?q=80&w=736&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    title: 'Protein Breakfast',
    description: 'Eggs, avocado, and whole grain toast for a healthy start.',
  ),
  HeroImage(
    url:
        'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?q=80&w=710&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    title: 'Fresh Salad Lunch',
    description: 'Mixed greens, grilled chicken, and vinaigrette dressing.',
  ),
  HeroImage(
    url:
        'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    title: 'Vegetarian Dinner',
    description: 'Grilled vegetables and quinoa for a light evening meal.',
  ),
  HeroImage(
    url:
        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    title: 'Fruit Snack',
    description: 'A bowl of fresh seasonal fruits for a healthy snack.',
  ),
  HeroImage(
    url:
        'https://images.unsplash.com/photo-1504674900247-0877df9cc836?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
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
