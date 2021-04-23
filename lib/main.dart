import 'package:flutter/material.dart';

import './screens/category_meals_screen.dart';
import './models/meal.dart';
import './screens/meal_detail_screen.dart';
import './screens/categories_screen.dart';
import './screens/tabs_screen.dart';
import './screens/filters_screen.dart';
import './data/dummy_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "gluten-free": false,
    "lactose-free": false,
    "vegan": false,
    "vegetarian": false,
  };
  List<Meal> _availbaleMeals = DUMMY_MEALS;
  List<Meal> _favoritedMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availbaleMeals = DUMMY_MEALS.where((meal) {
        if (_filters["gluten-free"] && !meal.isGlutenFree) {
          //returning false means we don't want
          //to include the item in the newly generated list
          return false;
        }
        if (_filters["lactose-free"] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters["vegan"] && !meal.isVegan) {
          return false;
        }
        if (_filters["vegetarian"] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  //adds or removes (if it already is in the list of _favoritedMeals) a meal from the _favoritedMeaals list
  void _toggleFavorites(String mealId) {
    //if we don't find the meal the index will be -1 => we have to add it to the favoritedMeals list
    final existingIndex =
        _favoritedMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoritedMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritedMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  //returns true if we have a meal with the id passed in the favoritedMeals list
  bool _isMealFavorite(String id) {
    return _favoritedMeals.any((meal) => meal.id == id);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        // accentColor: Colors.amber.shade50,
        canvasColor: Color.fromRGBO(255, 154, 229, 1),
        fontFamily: "Raleway",
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 20,
                fontFamily: "RobotoCondensed",
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // root screen of the app
      // home has always an automatically named route which is /
      // home: CategoriesScreen(),

      //if you want Flutter to load some other screen instead of the default screen
      initialRoute: "/",

      //Using Named Routes
      routes: {
        "/": (ctx) => TabsScreen(_favoritedMeals),
        // String keys identify a route (screen) : value is a creation function for the screen
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availbaleMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorites, _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   if(settings.name == "meal-detail") {
      //     return MaterialPageRoute(builder: (ctx) => MealDetailScreen());
      //   }
      //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Delicious Meals"),
//       ),
//       body: Center(
//         child: Text("Navigation Item"),
//       ),
//     );
//   }
// }
