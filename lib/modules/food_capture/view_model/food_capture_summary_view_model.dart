import 'package:breadcrumbs/models/nutrition/nutrition.dart';
import 'package:breadcrumbs/models/user/user_meal_model.dart';
import 'package:breadcrumbs/models/user/user_nutrition_model.dart';
import 'package:breadcrumbs/repository/analyse/analyse_repository.dart';
import 'package:breadcrumbs/repository/auth/auth_repository.dart';
import 'package:breadcrumbs/repository/user/user_repository.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:breadcrumbs/utils/alert/alert.dart';
import 'package:breadcrumbs/utils/error_handling/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FoodCaptureSummaryViewModel extends ChangeNotifier {
  FoodCaptureSummaryViewModel({
    required AnalyseRepository analyseRepository,
    required UserAuthRepository userAuthRepository,
    required UserRepository userRepository,
  })  : _analyseRepository = analyseRepository,
        _userAuthRepository = userAuthRepository,
        _userRepository = userRepository {
    nutrition = _analyseRepository.nutrition;
    additionalContext = _analyseRepository.additionalContext;
    insights = _analyseRepository.insights;
  }

  final AnalyseRepository _analyseRepository;
  final UserAuthRepository _userAuthRepository;
  final UserRepository _userRepository;

  late Nutrition nutrition;
  late AdditionalContext additionalContext;
  late String insights;

  Future<void> onAddToTracker(BuildContext context) async {
    final alert = Alert.of(context);
    User? user = _userAuthRepository.user;

    String uid = (user?.uid)!;

    Result<UserMeal> result = await _userRepository.addUserMeal(
      uid: uid,
      nutrition: nutrition,
      additionalContext: additionalContext,
      insights: insights,
    );

    UserMeal? userMeal;

    // if (context.mounted) {
    switch (result) {
      case Ok<UserMeal>():
        userMeal = result.value;
        // alert.showSuccess("Meal saved!");
        break;
      case Error<UserMeal>():
        alert.showError("Something went wrong");
        return;
    }
    // }

    Result<UserNutrition> userNutResult =
        await _userRepository.updateUserNutritionWithMeal(userMeal: userMeal);

    if (context.mounted) {
      switch (userNutResult) {
        case Ok<UserNutrition>():
          alert.showSuccess("Meal saved!");
          context.go(Routes.home.home,
              extra: DateTime.now().millisecondsSinceEpoch);
          break;
        case Error<UserNutrition>():
          alert.showError("Something went wrong");
          return;
      }
    }
  }
}
