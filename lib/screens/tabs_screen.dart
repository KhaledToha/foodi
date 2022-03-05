import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled2/screens/categories_screen.dart';
import 'package:untitled2/screens/favorites_screen.dart';
import 'package:untitled2/screens/filter_screen.dart';

import '../models/meals.dart';
import '../provider/meal_provider.dart';
import '../shared/cache_helper.dart';

class TabsScreen extends StatefulWidget {
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    Map<String, bool> filterData = {

      'glutenFree': CacheHelper.getData(key: 'gluten') ?? false,
      'lactoseFree': CacheHelper.getData(key: 'lactose') ?? false,
      'vegan': CacheHelper.getData(key: 'vegan') ?? false,
      'vegetarian': CacheHelper.getData(key: 'vegetarian') ?? false,
    };

    Provider.of<MealProvider>(context, listen: false).setFilter(filterData);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> titles = ['Categories', 'Favorites'];
    List<Widget> screen = [CategoriesScreen(), FavoritesScreen()];
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[currentIndex]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int value) {
          setState(() {
            currentIndex = value;
            if (currentIndex == 1) {
              Provider.of<MealProvider>(context, listen: false).getFavList();
            }
          });
        },
        showUnselectedLabels: false,
        selectedItemColor: Theme
            .of(context)
            .primaryColor,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
      body: screen[currentIndex],
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.red,
                    Colors.orangeAccent,
                  ])),
              child: Center(
                  child: Text(
                    'Fooodi !',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline5!
                        .copyWith(
                        color: Colors.white, fontWeight: FontWeight.w900),
                  )),
            ),
            ListTile(
              leading: Icon(Icons.restaurant),
              title: Text(
                'Food Menu',
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6,
              ),
              onTap: () {
                setState(() {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                        return TabsScreen();
                      }));
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.settings_sharp),
              title: Text(
                'Filters',
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FilterScreen();
                }));
              },
            ),
            SwitchListTile(
              title: Row(
                children: [
                  Icon(Icons.nights_stay_sharp),
                  SizedBox(width: 32,),
                  Text('Dark Mode'),
                ],
              ),

              value: Provider
                  .of<MealProvider>(context)
                  .isDark,
              onChanged: (value) {
                setState(() {
                  Provider.of<MealProvider>(context, listen: false)
                      .changeTheme();
                });
              },

            ),


          ],
        ),
      ),
    );
  }
}
