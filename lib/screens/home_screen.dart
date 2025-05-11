import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import '../widgets/recipe_card.dart';
import '../widgets/category_chip.dart';
import '../widgets/bottom_navigation.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch data when screen loads
    Future.microtask(
      () => Provider.of<RecipeProvider>(context, listen: false).fetchRecipes(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<RecipeProvider>(
          builder: (context, recipeProvider, child) {
            if (recipeProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (recipeProvider.error.isNotEmpty) {
              return Center(child: Text('Error: ${recipeProvider.error}'));
            }

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/sun_icon.png', // Make sure this icon exists in your assets
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Good Morning',
                                  style: TextStyle(
                                    fontFamily: 'SofiaPro',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Alena Sabyan',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    fontFamily: 'SofiaPro',
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold
                                    ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/Buy.svg',
                            width: 28,
                            height: 28,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),

              // Add spacing here
                SliverToBoxAdapter(
                  child: const SizedBox(height: 16.0)
                  ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Featured',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                  // Add spacing here
                SliverToBoxAdapter(
                  child: const SizedBox(height: 16.0),
                ),

                // Featured recipes
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: recipeProvider.featuredRecipes.length,
                      itemBuilder: (context, index) {
                        final recipe = recipeProvider.featuredRecipes[index];
                        return Container(
                          width: 300,
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF70B9BE),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      recipe.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                  
                                        CircleAvatar(
                                          radius: 12,
                                          backgroundImage: NetworkImage(
                                            'https://i.pravatar.cc/150?img=${10 + index}',
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          recipe.chef,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),

                                        const Spacer(),

                                        const Icon(
                                          Icons.access_time,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${recipe.cookTime} Min',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Categories
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Category',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'See All',
                                style: TextStyle(
                                  color: Color(0xFF70B9BE),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 40,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children:
                                recipeProvider.categories.map((category) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: CategoryChip(
                                      category: category,
                                      isSelected: category == 'Breakfast',
                                      onTap: () {},
                                    ),
                                  );
                                }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Popular recipes
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Popular Recipes',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'See All',
                            style: TextStyle(
                              color: Color(0xFF70B9BE),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // SliverPadding(
                //   padding: const EdgeInsets.all(16.0),
                //   sliver: SliverGrid(
                //     gridDelegate:
                //         const SliverGridDelegateWithFixedCrossAxisCount(
                //           crossAxisCount: 2,
                //           crossAxisSpacing: 16.0,
                //           mainAxisSpacing: 16.0,
                //           childAspectRatio: 0.78,
                //         ),
                //     delegate: SliverChildBuilderDelegate((context, index) {
                //       if (index >= recipeProvider.recipes.length) {
                //         return null;
                //       }
                //       final recipe = recipeProvider.recipes[index];
                //       return RecipeCard(recipe: recipe);
                //     }, childCount: recipeProvider.recipes.length.clamp(0, 4)),
                //   ),
                // ),
                SliverToBoxAdapter(child: PopularRecipesSection()),

              ],
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 0),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        child: const Icon(Icons.restaurant_menu, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}


// Popular Recipes Section (Image 1)
class PopularRecipesSection extends StatelessWidget {
  const PopularRecipesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    final featuredRecipes = recipeProvider.featuredRecipes;
    final isLoading = recipeProvider.isLoading;

    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 16.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(
        //         'Popular Recipes',
        //         style: TextStyle(
        //           fontSize: 20,
        //           fontWeight: FontWeight.bold,
        //           color: Color(0xFF2D4654),
        //         ),
        //       ),
        //       Text(
        //         'See All',
        //         style: TextStyle(
        //           fontSize: 14,
        //           color: Colors.teal,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        if (isLoading)
          Container(
            height: 180,
            child: Center(child: CircularProgressIndicator()),
          )
        else if (featuredRecipes.isEmpty)
          Container(
            height: 180,
            child: Center(child: Text('No recipes available')),
          )
        else
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: featuredRecipes.length,
              itemBuilder: (context, index) {
                final recipe = featuredRecipes[index];
                return Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: RecipeCard(
                    recipe: recipe,
                    onFavoriteToggle: () {
                      recipeProvider.toggleFavorite(recipe.id);
                    },
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}