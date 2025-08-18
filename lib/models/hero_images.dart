class HeroImage {
  final String url;
  final String? title;
  final String? description;

  const HeroImage({required this.url, this.title, this.description});
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
