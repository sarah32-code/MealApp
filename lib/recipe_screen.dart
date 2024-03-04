// recipe_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'recipe_model.dart';

class RecipeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
      ),
      body: Consumer<RecipeModel>(
        builder: (context, recipeModel, child) {
          return ListView.builder(
            itemCount: recipeModel.recipes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(recipeModel.recipes[index].name),
                onTap: () {
                  _showRecipeDetails(context, recipeModel.recipes[index]);
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, recipeModel.recipes[index]);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddRecipeDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddRecipeDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController detailsController = TextEditingController();
    TextEditingController ingredientsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AddRecipeDialog(
          nameController: nameController,
          detailsController: detailsController,
          ingredientsController: ingredientsController,
        );
      },
    );
  }

  void _showRecipeDetails(BuildContext context, Recipe recipe) {
    showDialog(
      context: context,
      builder: (context) {
        return RecipeDetailsDialog(recipe: recipe);
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Recipe recipe) {
    showDialog(
      context: context,
      builder: (context) {
        return DeleteConfirmationDialog(recipe: recipe);
      },
    );
  }
}

class AddRecipeDialog extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController detailsController;
  final TextEditingController ingredientsController;

  AddRecipeDialog({
    required this.nameController,
    required this.detailsController,
    required this.ingredientsController,
  });

  @override
  _AddRecipeDialogState createState() => _AddRecipeDialogState();
}

class _AddRecipeDialogState extends State<AddRecipeDialog> {
  @override
  void dispose() {
    widget.nameController.dispose();
    widget.detailsController.dispose();
    widget.ingredientsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Recipe'),
      content: Column(
        children: [
          TextField(
            controller: widget.nameController,
            decoration: InputDecoration(labelText: 'Recipe Name'),
          ),
          TextField(
            controller: widget.detailsController,
            decoration: InputDecoration(labelText: 'Details'),
          ),
          TextField(
            controller: widget.ingredientsController,
            decoration: InputDecoration(labelText: 'Ingredients (comma-separated)'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            _addRecipe(context);
          },
          child: Text('Add'),
        ),
      ],
    );
  }

  void _addRecipe(BuildContext context) {
    if (widget.nameController.text.isNotEmpty) {
      List<String> ingredients = widget.ingredientsController.text.split(',').map((e) => e.trim()).toList();
      Provider.of<RecipeModel>(context, listen: false).addRecipe(
        widget.nameController.text,
        widget.detailsController.text,
        ingredients,
      );
      Navigator.pop(context);
    }
  }
}

class RecipeDetailsDialog extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailsDialog({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Recipe Details - ${recipe.name}'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Details: ${recipe.details}'),
          SizedBox(height: 8),
          Text('Ingredients: ${recipe.ingredients.join(", ")}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}

class DeleteConfirmationDialog extends StatelessWidget {
  final Recipe recipe;

  DeleteConfirmationDialog({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm Delete'),
      content: Text('Are you sure you want to delete the recipe "${recipe.name}"?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            _deleteRecipe(context);
          },
          child: Text('Delete'),
        ),
      ],
    );
  }

  void _deleteRecipe(BuildContext context) {
    Provider.of<RecipeModel>(context, listen: false).removeRecipe(recipe.name as Recipe);
    Navigator.pop(context);
  }
}
