import 'package:breadcrumbs/models/user/user_meal_model.dart';
import 'package:breadcrumbs/repository/auth/auth_repository.dart';
import 'package:breadcrumbs/repository/user/user_repository.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:breadcrumbs/utils/error_handling/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MealHomeViewModel extends ChangeNotifier {
  MealHomeViewModel(
      {required UserRepository userRepository,
      required UserAuthRepository userAuthRepository})
      : _userRepository = userRepository,
        _userAuthRepository = userAuthRepository {
    User? user = _userAuthRepository.user;

    uid = (user?.uid)!;

    _fetchUserMeal();
  }

  final UserRepository _userRepository;
  final UserAuthRepository _userAuthRepository;
  List<UserMeal> userMeal = [];
  late String uid;
  DateTime date = DateTime.now();

  Future<void> onChangeDate(DateTime date) async {
    if (this.date == date) return;

    this.date = date;
    await _fetchUserMeal();
  }

  Future<void> _fetchUserMeal() async {
    final result =
        await _userRepository.getAllUserMealByDate(uid: uid, date: date);

    switch (result) {
      case Ok<List<UserMeal>>():
        userMeal = result.value;
        notifyListeners();

      case Error<List<UserMeal>>():
        return;
    }
  }

  void onNavigateToMealDetail(BuildContext context, String mealId) {
    context.push(Routes.mealRoute.mealDetail(mealId: mealId));
  }
}
