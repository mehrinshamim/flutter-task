// lib/screens/recipe_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../widgets/ingredient_item.dart';
import '../widgets/recipe_card.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    isFavorite = widget.recipe.isFavorite;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(4),
            child: Icon(Icons.close, color: Colors.black),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Details Scan - Ingredients'),
        actions: [
          IconButton(
            icon: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(4),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.black,
              ),
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Recipe image and details
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe image
                  AspectRatio(
                    aspectRatio: 1.5,
                    child: Image.network(
                      widget.recipe.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Recipe info card
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, -5),
                        ),
                      ],
                    ),
                    transform: Matrix4.translationValues(0, -20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Recipe title and time
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.recipe.title,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.timer, size: 16, color: Colors.grey),
                                SizedBox(width: 4),
                                Text('${widget.recipe.cookTime} Min'),
                              ],
                            ),
                          ],
                        ),

                        // Recipe description
                        SizedBox(height: 8),
                        Text(
                          'This Healthy Taco Salad is the universal delight of taco night',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(50, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.centerLeft,
                          ),
                          child: Text('View More'),
                        ),

                        // Nutritional info
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildNutritionItem(Icons.grain, '65g carbs'),
                            _buildNutritionItem(
                              Icons.fitness_center,
                              '27g proteins',
                            ),
                            _buildNutritionItem(
                              Icons.local_fire_department,
                              '120 kcal',
                            ),
                            _buildNutritionItem(Icons.opacity, '9g fats'),
                          ],
                        ),

                        // Tabs for Ingredients and Instructions
                        SizedBox(height: 16),
                        TabBar(
                          controller: _tabController,
                          indicatorColor: Color(0xFF68C4C0),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFF0D2422),
                          ),
                          tabs: [
                            Tab(text: 'Ingredients'),
                            Tab(text: 'Instructions'),
                          ],
                        ),

                        // Tab content
                        SizedBox(height: 16),
                        SizedBox(
                          height: 300, // Fixed height for tab content
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              // Ingredients tab
                              _buildIngredientsTab(),

                              // Instructions tab
                              _buildInstructionsTab(),
                            ],
                          ),
                        ),

                        // Creator info
                        SizedBox(height: 16),
                        Text(
                          'Creator',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                'https://i.pravatar.cc/150?img=5',
                              ),
                            ),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Natalia Luca',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "I'm the author and recipe developer.",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Related recipes
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Related Recipes',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text('See All'),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              _buildRelatedRecipe('Egg & Avocado'),
                              SizedBox(width: 12),
                              _buildRelatedRecipe('Bowl of rice'),
                              SizedBox(width: 12),
                              _buildRelatedRecipe('Chicken Soup'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Add to Cart button - shown only in Ingredients tab
          if (_tabController.index == 0)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF68C4C0),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Add To Cart'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNutritionItem(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.blue),
          SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ingredients',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(onPressed: () {}, child: Text('Add All to Cart')),
          ],
        ),
        Text('6 item', style: TextStyle(color: Colors.grey)),
        SizedBox(height: 12),
        // Ingredient items
        IngredientItem(name: 'Tortilla Chips', quantity: 2),
        IngredientItem(name: 'Avocado', quantity: 1),
        IngredientItem(name: 'Red Cabbage', quantity: 9),
        IngredientItem(name: 'Peanuts', quantity: 1),
        IngredientItem(name: 'Red Onions', quantity: 1),
      ],
    );
  }

  Widget _buildInstructionsTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How to Cook',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text(
            'Step 1: Prepare all ingredients\n\n'
            'Step 2: Mix the vegetables in a large bowl\n\n'
            'Step 3: Add spices and mix well\n\n'
            'Step 4: Add tortilla chips just before serving\n\n'
            'Step 5: Top with chopped avocado and peanuts',
            style: TextStyle(height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedRecipe(String name) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              'https://picsum.photos/seed/${name.hashCode}/200/200',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(4),
            child: Text(
              name,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
