import 'package:flutter/material.dart';
import 'package:meal_roulette_app/services/http_service.dart';
import 'package:meal_roulette_app/models/meal.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HttpService httpService = HttpService();
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter = _counter + 4;
      if (_counter > 11){
        _counter = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: FutureBuilder(
        future: httpService.getMeals(_counter),
        builder: (BuildContext context, AsyncSnapshot<List<Meal>> snapshot) {
          if (snapshot.hasData) {
            List<Meal>? meals = snapshot.data;
            if (meals == null){
              List<Meal> meals = [Meal(picture: '', title: '')];
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5),
              itemCount: meals!.length,
              itemBuilder: (BuildContext ctx, index) {
                return Dish(meals: meals, index: index,);
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton.extended(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            label: Text(
              'Refresh',
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
            icon: const Icon(
              Icons.refresh,
              size: 30.0,
            ),
          ),
        ),
      ),
    );
  }
}

class Dish extends StatefulWidget {
  final List<Meal> meals;
  final int index;

  const Dish({Key? key, required this.meals, required this.index}) : super(key: key);

  @override
  _DishState createState() => _DishState();
}

class _DishState extends State<Dish> {

  @override
  Widget build(BuildContext context) {
    Meal meal = widget.meals[widget.index];
    double myMargin = 5.0;

    return Card(
      elevation: 8.0,
      shape:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green[500]!, width: 3)
      ),
      color: Theme.of(context).primaryColorLight,
      shadowColor: Colors.green,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () => {},
        // onTap: () {
        //   Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => ShowGoods(goodsList: widget.goodsList, startIndex: widget.index, uid: widget.uid),
        //   ));
        // },
        child: SizedBox( // wrapp in Opacity
          width: 200.0,
          height: 300.0,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 2.0),
              child: Column(
                children: [
                  Image.network(
                    meal.picture,
                    width: 150.0,
                    height: 130.0,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 3.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: (myMargin * 2.0),),
                      Flexible(
                          child: Center(child: Text(meal.title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.caption,))
                      ),
                      SizedBox(width: myMargin * 2.0,),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
