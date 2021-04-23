import 'package:flutter/material.dart';
import 'package:flutter_meals_app/screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;
  final String id;

  CategoryItem(this.title, this.color, this.id);

  void selectCategory(BuildContext ctx) {
    //class that helps u navigate between ur screens
    // Navigator.of(ctx).push(
    //   MaterialPageRoute(builder: (_) {
    //     return CategoryMealsScreen(id, title);
    //   }),
    // );
    Navigator.of(ctx).pushNamed(
      CategoryMealsScreen.routeName,
      //we pass these arguments map to the new screen 
      //which is loaded for this route 
      //identifier(leads to categoryMealsScreen)
      arguments: {
        "id": id,
        "title": title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //InkWell is idem to GestureDetector but it has a visual feedback
    //it fires off a ripple effect kinda waves when u tap the widget
    return InkWell(
      onTap: () => selectCategory(context),
      //color of the waves
      splashColor: Theme.of(context).primaryColor,
      //the border radius should match the border radius of the card
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
