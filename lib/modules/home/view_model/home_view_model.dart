import 'package:breadcrumbs/models/mascot/user_mascot_model.dart';
import 'package:breadcrumbs/models/user/user_detail_model.dart';
import 'package:breadcrumbs/models/user/user_nutrition_model.dart';
import 'package:breadcrumbs/modules/home/view/home_screen.dart';
import 'package:breadcrumbs/repository/mascot/user_mascot_repository.dart';
import 'package:breadcrumbs/repository/user/user_repository.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:breadcrumbs/repository/auth/auth_repository.dart';
import 'package:breadcrumbs/utils/alert/alert.dart';
import 'package:breadcrumbs/utils/error_handling/exception.dart';
import 'package:breadcrumbs/utils/error_handling/result.dart';
import 'package:breadcrumbs/utils/validator/validator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class NutritionSnippet {
  String text;
  String value;
  String unit;

  NutritionSnippet(
      {required this.text, required this.value, required this.unit});
}

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({
    required UserRepository userRepository,
    required UserAuthRepository userAuthRepository,
    required this.userMascotRepository,
  })  : _userRepository = userRepository,
        _userAuthRepository = userAuthRepository {
    _init();
  }

  final UserRepository _userRepository;
  final UserAuthRepository _userAuthRepository;
  final UserMascotRepository userMascotRepository;
  MascotEnum mascotType = MascotEnum.sparky;

  bool isLoading = true;
  bool isError = false;
  String errorMessage = '';
  String displayName = '';

  late UserMascot userMascot;

  List<NutritionSnippet> nutritionSnippet = [];

  late UserDetail? _userDetail;
  UserDetail? get userDetail => _userDetail;

  late UserNutrition? _userNutrition;
  UserNutrition? get userNutrition => _userNutrition;

  late double _caloriesLeft;
  double get caloriesLeft => _caloriesLeft;

  late double _caloriesEaten;
  double get caloriesEaten => _caloriesEaten;

  late double _progressValue;
  double get progressValue => _progressValue;

  void changeState() {
    notifyListeners();
  }

  void _init() async {
    // Await both futures to complete using future.wait
    try {
      await Future.wait([
        _initUserDetail(),
        _initUserNutrition(),
      ]);

      userMascot = userMascotRepository.userMascot!;

      _initNutritionSnippet();

      _caloriesLeft = _userDetail!.nutrition!.calories! -
          _userNutrition!.nutrition!.calories!;

      _caloriesEaten = _userNutrition!.nutrition!.calories!;

      _progressValue = (_caloriesEaten / (_userDetail?.nutrition?.calories)!);

      isLoading = false;

      mascotType = userMascotRepository.selectedMascot;
      print("MASCOT TYPE HOME: ${mascotType}");

      displayName = _userDetail!.displayName!;

      notifyListeners();
    } catch (e) {
      isError = true;
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _initUserDetail() async {
    final user = _userAuthRepository.user;
    final result = await _userRepository.getUserDetail(uid: user!.uid);

    switch (result) {
      case Ok<UserDetail?>():
        _userDetail = result.value;
        break;

      case Error<UserDetail?>():
        errorMessage = 'User Detail';
        throw CustomException(
          message: "User Detail",
          code: "something-went-wrong",
        );
    }
  }

  Future<void> _initUserNutrition() async {
    final user = _userAuthRepository.user;
    final result = await _userRepository.getTodayUserNutrition(uid: user!.uid);

    switch (result) {
      case Ok<UserNutrition>():
        _userNutrition = result.value;
        break;

      case Error<UserNutrition>():
        errorMessage = 'User Nutrition';

        throw CustomException(
          message: "User Nutrition",
          code: "something-went-wrong",
        );
    }
  }

  void _initNutritionSnippet() async {
    nutritionSnippet = [
      NutritionSnippet(
          text: 'Fats',
          value: _userNutrition!.nutrition!.fats!.toStringAsFixed(2),
          unit: 'g'),
      NutritionSnippet(
          text: 'Proteins',
          value: _userNutrition!.nutrition!.proteins!.toStringAsFixed(2),
          unit: 'g'),
      NutritionSnippet(
          text: 'Carbs',
          value: _userNutrition!.nutrition!.carbohydrates!.toStringAsFixed(2),
          unit: 'g'),
      NutritionSnippet(
          text: 'Sugar',
          value: _userNutrition!.nutrition!.sugars!.toStringAsFixed(2),
          unit: 'g'),
    ];
  }
}
