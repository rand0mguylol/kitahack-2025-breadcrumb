import 'dart:io';

import 'package:breadcrumbs/models/nutrition/nutrition.dart';
import 'package:breadcrumbs/models/user/user_detail_model.dart';
import 'package:breadcrumbs/models/user/user_nutrition_model.dart';
import 'package:breadcrumbs/repository/auth/auth_repository.dart';
import 'package:breadcrumbs/repository/user/user_repository.dart';
import 'package:breadcrumbs/utils/error_handling/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TrackerHomeViewModel extends ChangeNotifier {
  TrackerHomeViewModel(
      {required this.userRepository, required this.userAuthRepository}) {
    // userNutrition = userRepository.userNutrition ?? UserNutrition();
    userDetail = userRepository.userDetail ?? UserDetail();
    initData();
  }

  DateTime date = DateTime.now();

  bool isError = false;
  bool isLoading = true;
  final UserRepository userRepository;
  UserNutrition? userNutrition;
  UserDetail? userDetail;
  final UserAuthRepository userAuthRepository;
  final String test = 'test';
  List<NutritionDisplay> mainNutrition = [];
  List<NutritionDisplay> subNutrition = [];
  List<NutritionDisplay> vitaminList = [];

  Future<void> onChangeDate(DateTime date) async {
    if (this.date == date) return;

    this.date = date;
    initData();
    // await _fetchUserMeal();
  }

  Future<void> onRefresh() async {
    initData();
  }

  void initData() async {
    User? user = userAuthRepository.user;
    String uid = user!.uid;

    final result =
        await userRepository.getUserNutritionBySingleDate(date: date, uid: uid);

    switch (result) {
      case Ok<UserNutrition?>():
        userNutrition = result.value;
      case Error<UserNutrition?>():
        isError = true;
    }

    if (userNutrition == null) {
      notifyListeners();
      return;
    }

    _initMainNutrition();
    _initSubNutrition();
    _initVitamin();
    notifyListeners();
  }

  void _initMainNutrition() {
    final Nutrition nutritionLimit = userDetail!.nutrition!;
    final Nutrition nutritionConsumed = userNutrition!.nutrition!;

    final carbs = NutritionDisplay(
        limit: nutritionLimit.carbohydrates!,
        consumed: nutritionConsumed.carbohydrates!,
        text: 'Carbohydrates',
        unit: 'g');

    final fats = NutritionDisplay(
        limit: nutritionLimit.fats!,
        consumed: nutritionConsumed.fats!,
        text: 'Fats',
        unit: 'g');

    final protein = NutritionDisplay(
        limit: nutritionLimit.proteins!,
        consumed: nutritionConsumed.proteins!,
        text: 'Proteins',
        unit: 'g');

    final sodium = NutritionDisplay(
        limit: nutritionLimit.sodium!,
        consumed: nutritionConsumed.sodium!,
        text: 'Sodium',
        unit: 'mg');

    final cholesterol = NutritionDisplay(
        limit: nutritionLimit.cholesterol!,
        consumed: nutritionConsumed.cholesterol!,
        text: 'Cholesterol',
        unit: 'g');

    mainNutrition = [carbs, fats, protein, sodium, cholesterol];
  }

  void _initSubNutrition() {
    final Nutrition nutritionLimit = userDetail!.nutrition!;
    final Nutrition nutritionConsumed = userNutrition!.nutrition!;

    final sugar = NutritionDisplay(
        limit: nutritionLimit.sugars!,
        consumed: nutritionConsumed.sugars!,
        text: 'Sugar',
        unit: 'g');
    final fibers = NutritionDisplay(
        limit: nutritionLimit.fibers!,
        consumed: nutritionConsumed.fibers!,
        text: 'Fibers',
        unit: 'g');
    final transFat = NutritionDisplay(
        limit: nutritionLimit.transFat!,
        consumed: nutritionConsumed.transFat!,
        text: 'Trans Fat',
        unit: 'g');
    final saturatedFat = NutritionDisplay(
        limit: nutritionLimit.saturatedFats!,
        consumed: nutritionConsumed.saturatedFats!,
        text: 'Saturated Fats',
        unit: 'g');
    final unsaturatedFat = NutritionDisplay(
        limit: nutritionLimit.unsaturatedFats!,
        consumed: nutritionConsumed.unsaturatedFats!,
        text: 'Unsaturated Fats',
        unit: 'g');

    subNutrition = [sugar, fibers, transFat, saturatedFat, unsaturatedFat];
  }

  void _initVitamin() {
    final Vitamin vitaminLimit = userDetail!.nutrition!.vitamins!;
    final Vitamin vitaminConsumed = userNutrition!.nutrition!.vitamins!;

    final a = NutritionDisplay(
        limit: vitaminLimit.a!,
        consumed: vitaminConsumed.a!,
        text: 'A',
        unit: 'mcg');
    final b = NutritionDisplay(
        limit: vitaminLimit.b!,
        consumed: vitaminConsumed.b!,
        text: 'B',
        unit: 'mg');
    final c = NutritionDisplay(
        limit: vitaminLimit.c!,
        consumed: vitaminConsumed.c!,
        text: 'C',
        unit: 'mcg');
    final d = NutritionDisplay(
        limit: vitaminLimit.d!,
        consumed: vitaminConsumed.d!,
        text: 'D',
        unit: 'mcg');
    final e = NutritionDisplay(
        limit: vitaminLimit.e!,
        consumed: vitaminConsumed.e!,
        text: 'E',
        unit: 'mg');
    final k = NutritionDisplay(
        limit: vitaminLimit.k!,
        consumed: vitaminConsumed.k!,
        text: 'K',
        unit: 'mcg');

    vitaminList = [a, b, c, d, e, k];
  }
}
