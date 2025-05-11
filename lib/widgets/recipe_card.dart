import 'package:flutter/material.dart';
import '../models/recipe.dart';


// Helper Widget: Recipe Card (for Popular Recipes)
class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onFavoriteToggle;

  const RecipeCard({
    Key? key,
    required this.recipe,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isVegetarian =
        recipe.category?.toLowerCase() == 'vegetarian' ||
        recipe.title.toLowerCase().contains('vegetable');

    return Container(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  recipe.imageUrl,
                  height: 120,
                  width: 160,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 120,
                      width: 160,
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: InkWell(
                  onTap: onFavoriteToggle,
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      recipe.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: recipe.isFavorite ? Colors.red : Colors.grey,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            recipe.title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D4654),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.local_fire_department_outlined,
                color: Colors.grey,
                size: 16,
              ),
              SizedBox(width: 4),
              Text(
                '${recipe.calories} kcal',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(width: 12),
              Icon(Icons.access_time, color: Colors.grey, size: 16),
              SizedBox(width: 4),
              Text(
                '${recipe.cookTime} min',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              if (isVegetarian) ...[
                SizedBox(width: 12),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.eco, color: Colors.white, size: 12),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
