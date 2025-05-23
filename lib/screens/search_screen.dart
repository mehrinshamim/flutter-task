import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/floating_action_button.dart';
import './recipe_detail_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _selectedCategory = 'Breakfast';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildHeader(),
              SizedBox(height: 10),
              _buildSearchBar(),
              _buildMealCategories(recipeProvider),
              _buildPopularRecipes(recipeProvider),
              _buildEditorsChoice(recipeProvider),
              SizedBox(height: 20),
              //const Spacer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 1),
      floatingActionButton: CustomFloatingActionButton(
        backgroundColor: const Color(0xFF0D3B35),
        iconColor: Colors.white,
        onPressed: () {
          // Add your onPressed logic here
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0D3B35)),
            onPressed: () => Navigator.pop(context),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Search',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D3B35),
                ),
              ),
            ),
          ),
          const SizedBox(width: 48), // to Balance the back button
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.grey[350]!),
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(
                'assets/icons/Search.svg',
                height: 24,
                width: 24,
              ),
            ),
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey[400]),
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildMealCategories(RecipeProvider recipeProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children:
              recipeProvider.categories.map((category) {
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? const Color(0xFF65B0B4)
                                : const Color(0xFFEEF6F6),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildPopularRecipes(RecipeProvider recipeProvider) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          _buildSectionHeader('Popular Recipes'),
          const SizedBox(height: 15),
          SizedBox(
            height: 170,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recipeProvider.recipes.length.clamp(0, 3),
              itemBuilder: (context, index) {
                final recipe = recipeProvider.recipes[index];
                return SingleChildScrollView(
                  child: RecipeCard(
                    imageUrl: recipe.imageUrl,
                    title: recipe.title,
                    recipe: recipe, // Pass the entire recipe object
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditorsChoice(RecipeProvider recipeProvider) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          _buildSectionHeader('Editor\'s Choice'),
          const SizedBox(height: 15),
          _buildFeaturedRecipe(
            imageUrl:
                recipeProvider.recipes.length > 2
                    ? recipeProvider.recipes[2].imageUrl
                    : '',
            title: recipeProvider.recipes[2].title,
            author: 'James Spader',
            authorImageUrl: 'https://i.pravatar.cc/150?img=20',
            recipe:
                recipeProvider.recipes.length > 2
                    ? recipeProvider.recipes[2]
                    : null, // Add this line
          ),
          const SizedBox(height: 15),
          _buildFeaturedRecipe(
            imageUrl:
                recipeProvider.recipes.length > 3
                    ? recipeProvider.recipes[3].imageUrl
                    : '',
            title: recipeProvider.recipes[3].title,
            author: 'Alice Fala',
            authorImageUrl: 'https://i.pravatar.cc/150?img=21',
            recipe:
                recipeProvider.recipes.length > 3
                    ? recipeProvider.recipes[3]
                    : null, 
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D3B35),
          ),
        ),
        Text(
          'View All',
          style: TextStyle(
            fontSize: 14,
            color: const Color(0xFF65B0B4),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedRecipe({
    required String imageUrl,
    required String title,
    required String author,
    required String authorImageUrl,
    required dynamic recipe, // Add this parameter
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
            child: Image.network(
              imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 120,
                  height: 120,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, color: Colors.grey),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D3B35),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage(authorImageUrl),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        author,
                        style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFF0D3B35),
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_forward, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => RecipeDetailScreen(
                          recipe:
                              recipe, // You'll need to pass the recipe object here
                        ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
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
