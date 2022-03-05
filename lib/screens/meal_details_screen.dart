import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../models/meals.dart';
import '../provider/meal_provider.dart';

class MealDetailsScreen extends StatelessWidget {
  final Meal mealModel;


   MealDetailsScreen({required this.mealModel, });



  @override
  Widget build(BuildContext context) {
    bool isFavorite = Provider.of<MealProvider>(context).isFavorite(id: mealModel.id) ;
    return Scaffold(
       
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,

          ),
          onPressed: (){
            Provider.of<MealProvider>(context , listen: false).toogleFavorites(id: mealModel.id);
          },
        ),
        body:CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              //title: Text(mealModel.title),
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(mealModel.title),
                background :FadeInImage(
                  placeholder: const AssetImage( 'assets/image/a2.png' ),
                  image: NetworkImage(
                    mealModel.imageUrl,

                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(delegate: SliverChildListDelegate(
              [SizedBox(
                height: 12,
              ),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.headline6,textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                height: 50,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildIngredientsItem(
                      mealModel.ingredients[index], context),
                  separatorBuilder: (context, index) => SizedBox(
                    width: 7,
                  ),
                  itemCount: mealModel.ingredients.length,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 12,
              ),
              ListView.separated(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    buildStepsItems(mealModel.steps, context, index),
                separatorBuilder: (context, index) => SizedBox(
                  height: 12,
                ),
                itemCount: mealModel.steps.length,
              ),
            ]))
          ],
        ));


  }

  Widget buildIngredientsItem(String text, context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget buildStepsItems(List<String> step, context, index) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.red, Colors.orangeAccent]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: Text('${index + 1}'),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  '${step[index]}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
