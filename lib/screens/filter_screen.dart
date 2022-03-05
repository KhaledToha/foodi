import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled2/screens/category_meal_screen.dart';
import 'package:untitled2/screens/tabs_screen.dart';
import 'package:untitled2/shared/cache_helper.dart';

import '../provider/meal_provider.dart';
import 'categories_screen.dart';

class FilterScreen extends StatefulWidget {
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = CacheHelper.getData(key: 'gluten')?? false;
  bool _lactosefree = CacheHelper.getData(key: 'lactose')?? false;
  bool _vegan = CacheHelper.getData(key: 'vegan')?? false;
  bool _vegetarian = CacheHelper.getData(key: 'vegetarian')?? false;

  @override
  void initState() {
  //
  //   _glutenFree = Provider.of<MealProvider>(context , listen: false).filter['glutenFree'];
  //   _vegetarian = Provider.of<MealProvider>(context , listen: false).filter['vegetarian'];
  //   _vegan = Provider.of<MealProvider>(context , listen: false).filter['vegan'];
  //   _lactosefree = Provider.of<MealProvider>(context , listen: false).filter['lactoseFree'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filter'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SwitchListTile(
                    title: Text(
                      'Gluten Free',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                        'active Gluten filter to show the only meals of Gluten free'),
                    value: _glutenFree,
                    onChanged: (value) {
                      setState(() {
                        _glutenFree = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text(
                      'Lactose Free',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                        'active Lactose filter to show the only meals of Lactos free'),
                    value: _lactosefree,
                    onChanged: (value) {
                      setState(() {
                        _lactosefree = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text(
                      'Vegan',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                        'active Vegan filter to show the only meals are vegan'),
                    value: _vegan,
                    onChanged: (value) {
                      setState(() {
                        _vegan = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text(
                      'vegetarian',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                        'active vegetarian filter to show  only the vegetarian meals '),
                    value: _vegetarian,
                    onChanged: (value) {
                      setState(() {
                        _vegetarian = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                         Map<String, bool> selectedFilter = {
                          'glutenFree': _glutenFree,
                          'lactoseFree': _lactosefree,
                          'vegan': _vegan,
                          'vegetarian': _vegetarian,
                        };
                        Provider.of<MealProvider>(context, listen: false)
                            .setFilter(selectedFilter);
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return TabsScreen();
                      }));
                    },
                    child: Text(
                      'Apply',
                      style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
                    ),
                    color: Colors.red,
                  ),
                ),
                SizedBox(width: 10,),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _glutenFree =false;
                      _lactosefree = false;
                      _vegan = false;
                      _vegetarian = false;


                      Map<String, bool> selectedFilter = {
                        'glutenFree': _glutenFree,
                        'lactoseFree': _lactosefree,
                        'vegan': _vegan,
                        'vegetarian': _vegetarian,
                      };

                      Provider.of<MealProvider>(context , listen: false).setFilter(selectedFilter);
                    });


                  },
                  child: Text(
                    'Clear',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
