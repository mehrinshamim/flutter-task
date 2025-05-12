import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/recipe.dart';
import '../services/api_service.dart';

class RecipeProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Recipe> _recipes = [];
  List<Recipe> _featuredRecipes = [];
  List<String> _categories = ['Breakfast', 'Lunch', 'Dinner'];
  bool _isLoading = false;
  String _error = '';

  List<Recipe> get recipes => _recipes;
  List<Recipe> get featuredRecipes => _featuredRecipes;
  List<String> get categories => _categories;
  bool get isLoading => _isLoading;
  String get error => _error;

  // Get recipes by transforming products from the API
  Future<void> fetchRecipes() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final products = await _apiService.getProducts();
      _recipes =
          products.map((product) => Recipe.fromProduct(product)).toList();
      _featuredRecipes = _recipes.take(5).toList();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCategories() async {
    try {
      final apiCategories = await _apiService.getCategories();
      // Map API categories to meal categories or use default ones
      notifyListeners();
    } catch (e) {
      // Fall back to default categories
    }
  }

  List<Recipe> getRecipesByCategory(String category) {
    return _recipes.where((recipe) => recipe.category == category).toList();
  }

  void toggleFavorite(int recipeId) {
    final index = _recipes.indexWhere((recipe) => recipe.id == recipeId);
    if (index != -1) {
      _recipes[index] = Recipe(
        id: _recipes[index].id,
        title: _recipes[index].title,
        author: _recipes[index].author, // Add this line
        chef: _recipes[index].chef,
        imageUrl: _recipes[index].imageUrl,
        cookTime: _recipes[index].cookTime,
        calories: _recipes[index].calories,
        category: _recipes[index].category,
        ingredients: _recipes[index].ingredients,
        isFavorite: !_recipes[index].isFavorite,
      );
      notifyListeners();
    }
  }

  Future<void> loadRecipeDetails(int recipeId) async {
    // This would normally fetch from API
    // Since we're adapting FakeStore API data, we'll add the details to the existing recipe
    final index = _recipes.indexWhere((recipe) => recipe.id == recipeId);
    if (index != -1) {
      // Add ingredient details and instructions
      _recipes[index] = Recipe(
        id: _recipes[index].id,
        title: _recipes[index].title,
        author: 'Natalia Luca', // Add this line
        chef: _recipes[index].chef,
        imageUrl: _recipes[index].imageUrl,
        cookTime: _recipes[index].cookTime,
        calories: _recipes[index].calories,
        category: _recipes[index].category,
        ingredients: _recipes[index].ingredients,
        isFavorite: _recipes[index].isFavorite,
        // Add new fields
        carbs: 65,
        proteins: 27,
        fats: 9,
        creator: 'Natalia Luca',
        creatorDescription: "I'm the author and recipe developer.",
        instructions:
            'Step 1: Prepare all ingredients\n\nStep 2: Mix the vegetables in a large bowl\n\nStep 3: Add spices and mix well',
        ingredientsList: [
          {'name': 'Tortilla Chips', 'quantity': 2},
          {'name': 'Avocado', 'quantity': 1},
          {'name': 'Red Cabbage', 'quantity': 9},
          {'name': 'Peanuts', 'quantity': 1},
          {'name': 'Red Onions', 'quantity': 1},
        ],
      );
      notifyListeners();
    }
  }
}
