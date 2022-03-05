import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled2/models/categories.dart';

import '../dummy_data.dart';
import '../models/meals.dart';
import '../shared/cache_helper.dart';

class MealProvider with ChangeNotifier {
  Map<String, bool> filter = {
    'glutenFree': false,
    'lactoseFree': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> availableMeal = DUMMY_MEALS;
  List<Meal> favoritesMeal = [];
  List<String> prefsMealId = [];
  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;

  List<Category> availableCategories =DUMMY_CATEGORIES;

  void setFilter(Map<String, bool> filterData) {
    filter = filterData;

    availableMeal = DUMMY_MEALS.where((element) {
      if (filter['glutenFree']! && !element.isGlutenFree) return false;
      if (filter['lactoseFree']! && !element.isLactoseFree) return false;
      if (filter['vegan']! && !element.isVegan) return false;
      if (filter['vegetarian']! && !element.isVegetarian) return false;

      return true;
    }).toList();

    notifyListeners();

    CacheHelper.saveDara(key: 'gluten', value: filter['glutenFree']);
    CacheHelper.saveDara(key: 'lactose', value: filter['lactoseFree']);
    CacheHelper.saveDara(key: 'vegan', value: filter['vegan']);
    CacheHelper.saveDara(key: 'vegetarian', value: filter['vegetarian']);

    availableCategories = [];
   availableMeal.forEach((meal) {
     meal.categories.forEach((catId) {
       DUMMY_CATEGORIES.forEach((cat) {
         if (cat.id == catId){
           if(!availableCategories.any((element)=> element.id == catId)) availableCategories.add(cat);
         }
       });
     });
   });

  }

  void getFavList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? prefsMealId = prefs.getStringList('prefsMealId');

    favoritesMeal = [];

    for (var id in prefsMealId!) {
      favoritesMeal.add(DUMMY_MEALS.firstWhere((element) => element.id == id));
    }
  }

  void toogleFavorites({required String id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final favoriteIndex =
        favoritesMeal.indexWhere((element) => element.id == id);

    if (favoriteIndex >= 0) {
      favoritesMeal.removeAt(favoriteIndex);
      prefsMealId.remove(id);
    } else {
      favoritesMeal.add(DUMMY_MEALS.firstWhere((element) => element.id == id));
      prefsMealId.add(id);
    }
    notifyListeners();

    prefs.setStringList('prefsMealId', prefsMealId);
  }

  bool isFavorite({required String id}) {
    return favoritesMeal.any((element) => element.id == id);
  }

  void changeTheme (){
    isDark = !isDark;

    CacheHelper.saveDara(key:'isDark', value: isDark);
    notifyListeners();
  }
}
