import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'recipe_model.dart';

class GroceryListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grocery List'),
      ),
      body: Consumer<RecipeModel>(
        builder: (context, recipeModel, child) {
          return ListView.builder(
            itemCount: recipeModel.groceryList.length,
            itemBuilder: (context, index) {
              final groceryItem = recipeModel.groceryList[index];
              return ListTile(
                title: Text(groceryItem),
                trailing: IconButton(
                  icon: Icon(Icons.fastfood),
                  onPressed: () {
                    recipeModel.removeGroceryItem(groceryItem);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddItemDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }


  void _showAddItemDialog(BuildContext context) {
    TextEditingController itemController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Item to Grocery List'),
          content: TextField(
            controller: itemController,
            decoration: InputDecoration(labelText: 'Item Name'),
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
                if (itemController.text.isNotEmpty) {
                  Provider.of<RecipeModel>(context, listen: false)
                      .addGroceryItem(itemController.text);
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
