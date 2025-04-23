import 'product.dart';

class Recipe {
  final int id;
  final String title;
  final String chef;
  final String imageUrl;
  final int cookTime;
  final int calories;
  final String category;
  final List<String> ingredients;
  final bool isFavorite;

  final List<Map<String, dynamic>> ingredientsList;
  final String instructions;
  final String creator;
  final String creatorDescription;
  final int carbs;
  final int proteins;
  final int fats;

  Recipe({
    required this.id,
    required this.title,
    required this.chef,
    required this.imageUrl,
    required this.cookTime,
    required this.calories,
    required this.category,
    required this.ingredients,
    this.isFavorite = false,
    this.ingredientsList = const [],
    this.instructions = '',
    this.creator = '',
    this.creatorDescription = '',
    this.carbs = 0,
    this.proteins = 0,
    this.fats = 0,
  });

  // Convert Product from FakeStore API to Recipe
  factory Recipe.fromProduct(Product product) {
    return Recipe(
      id: product.id,
      title:
          product.title.length > 25
              ? "${product.title.substring(0, 25)}..."
              : product.title,
      chef: "James Spader",
      imageUrl: product.image,
      cookTime: 20,
      calories: 100,
      category: _mapCategoryToMeal(product.category),
      ingredients: _generateRandomIngredients(),
      isFavorite: false,
      ingredientsList: [
        {'name': 'Ingredient 1', 'amount': '100g'},
        {'name': 'Ingredient 2', 'amount': '200ml'},
      ],
      instructions: 'Sample cooking instructions for ${product.title}',
      creator: 'Chef James Spader',
      creatorDescription: 'Expert chef with 15 years of experience',
      carbs: 30,
      proteins: 20,
      fats: 10,
    );
  }


  static String _mapCategoryToMeal(String category) {
    final Map<String, String> categoryMap = {
      "electronics": "Dinner",
      "jewelery": "Breakfast",
      "men's clothing": "Lunch",
      "women's clothing": "Dinner",
    };
    return categoryMap[category] ?? "Breakfast";
  }

  static List<String> _generateRandomIngredients() {
    return ["Eggs", "Flour", "Milk", "Salt", "Pepper", "Olive oil"];
  }
}
