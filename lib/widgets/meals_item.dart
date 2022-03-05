import 'package:flutter/material.dart';
import 'package:untitled2/screens/meal_details_screen.dart';

import '../models/meals.dart';
Widget buildMealsItem(
    {required Meal model,
      required context}) =>
    InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MealDetailsScreen(
            mealModel: model,

          );
        }));
      },
      child: Card(
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              12,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Image(
                  image: NetworkImage(model.imageUrl),
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Text(
                    model.title,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.white,
                      backgroundColor: Colors.red.withOpacity(.8),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(Icons.watch_later_outlined),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        ' ${model.duration} min',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.local_fire_department_outlined),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        ' ${model.complexity.name}',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money_outlined),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        ' ${model.duration}',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
