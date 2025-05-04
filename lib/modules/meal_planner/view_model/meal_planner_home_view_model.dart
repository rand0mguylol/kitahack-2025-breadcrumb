import 'package:breadcrumbs/models/meal_planner/meal_plan_item_model.dart';
import 'package:breadcrumbs/repository/auth/auth_repository.dart';
import 'package:breadcrumbs/repository/firebase_function/firebase_function_repository.dart';
import 'package:breadcrumbs/repository/meal_planner/meal_planner_repository.dart';
import 'package:breadcrumbs/repository/user/user_repository.dart';
import 'package:breadcrumbs/services/meal_planner/meal_planner_service.dart';
import 'package:breadcrumbs/services/user/user_meal_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MealPlannerViewModel extends ChangeNotifier {
  MealPlannerViewModel(
      {required this.mealPlannerService,
      required this.userAuthRepository,
      required this.mealPlannerRepository}) {
    initUserMealPlan();
  }

  final MealPlannerService mealPlannerService;
  final UserAuthRepository userAuthRepository;
  final MealPlannerRepository mealPlannerRepository;

  MealPlanItemModel? userMeal;
  DateTime date = DateTime.now();

  bool isError = false;
  bool isLoading = true;

  Future<void> onChangeDate(DateTime date) async {
    if (this.date == date) return;

    this.date = date;
    isLoading = true;

    notifyListeners();
    initUserMealPlan();
  }

  Future<void> initUserMealPlan() async {
    User? user = userAuthRepository.user;

    try {
      MealPlanItemModel? getMeal = await mealPlannerService.getSingleMealPlan(
          date: date, uid: user!.uid);

      // if(getMeal)

      userMeal = getMeal;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isError = true;
      isLoading = false;
      notifyListeners();
    }
  }
}
