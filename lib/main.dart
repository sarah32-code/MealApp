// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'recipe_screen.dart';
import 'meal_planning_screen.dart';
import 'grocery_list_screen.dart'; 
import 'recipe_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RecipeModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/recipes': (context) => RecipeScreen(),
        '/meal_planning': (context) => MealPlanningScreen(),
        '/grocery_list': (context) => GroceryListScreen(),
      },
      theme: ThemeData(
        primaryColor: Colors.green, 
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe & Meal Planner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/recipe_logo.png', 
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/recipes');
              },
              child: Text('View Recipes'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/meal_planning');
              },
              child: Text('Meal Planning'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/grocery_list');
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
