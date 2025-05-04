import 'package:breadcrumbs/models/food_database/food_database_model.dart';
import 'package:breadcrumbs/modules/food_database/view_model/food_database_home_view_model.dart';
import 'package:breadcrumbs/repository/food_database/food_database_repository.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FoodDatabaseHomeScreen extends StatelessWidget {
  const FoodDatabaseHomeScreen(
      {super.key,
      required this.foodDatabaseHomeViewModel,
      required this.foodDatabaseRepository});

  final FoodDatabaseHomeViewModel foodDatabaseHomeViewModel;
  final FoodDatabaseRepository foodDatabaseRepository;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemWidth = (size.width - 12 - 16) / 2;
    final double itemHeight = itemWidth * 0.8;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(Routes.foodDatabaseRoute.foodDatabaseAdd);
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Database',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListenableBuilder(
            listenable: foodDatabaseHomeViewModel,
            builder: (BuildContext context, Widget? child) {
              if (foodDatabaseHomeViewModel.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (foodDatabaseHomeViewModel.isError) {
                return Center(
                  child: Text('Something went wrong'),
                );
              }
              return Column(
                spacing: 16,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Background color
                        borderRadius:
                            BorderRadius.circular(30), // Rounded corners
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: "Feature coming soon...",
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none, // Remove default border
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20), // Padding inside the field
                        ),
                      ),
                    ),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 16,
                    crossAxisCount: 2,
                    childAspectRatio: itemWidth / itemHeight,
                    children: foodDatabaseHomeViewModel.foodItemList
                        .map((element) => _buildCard(context,
                            model: element,
                            id: '1',
                            brand: 'La Juceria',
                            name: element.title ?? '',
                            calories: element.nutrition?.calories ?? 0))
                        .toList(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required String id,
      required FoodDatabaseModel model,
      String image = 'assets/images/meal/phone_1.png',
      String name = "Spicy Chicken Mcdeluxe",
      double calories = 1000,
      String brand = 'Mcdonald'}) {
    return GestureDetector(
      onTap: () async {
        foodDatabaseRepository.foodDatabaseModel = model;
        context.push(Routes.foodDatabaseRoute.foodDatabaseDetail);
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: 166,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.2)),
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${calories.toStringAsFixed(0)} kcal',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.star,
                    size: 16,
                    color: Colors.orangeAccent,
                  ),
                  Text(
                    '0',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
