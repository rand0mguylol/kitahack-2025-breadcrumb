import 'package:breadcrumbs/models/food_database/food_database_model.dart';
import 'package:breadcrumbs/modules/food_database/view_model/food_database_home_view_model.dart';
import 'package:breadcrumbs/repository/food_database/food_database_repository.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FoodDatabaseDetailScreen extends StatelessWidget {
  const FoodDatabaseDetailScreen(
      {super.key, required this.foodDatabaseRepository});
  final FoodDatabaseRepository foodDatabaseRepository;

  @override
  Widget build(BuildContext context) {
    final FoodDatabaseModel model = foodDatabaseRepository.foodDatabaseModel!;
    final nutritionMap = {
      'Calories': model.nutrition?.calories ?? 'N/A',
      'Cholesterol': 'N/A',
      'Carbohydrates': model.nutrition?.carbohydrates ?? 'N/A',
      'Fats': model.nutrition?.fats ?? 'N/A',
      'Proteins': model.nutrition?.proteins ?? 'N/A',
      'Saturated Fat': 'N/A',
      'Sugars': model.nutrition?.sugars ?? 'N/A',
      'Fibers': 'N/A',
      'Trans Fat': 'N/A',
      'Unsaturated Fat': 'N/A',
      'Sodium': model.nutrition?.sodium ?? 'N/A',
    };

    return Scaffold(
        appBar: CustomAppBar(
          title: 'Detail',
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: Container(
              child: Column(
                children: [
                  Text(
                    model.title ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    'Nutrition Information',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(16)),
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final entry = nutritionMap.entries.elementAt(index);
                          final key = entry.key; // The key (e.g., 'calories')
                          final value = entry.value; //

                          return ListTile(
                            title: Text(
                              key[0].toUpperCase() +
                                  key.substring(1), // Capitalize the key
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            trailing: Text(
                              (value.toString()),
                            ), // Display the value
                          );
                        },
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: nutritionMap.length),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
