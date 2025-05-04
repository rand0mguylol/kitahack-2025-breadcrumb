import 'package:breadcrumbs/models/food_database/food_database_model.dart';
import 'package:breadcrumbs/models/nutrition/nutrition.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:breadcrumbs/services/food_database/food_database_service.dart';
import 'package:breadcrumbs/utils/alert/alert.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FoodDatabaseAddViewModel extends ChangeNotifier {
  FoodDatabaseAddViewModel({required this.foodDatabaseService});

  String? title;
  double? calories;
  double? carbs;
  double? protein;
  double? sodium;
  double? sugar;
  double? fat;

  final FoodDatabaseService foodDatabaseService;

  void setTitle(String value) {
    title = value;
  }

  void setFat(double value) {
    fat = value;
  }

  // Set function for calories
  void setCalories(double value) {
    calories = value;
  }

  // Set function for carbs
  void setCarbs(double value) {
    carbs = value;
  }

  // Set function for protein
  void setProtein(double value) {
    protein = value;
  }

  // Set function for sodium
  void setSodium(double value) {
    sodium = value;
  }

  // Set function for sugar
  void setSugar(double value) {
    sugar = value;
  }

  Future<void> onClickAdd(
      BuildContext context, GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final alert = Alert.of(context);

    FoodDatabaseModel model = FoodDatabaseModel(
        title: title,
        nutrition: Nutrition(
            calories: calories,
            cholesterol: -1,
            carbohydrates: carbs,
            fats: fat,
            proteins: protein,
            saturatedFats: -1,
            sugars: sugar,
            fibers: -1,
            transFat: -1,
            unsaturatedFats: -1,
            sodium: sodium,
            vitamins: Vitamin(
              a: -1,
              b: -1,
              c: -1,
              d: -1,
              e: -1,
              k: -1,
            )));

    try {
      await foodDatabaseService.addFoodDatabase(foodDatabaseModel: model);

      if (context.mounted) {
        context.go(Routes.home.home);

        alert.showSuccess('Food added');
      }
    } catch (e) {
      alert.showError('Something went wrong');
      return;
    }
  }
}
