import 'package:breadcrumbs/models/goal/goal_model.dart';
import 'package:breadcrumbs/models/goal/user_goal_model.dart';
import 'package:breadcrumbs/models/mascot/user_mascot_model.dart';
import 'package:breadcrumbs/models/user/user_meal_model.dart';
import 'package:breadcrumbs/repository/auth/auth_repository.dart';
import 'package:breadcrumbs/repository/goal/goal_repository.dart';
import 'package:breadcrumbs/repository/mascot/user_mascot_repository.dart';
import 'package:breadcrumbs/repository/user/user_repository.dart';
import 'package:breadcrumbs/utils/alert/alert.dart';
import 'package:breadcrumbs/utils/error_handling/exception.dart';
import 'package:breadcrumbs/utils/error_handling/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MascotHomeViewModel extends ChangeNotifier {
  MascotHomeViewModel(
      {required this.goalRepository,
      required this.userAuthRepository,
      required this.userRepository,
      required this.userMascotRepository}) {
    userMascot = userMascotRepository.userMascot!;
    initData();
  }

  final GoalRepository goalRepository;
  late List<UserGoal> userGoalsList;
  late List<Goal> goalList;
  final UserAuthRepository userAuthRepository;
  final UserRepository userRepository;
  final UserMascotRepository userMascotRepository;
  late UserMascot userMascot;

  bool isLoading = true;
  bool isError = false;

  Future<void> initData() async {
    User? user = userAuthRepository.user;
    String uid = user!.uid;

    userGoalsList = [];
    goalList = [];

    Result<List<UserGoal>> result =
        await goalRepository.getAllUserGoalsList(uid: uid);

    switch (result) {
      case Ok<List<UserGoal>>():
        userGoalsList = result.value;

      case Error<List<UserGoal>>():
        isLoading = false;
        isError = true;
        notifyListeners();
        return;
    }

    for (UserGoal userGoal in userGoalsList) {
      final goalSnapshot = await userGoal.goalRef.get();
      final goal = goalSnapshot.data();

      if (goal != null) {
        goalList.add(goal);
      }
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> checkGoalCompletion(
      {required Goal goal,
      required UserGoal userGoal,
      required BuildContext context}) async {
    if (goal.type == 'target') {
      await _checkGoalTypeTarget(goal: userGoal, context: context, g: goal);
      return;
    }

    return;
  }

  Future<void> _checkGoalTypeTarget(
      {required UserGoal goal,
      required Goal g,
      required BuildContext context}) async {
    User? user = userAuthRepository.user;
    String uid = user!.uid;
    final alert = Alert.of(context);

    Result<List<UserMeal>> result = await userRepository.getAllUserMealByDate(
        uid: uid, date: DateTime.now());

    switch (result) {
      case Ok<List<UserMeal>>():
        if (result.value.isEmpty) {
          alert.showError("No meals found for today");
          return;
        }

      case Error<List<UserMeal>>():
        CustomException error = result.error as CustomException;
        alert.showError(error.displayMessage);
        return;
    }

    UserGoal updatedUserGoal = goal.copyWith(
      isCompleted: true,
    );

    Result<UserGoal> updateResult =
        await goalRepository.updateUserGoal(userGoal: updatedUserGoal);

    switch (updateResult) {
      case Ok<UserGoal>():
        break;
      // alert.showSuccess("Goal updated successfully");
      // initData();
      // // notifyListeners();
      // return;
      case Error<UserGoal>():
        CustomException error = updateResult.error as CustomException;
        alert.showError(error.displayMessage);
        return;
    }

    int newHealth = userMascot.health + g.point;
    UserMascot updatedUserMascot = userMascot.copyWith(health: newHealth);

    Result<UserMascot> updateMascotResult = await userMascotRepository
        .updateUserMascot(userMascot: updatedUserMascot);

    switch (updateMascotResult) {
      case Ok<UserMascot>():
        alert.showSuccess("Goal updated successfully");
        userMascot = userMascotRepository.userMascot!;
        initData();
        return;
      case Error<UserMascot>():
        CustomException error = updateMascotResult.error as CustomException;
        alert.showError(error.displayMessage);
        return;
    }
  }
}
