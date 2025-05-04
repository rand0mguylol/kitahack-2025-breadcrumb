import 'dart:convert';

import 'package:breadcrumbs/models/meal_planner/meal_plan_item_model.dart';
import 'package:breadcrumbs/modules/meal_planner/view_model/meal_planner_home_view_model.dart';
import 'package:breadcrumbs/repository/meal_planner/meal_planner_repository.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:breadcrumbs/utils/alert/alert.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:breadcrumbs/widgets/date/scrollable_day_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

// class MealPlannerRecipeScreen extends

final imageMap = {
  'BREAKFAST': 'assets/images/meal_planner/meal_planner_breakfast.jpg',
  'LUNCH': 'assets/images/meal_planner/meal_planner_lunch.jpg',
  'DINNER': 'assets/images/meal_planner/meal_planner_dinner.jpg',
  'SNACK': 'assets/images/meal_planner/meal_planner_snack.jpg'
};

class MealPlannerRecipeScreen extends StatelessWidget {
  MealPlannerRecipeScreen({super.key, required this.mealPlannerRepository});

  final MealPlannerRepository mealPlannerRepository;

  @override
  Widget build(BuildContext context) {
    final IMealPlanItem recipe = mealPlannerRepository.recipe!;
    final nutritionMap = {
      'Calories': recipe.nutrition?.calories ?? 'N/A',
      'Cholesterol': recipe.nutrition?.cholesterol ?? 'N/A',
      'Carbohydrates': recipe.nutrition?.carbohydrates ?? 'N/A',
      'Fats': recipe.nutrition?.fats ?? 'N/A',
      'Proteins': recipe.nutrition?.proteins ?? 'N/A',
      'Saturated Fat': recipe.nutrition?.saturatedFats ?? 'N/A',
      'Sugars': recipe.nutrition?.sugars ?? 'N/A',
      'Fibers': recipe.nutrition?.fibers ?? 'N/A',
      'Trans Fat': recipe.nutrition?.transFat ?? 'N/A',
      'Unsaturated Fat': recipe.nutrition?.unsaturatedFats ?? 'N/A',
      'Sodium': recipe.nutrition?.sodium ?? 'N/A',
    };

    // final nutritionMapList = [
    //   {'name, '},
    // ]
    return Scaffold(
      appBar: CustomAppBar(
        title: "Recipe",
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          child: Container(
            child: Column(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(16)),
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      imageMap[recipe.mealType ?? ''] ??
                          'assets/images/brand/nissin1.png',
                      // recipe.mealType == 'BREAKFAST'
                      //     ? 'assets/images/meal_planner/meal_planner_breakfast.jpg'
                      //     : 'assets/images/brand/nissin1.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                MarkdownBody(
                  data: recipe.description ?? '',
                ),
                const SizedBox(
                  height: 24,
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
      ),
    );
  }
}
