import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled2/provider/meal_provider.dart';

import '../models/meals.dart';
import '../widgets/meals_item.dart';
import 'meal_details_screen.dart';

class CategoryMealScreen extends StatefulWidget {
  final String id;
  final String title;

  const CategoryMealScreen({required this.id, required this.title});


  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  List<Meal> categoryMeal = [];

 @override
  void didChangeDependencies() {
   List<Meal> categoryMeal = Provider.of<MealProvider>(context).availableMeal.where((element) {
     return element.categories.contains(widget.id);
   }).toList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<Meal> categoryMeal = Provider.of<MealProvider>(context).availableMeal.where((element) {
      return element.categories.contains(widget.id);
    }).toList();

    List<Meal> shownMeal = categoryMeal;

    if (shownMeal.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Text(
          'No Meals',
          style: Theme.of(context).textTheme.headline5,
        )),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemBuilder: (context, index) => buildMealsItem(
            model: shownMeal[index],
            context: context,
          ),
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 30,
            ),
            child: Container(
              width: double.infinity,
              height: 5,
            ),
          ),
          itemCount: shownMeal.length,
        ),
      ),
    );
  }


}
