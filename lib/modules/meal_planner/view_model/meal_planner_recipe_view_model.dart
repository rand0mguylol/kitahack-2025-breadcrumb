import 'package:breadcrumbs/models/meal_planner/meal_plan_item_model.dart';
import 'package:breadcrumbs/repository/auth/auth_repository.dart';
import 'package:breadcrumbs/repository/firebase_function/firebase_function_repository.dart';
import 'package:breadcrumbs/repository/meal_planner/meal_planner_repository.dart';
import 'package:breadcrumbs/repository/user/user_repository.dart';
import 'package:breadcrumbs/services/meal_planner/meal_planner_service.dart';
import 'package:breadcrumbs/services/user/user_meal_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MealPlannerRecipeViewModel extends ChangeNotifier {
  MealPlannerRecipeViewModel({required this.mealPlannerRepository});

  final MealPlannerRepository mealPlannerRepository;
}
