import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled2/models/categories.dart';

import '../models/meals.dart';
import '../screens/category_meal_screen.dart';

Widget categoriesItem(String id, String title, Color color, context) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return CategoryMealScreen(id: id, title: title,);
          },
        ),
      );
    },
    child: Container(
      alignment: AlignmentDirectional.bottomEnd,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    ),
  );
}
