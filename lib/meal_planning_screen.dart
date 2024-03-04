import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'recipe_model.dart';

class MealPlanningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Planning'),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              _showDatePicker(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              _showConfirmationDialog(context);
            },
          ),
        ],
      ),
      body: Consumer<RecipeModel>(
        builder: (context, recipeModel, child) {
          return ListView.builder(
            itemCount: recipeModel.recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipeModel.recipes[index];
              return ListTile(
                title: Text(recipe.name),
                trailing: Checkbox(
                  value: recipeModel.isRecipeSelected(recipe),
                  onChanged: (value) {
                    recipeModel.toggleRecipeSelection(recipe);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showDatePicker(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (selectedDate != null) {
      Provider.of<RecipeModel>(context, listen: false).planMeal(selectedDate);
    }
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Meal Planning'),
          content: Text('Are you sure you want to plan these meals?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<RecipeModel>(context, listen: false).clearPlannedMeals();
                Navigator.pop(context);
                _showSnackbar(context, 'Meals Planned Successfully!');
              },
              child: Text('Plan Meals'),
            ),
          ],
        );
      },
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
