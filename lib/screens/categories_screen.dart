import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled2/dummy_data.dart';
import 'package:untitled2/provider/meal_provider.dart';
import 'package:untitled2/widgets/categories_item.dart';

import '../models/meals.dart';



class CategoriesScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            //mainAxisExtent:
          ),
          children: (Provider.of<MealProvider>(context).availableCategories)
              .map((catData) => categoriesItem(
                    catData.id,
                    catData.title,
                    catData.color,
                    context,

                  ))
              .toList(),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          //itemBuilder: (BuildContext context, int index)=> categoriesItem(DUMMY_CATEGORIES[index]),
        ),
      ),
    );
  }
}
