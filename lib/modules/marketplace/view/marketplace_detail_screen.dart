import 'dart:convert';

import 'package:breadcrumbs/constants/dropdown/form.dart';
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

class MarketplaceDetailScreen extends StatelessWidget {
  const MarketplaceDetailScreen({super.key, required this.foodId});

  final String foodId;

  Widget build(BuildContext context) {
    final element = LJList.firstWhere((item) => item['id'] == foodId);

    final nutritionMap = {
      'Calories': element['nutrition']['calories'] ?? 'N/A',
      'Carbohydrates': element['nutrition']['carbs'] ?? 'N/A',
      'Fats': element['nutrition']['fats'] ?? 'N/A',
      'Proteins': element['nutrition']['protein'] ?? 'N/A',
    };
    return Scaffold(
      appBar: CustomAppBar(
        title: "Marketplace",
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
                      element['image'] ?? 'assets/images/brand/nissin1.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    element['title'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    element['price'],
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Restaurant: La Juceria',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Nutrition Information',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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
