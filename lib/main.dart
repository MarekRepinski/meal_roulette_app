import 'package:flutter/material.dart';
import 'package:meal_roulette_app/screens/home.dart';
import 'package:meal_roulette_app/shared/theme.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget splashScreen = SplashScreenView(
      navigateRoute: StartPage(
        title: 'Meal Roulette',
      ),
      duration: 5000,
      imageSize: 200,
      // imageSrc: "assets/logo.png",
      text: "Meal Roulette",
      textType: TextType.TyperAnimatedText,
      textStyle: TextStyle(
        fontSize: 30.0,
      ),
      backgroundColor: Color(0xFFE2DDFC),
    );

    return MaterialApp(
      title: 'Meal Roulette',
      home: splashScreen,
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: basicTheme(),
      home: Home(title: title,),
    );
  }
}


