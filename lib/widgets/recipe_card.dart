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
      width: 180,
      transform: Matrix4.identity()..scale(1.2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      recipe.imageUrl,
                      height: 120,
                      width: 160,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 120,
                          width: 160,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
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
      ),
    );
  }
}
