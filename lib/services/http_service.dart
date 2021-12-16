import 'dart:convert';

import 'package:http/http.dart';
import 'package:meal_roulette_app/models/meal.dart';

class HttpService {
  final String mealUrl = 'https://playground.devskills.co/api/rest/meal-roulette-app/meals/limit/4/offset/';

  Future<List<Meal>> getMeals(int page) async {
    List<Meal> meals = [Meal(picture: 'no picture', title: 'no title')];

    print(mealUrl + page.toString());
    Response res = await get(Uri.parse(mealUrl + page.toString()));

    if (res.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(res.body);
      Map<String, dynamic> map2 = map['meal_roulette_app_meals_aggregate'];
      List<dynamic> body = map2['nodes'];
      meals = body.map((dynamic item) => Meal.fromJson(item)).toList();
    } else {
      throw "Cant get Meals";
    }

    return meals;
  }
}