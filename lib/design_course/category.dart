class Category {
  Category({
    required this.title,
    required this.lessonCount,
    required this.rating,
    required this.imagePath,
    required this.money,
  });

  String title;
  int lessonCount;
  double rating;
  String imagePath;
  double money;

  static List<Category> categoryList = [
    Category(
      title: 'Design',
      lessonCount: 24,
      rating: 4.3,
      imagePath: 'assets/design.png',
      money: 25.0,
    ),
    Category(
      title: 'Programming',
      lessonCount: 18,
      rating: 4.5,
      imagePath: 'assets/programming.png',
      money: 30.0,
    ),
    // Add more categories as needed
  ];
}
