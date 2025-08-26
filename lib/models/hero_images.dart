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
    video: 'https://youtu.be/IODxDxX7oi4?si=RJFdkJh-AIqIWV8u',
    title: 'Push-Up Tutorial',
    description: 'Learn proper push-up form for chest and triceps.',
  ),
  HeroImage(
    url:
        'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?q=80&w=710&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    title: 'Squat Tutorial',
    video: '',
    description: 'Master squats for strong legs and glutes.',
  ),
  HeroImage(
    url:
        'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    title: 'Plank Tutorial',
    video: '',
    description: 'Improve core strength with proper plank technique.',
  ),
  HeroImage(
    url:
        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    title: 'Lunge Tutorial',
    video: '',
    description: 'Step-by-step guide to lunges for balance and strength.',
  ),
  HeroImage(
    url:
        'https://images.unsplash.com/photo-1504674900247-0877df9cc836?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    title: 'Stretching Routine',
    video: '',
    description: 'Essential stretches for flexibility and recovery.',
  ),
];
