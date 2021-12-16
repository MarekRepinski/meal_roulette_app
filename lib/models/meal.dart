class Meal {
  final String picture;
  final String title;

  Meal({required this.picture, required this.title});

  factory Meal.fromJson(Map<String, dynamic> json){
    return Meal(
      picture: json['picture'] as String,
      title: json['title'] as String,
    );
  }
}

