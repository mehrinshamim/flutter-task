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
}
