import 'package:flutter/material.dart';

import './categories_screen.dart';
import './favorites_screen.dart';
import '../widgets/main_drawer.dart';
import '../models/meal.dart';



class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  TabsScreen(this.favoriteMeals);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages ;
  int _selectedPageIndex = 0;

  @override
  void initState() { 
    _pages = [
    {
      "page": CategoriesScreen(),
      "title": "Categories",
    },
    {
      "page": FavoritesScreen(widget.favoriteMeals),
      "title": "Favorites",
    },
  ];
    super.initState();
  }
  //Flutter automatically give sus the index of the selected tab
  void _selectPage(int index) {
    setState(() {
      //to switch the page whenever the selected index changes
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]["title"]),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]["page"],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        // backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.yellowAccent,
        //to add animation
        type: BottomNavigationBarType.shifting,
        //to feed the selected index info to the BottomNavigationBar
        currentIndex: _selectedPageIndex,

        items: [
          // idem to Tab in the tabBar when added to the Appbar
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text("Categories"),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text("favorites"),
          ),
        ],
      ),
    );

    //tab at the bottom of the appBar
    // return DefaultTabController(
    //   //which index should be selected at the start by default
    //   //0 is the default
    //   // initialIndex: 0,
    //   length: 2,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: Text("Meals"),
    //       bottom: TabBar(
    //         tabs: <Widget>[
    //           Tab(
    //             icon: Icon(Icons.category),
    //             text: "Categories",
    //           ),
    //           Tab(
    //             icon: Icon(Icons.star),
    //             text: "Favorites",
    //           ),
    //         ],
    //       ),
    //     ),
    //     body: TabBarView(
    //       //have as many children as the number of tabs
    //       //DefaultTabController holds the clicked tab number and then shows
    //       //the corrsponding child that exists in TabBarView,
    //       //<=> (click on first Tab => first child in TabBarView is displayed)
    //       children: [
    //         CategoriesScreen(),
    //         FavoritesScreen(),
    //       ],
    //     ),
    //   ),
    // );
  }
}
