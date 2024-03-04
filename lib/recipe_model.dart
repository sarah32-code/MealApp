import 'package:flutter/material.dart';

class RecipeModel extends ChangeNotifier {
  List<Recipe> recipes = [
    Recipe(
      name: 'Grilled Chicken',
      details: '''
        - 4 boneless, skinless chicken breasts
        - 2 tablespoons olive oil
        - 1 teaspoon salt
        - 1/2 teaspoon black pepper
        - 1 teaspoon garlic powder
        - 1 teaspoon paprika
        
        Instructions:
        1. Preheat the grill to medium-high heat.
        2. Rub chicken breasts with olive oil and season with salt, pepper, garlic powder, and paprika.
        3. Grill chicken for 6-8 minutes per side or until fully cooked.
        4. Let it rest for a few minutes before serving.
      ''',
      ingredients: ['Chicken', 'Salt', 'Pepper'],
    ),
    Recipe(
      name: 'Alfredo Pasta',
      details: '''
        - 8 oz fettuccine pasta
        - 1/2 cup unsalted butter
        - 1 cup heavy cream
        - 1 cup grated Parmesan cheese
        - Salt and black pepper to taste
        - Chopped parsley for garnish
        
        Instructions:
        1. Cook fettuccine pasta according to package instructions; drain and set aside.
        2. In a saucepan, melt butter over medium heat. Stir in heavy cream and bring to a simmer.
        3. Add Parmesan cheese and stir until melted and smooth. Season with salt and pepper.
        4. Toss cooked pasta in the Alfredo sauce until well coated. Garnish with chopped parsley.
      ''',
      ingredients: ['Pasta', 'Cream', 'Cheese'],
    ),
    Recipe(
      name: 'Baked Salmon',
      details: '''
        - 4 salmon fillets
        - 2 tablespoons olive oil
        - 2 cloves garlic, minced
        - 1 teaspoon dried thyme
        - 1 teaspoon dried rosemary
        - Salt and black pepper to taste
        - Lemon wedges for serving
        
        Instructions:
        1. Preheat the oven to 400°F (200°C).
        2. Place salmon fillets on a baking sheet lined with parchment paper.
        3. In a small bowl, mix olive oil, minced garlic, thyme, rosemary, salt, and pepper.
        4. Brush the salmon fillets with the herb mixture.
        5. Bake for 12-15 minutes or until the salmon flakes easily with a fork.
        6. Serve with lemon wedges.
      ''',
      ingredients: ['Salmon', 'Olive Oil', 'Herbs'],
    ),
  ];

  Set<String> selectedRecipes = Set<String>();
  List<String> groceryList = [];
  DateTime? plannedMealDate;

  void addRecipe(String newRecipeName, String details, List<String> ingredients) {
    recipes.add(Recipe(name: newRecipeName, details: details, ingredients: ingredients));
    notifyListeners();
  }
  
  void removeRecipe(Recipe recipe) {
    recipes.remove(recipe);
    selectedRecipes.remove(recipe.name); 
    notifyListeners(); 
  }

  
  bool isRecipeSelected(Recipe recipe) {
    return selectedRecipes.contains(recipe.name);
  }

  void toggleRecipeSelection(Recipe recipe) {
    if (selectedRecipes.contains(recipe.name)) {
      selectedRecipes.remove(recipe.name);
    } else {
      selectedRecipes.add(recipe.name);
    }
    notifyListeners(); 
  }

  
  void addGroceryItem(String newItem) {
    groceryList.add(newItem);
    notifyListeners(); 
  }

  
  void removeGroceryItem(String item) {
    groceryList.remove(item);
    notifyListeners(); 
  }

  
  void planMeal(DateTime? date) {
    plannedMealDate = date;
    notifyListeners(); 
  }

  
  void clearPlannedMeals() {
    selectedRecipes.clear();
    plannedMealDate = null; 
    notifyListeners(); 
  }
}

class Recipe {
  String name;
  String details;
  List<String> ingredients;

  Recipe({required this.name, required this.details, required this.ingredients});
}
