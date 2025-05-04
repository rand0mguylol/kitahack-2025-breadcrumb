import 'package:breadcrumbs/constants/dropdown/form.dart';
import 'package:breadcrumbs/models/meal_planner/meal_plan_item_model.dart';
import 'package:breadcrumbs/repository/auth/auth_repository.dart';
import 'package:breadcrumbs/repository/firebase_function/firebase_function_repository.dart';
import 'package:breadcrumbs/repository/user/user_repository.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:breadcrumbs/services/meal_planner/meal_planner_service.dart';
import 'package:breadcrumbs/types/request/request.dart';
import 'package:breadcrumbs/types/response/response.dart';
import 'package:breadcrumbs/utils/alert/alert.dart';
import 'package:breadcrumbs/utils/error_handling/exception.dart';
import 'package:breadcrumbs/utils/error_handling/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MealPlannerAddViewModel extends ChangeNotifier {
  MealPlannerAddViewModel(
      {required this.userRepository,
      required this.firebaseFunctionRepository,
      required this.userAuthRepository,
      required this.mealPlannerService});

  final UserRepository userRepository;
  final FirebaseFunctionRepository firebaseFunctionRepository;
  final MealPlannerService mealPlannerService;
  final UserAuthRepository userAuthRepository;

  double? budget;

  String goal = mealPlannerGoalEntries.first.value;

  DateTime date = DateTime.now();

  void setBudget(double value) {
    budget = value;
  }

  void setGoal(String value) {
    goal = value;
  }

  void setDate(DateTime date) {
    if (this.date == date) return;
    this.date = date;
    notifyListeners();
  }

  String? validateNumberField(String? value, String message) {
    if (value == null) return message;

    double? convert = double.tryParse(value);

    if (convert == null) return message;

    return null;
  }

  Future<void> onAddMealPlanner(
      BuildContext context, GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final alert = Alert.of(context);

    GenerateMealPlannerRequest mealPlannerRequest = GenerateMealPlannerRequest(
        date: date.millisecondsSinceEpoch,
        budget: budget!,
        goal: goal,
        userDetail: userRepository.userDetail!);

    print("MEAL PLANNER: ${mealPlannerRequest.userDetail.nutrition?.calories}");

    Result<MealPlanResponse<MealPlanItemModel>> result =
        await firebaseFunctionRepository.generateMealPlan(
            generateMealPlanRequest: mealPlannerRequest);

    switch (result) {
      case Ok<MealPlanResponse<MealPlanItemModel>>():
        print(result.value);

      case Error<MealPlanResponse<MealPlanItemModel>>():
        CustomException exception = result.error as CustomException;
        print(exception.message);
        alert.showError('Something went wrong');
        return;
    }

    final User? user = userAuthRepository.user;

    try {
      MealPlanItemModel newMealPlan = result.value.value;
      newMealPlan.uid = user!.uid;
      newMealPlan.date = Timestamp.fromDate(date);
      await mealPlannerService.addMealPlanItem(
          mealPlanItemModel: result.value.value);

      if (context.mounted) {
        context.go(Routes.home.home);

        alert.showSuccess('Meal Plan Created');
      }
    } catch (e) {
      alert.showError('Something went wrong');
      print("FUCK");
    }
  }
}
