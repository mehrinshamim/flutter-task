// lib/screens/recipe_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/recipe.dart';
import '../widgets/ingredient_item.dart';
import '../providers/recipe_provider.dart';
import 'package:provider/provider.dart';

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
    final recipeProvider = Provider.of<RecipeProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0), // Hide the AppBar
        child: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe image with floating buttons
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 1.5,
                        child: Container(
                          color: Colors.white,
                          child: Image.network(
                            widget.recipe.imageUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      // Back button
                      Positioned(
                        top: 40,
                        left: 16,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: SvgPicture.asset(
                            'assets/icons/Cancel.svg',
                            height: 32,
                            width: 32,
                          ),
                        ),
                      ),
                      // Favorite button
                      Positioned(
                        top: 40,
                        right: 16,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          child: SvgPicture.asset(
                            isFavorite
                                ? 'assets/icons/Love-Filled.svg'
                                : 'assets/icons/Love.svg',
                            height: 32,
                            width: 32,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Recipe info card with increased border radius
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32), // Increased from 24
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
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'This Healthy Taco Salad is the universal delight of taco night',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    foregroundColor: Colors.black,
                                  ),
                                  child: const Text(' View More'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        // Nutritional info
                        Container(
                          height: 100, // Reduced height for 2x2 grid
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: GridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                            childAspectRatio: 4,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              _buildNutritionItem(
                                'assets/icons/Carbs.svg',
                                '65g carbs ',
                              ),
                              _buildNutritionItem(
                                'assets/icons/Proteins.svg',
                                '27g proteins',
                              ),
                              _buildNutritionItem(
                                'assets/icons/Kcal.svg',
                                '120 kcal     ',
                              ),
                              _buildNutritionItem(
                                'assets/icons/Fats.svg',
                                '9g fats         ',
                              ),
                            ],
                          ),
                        ),

                        // Tabs for Ingredients and Instructions
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28.0,
                          ), // Add padding from sides
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[350],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: TabBar(
                              controller: _tabController,
                              indicatorColor: Color(0xFF68C4C0),
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.black,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Color(0xFF0D2422),
                              ),
                              indicatorSize:
                                  TabBarIndicatorSize
                                      .tab, // Makes indicator match tab width
                              labelPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ), // Reduce tab padding
                              tabs: [
                                Tab(text: 'Ingredients'),
                                Tab(text: 'Instructions'),
                              ],
                            ),
                          ),
                        ),

                        // Tab content
                        SizedBox(height: 16),
                        SizedBox(
                          height: 700,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              // Ingredients tab
                              Column(
                                children: [
                                  Expanded(child: _buildIngredientsTab()),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF68C4C0),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      child: Text('Add To Cart'),
                                    ),
                                  ),
                                ],
                              ),

                              // Instructions tab
                              _buildInstructionsTab(),
                            ],
                          ),
                        ),

                        // Creator info
                        SizedBox(height: 24), // Increased from 16
                        Text(
                          'Creator',
                          style: TextStyle(
                            fontSize: 22, // Increased from 20
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16), // Increased from 8
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 32, // Increased from 20
                              backgroundImage: NetworkImage(
                                'https://i.pravatar.cc/150?img=5',
                              ),
                            ),
                            SizedBox(width: 16), // Increased from 12
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Natalia Luca',
                                  style: TextStyle(
                                    fontSize: 18, // Added fontSize
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4), // Added spacing
                                Text(
                                  "I'm the author and recipe developer.",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14, // Increased from 12
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
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'See All',
                                style: TextStyle(
                                  fontSize: 18, // Added fontSize
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          height: 160,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              _buildRelatedRecipes(recipeProvider),
                              SizedBox(width: 16),
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
        ],
      ),
    );
  }

  Widget _buildNutritionItem(String iconPath, String text) {
    return Container(
      height: 20, // Set fixed height
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(iconPath, height: 32, width: 32),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Add All to Cart',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
        Text(
          '6 item',
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        // Ingredient items with images
        IngredientItem(
          name: 'Tortilla Chips',
          quantity: 2,
          imagePath: 'assets/icons/TortillaChips.svg',
        ),
        IngredientItem(
          name: 'Avocado',
          quantity: 1,
          imagePath: 'assets/icons/Avocado.svg',
        ),
        IngredientItem(
          name: 'Red Cabbage',
          quantity: 9,
          imagePath: 'assets/icons/RedCabbage.svg',
        ),
        IngredientItem(
          name: 'Peanuts',
          quantity: 1,
          imagePath: 'assets/icons/Peanuts.svg',
        ),
        IngredientItem(
          name: 'Red Onions',
          quantity: 1,
          imagePath: 'assets/icons/RedOnions.svg',
        ),
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

  Widget _buildRelatedRecipes(RecipeProvider recipeProvider) {
    // Take only first 3 recipes except current recipe
    final relatedRecipes =
        recipeProvider.recipes
            .where((r) => r.id != widget.recipe.id)
            .take(3)
            .toList();

    return Row(
      children:
          relatedRecipes.map((recipe) {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: RecipeCard(
                imageUrl: recipe.imageUrl,
                title: recipe.title,
                recipe: recipe,
              ),
            );
          }).toList(),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final dynamic recipe; // Add this field

  const RecipeCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.recipe, // Add this parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(recipe: recipe),
          ),
        );
      },
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,

class RecipeCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final dynamic recipe; // Add this field

  const RecipeCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.recipe, // Add this parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(recipe: recipe),
          ),
        );
      },
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10), // Added padding
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  imageUrl,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 100,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
