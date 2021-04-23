import 'package:flutter/material.dart';
import '../widgets/category_item.dart';
import '../data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      children: DUMMY_CATEGORIES
          .map((categoryData) => CategoryItem(
              categoryData.title, categoryData.color, categoryData.id))
          .toList(),
      //
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //max width of one grid item
        maxCrossAxisExtent: 200,
        // height/ width ratio : for 200 width we want to have 300 height
        childAspectRatio: 3 / 2,
        //vertical space between the columns
        crossAxisSpacing: 20,
        //horizontal space between the rows
        mainAxisSpacing: 20,
      ),
    );
  }
}
