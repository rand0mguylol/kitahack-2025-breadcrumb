import 'package:breadcrumbs/models/goal/goal_model.dart';
import 'package:breadcrumbs/models/goal/user_goal_model.dart';
import 'package:breadcrumbs/models/user/user_detail_model.dart';
import 'package:breadcrumbs/repository/auth/auth_repository.dart';
import 'package:breadcrumbs/repository/goal/goal_repository.dart';
import 'package:breadcrumbs/repository/mascot/user_mascot_repository.dart';
import 'package:breadcrumbs/repository/user/user_repository.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:breadcrumbs/services/goal/goal_service.dart';
import 'package:breadcrumbs/services/goal/user_goal_service.dart';
import 'package:breadcrumbs/utils/error_handling/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreenViewModel extends ChangeNotifier {
  SplashScreenViewModel(
      {required UserAuthRepository userAuthRepository,
      required this.goalService,
      required this.userGoalService,
      required this.userRepository,
      required this.userMascotRepository,
      required this.goalRepository})
      : _userAuthRepository = userAuthRepository {}

  final UserAuthRepository _userAuthRepository;
  final UserRepository userRepository;
  final UserMascotRepository userMascotRepository;
  final GoalRepository goalRepository;
  final GoalService goalService;
  final UserGoalService userGoalService;

  bool isInit = true;
  bool status = false;

  Future<String> checkLoginStatus() async {
    final user = _userAuthRepository.user;

    if (user != null) {
      String uid = user.uid;

      bool? isOnboarded = await _checkOnboardingStatus(uid);

      if (isOnboarded == null) return Routes.landing.landingScreen;

      if (!isOnboarded) return Routes.landing.userOnboard;

      await _initUserNutrition(uid);
      await _initUserMascot(uid);
      await initUserGoal(uid: uid);
      return Routes.home.home;
    }

    return Routes.landing.landingScreen;
  }

  Future<void> _initUserNutrition(String uid) async {
    await userRepository.initUserNutrition(uid: uid);
  }

  Future<void> _initUserMascot(String uid) async {
    await userMascotRepository.getUserMascot(uid: uid);
  }

  Future<bool?> _checkOnboardingStatus(String uid) async {
    final results = await userRepository.getUserDetail(uid: uid);

    switch (results) {
      case Ok<UserDetail?>():
        if (results.value == null) return false;
        return true;
      case Error<UserDetail?>():
        return null;
    }
  }

  Future<void> initUserGoal({required String uid}) async {
    List<UserGoal> userGoals =
        await userGoalService.getUserGoalByDate(uid: uid, date: DateTime.now());

    if (userGoals.isNotEmpty) {
      return;
    }

    DocumentReference<Goal> goal =
        await goalService.getGoalByType(type: "target");

    UserGoal newUG = UserGoal(
      uid: uid,
      goalRef: goal,
      isCompleted: false,
      startDate: Timestamp.now(),
      endDate: Timestamp.now(),
    );

    await userGoalService.addUserGoal(userGoal: newUG);
  }
}
