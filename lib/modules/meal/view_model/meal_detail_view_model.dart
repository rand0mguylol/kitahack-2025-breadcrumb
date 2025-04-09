import 'package:breadcrumbs/models/user/user_meal_model.dart';
import 'package:breadcrumbs/repository/user/user_repository.dart';
import 'package:breadcrumbs/utils/error_handling/result.dart';
import 'package:flutter/material.dart';

class MealDetailViewModel extends ChangeNotifier {
  MealDetailViewModel(
      {required UserRepository userRepository, required this.mealId})
      : _userRepository = userRepository {
    loadUserMeal(mealId);
  }

  final UserRepository _userRepository;
  final String mealId;

  UserMeal? userMeal;

  Future<void> loadUserMeal(String mealId) async {
    final result = await _userRepository.getSingleUserMeal(mealId: mealId);

    switch (result) {
      case Ok<UserMeal>():
        userMeal = result.value;
        notifyListeners();
      case Error<UserMeal>():
        return;
    }
  }
}
