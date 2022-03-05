import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/meals.dart';
import '../provider/meal_provider.dart';
import '../widgets/meals_item.dart';

class FavoritesScreen extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    List<Meal> favoritesMeal = Provider.of<MealProvider>(context).favoritesMeal;

    if (favoritesMeal.isEmpty) {
      return const Center(child: Text('No Items added to Favorites yet'));
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemBuilder: (context, index) => buildMealsItem(
            model: favoritesMeal[index],
            context: context,
          ),
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 30,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 5,
            ),
          ),
          itemCount: favoritesMeal.length,
        ),
      );
    }
  }
}
