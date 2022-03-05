import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled2/provider/meal_provider.dart';
import 'package:untitled2/screens/filter_screen.dart';
import 'package:untitled2/screens/tabs_screen.dart';
import 'package:untitled2/shared/cache_helper.dart';
import 'package:untitled2/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  runApp(
    ChangeNotifierProvider<MealProvider>(
        create: (context) => MealProvider(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeLight,
      darkTheme: themeDark,
      debugShowCheckedModeBanner: false,
      themeMode: Provider.of<MealProvider>(context).isDark
          ? ThemeMode.dark
          : ThemeMode.light,
      home: TabsScreen(),
    );
  }
}
