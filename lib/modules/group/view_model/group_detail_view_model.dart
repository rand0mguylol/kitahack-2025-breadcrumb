import 'package:breadcrumbs/models/group/group_model.dart';
import 'package:breadcrumbs/models/user/user_detail_model.dart';
import 'package:breadcrumbs/models/user/user_meal_model.dart';
import 'package:breadcrumbs/repository/auth/auth_repository.dart';
import 'package:breadcrumbs/repository/group/group_repository.dart';
import 'package:breadcrumbs/repository/user/user_repository.dart';
import 'package:breadcrumbs/utils/error_handling/result.dart';
import 'package:flutter/material.dart';

class GroupDetailViewModel extends ChangeNotifier {
  GroupDetailViewModel({
    required this.userRepository,
    required this.authRepository,
    required this.groupRepository,
    required this.groupId,
  }) {
    currentGroup = groupRepository.userGroupsList
        .firstWhere((group) => group.id == groupId);

    // initGroupMember();
    initData();
  }

  final UserRepository userRepository;
  final UserAuthRepository authRepository;
  final GroupRepository groupRepository;
  late Group currentGroup;
  final String groupId;

  String selected = 'breakfast';

  List<UserDetail>? groupMembers;

  late Map<String, List<UserMeal>> userMealMap = {};

  Future<void> initData() async {
    await initGroupMember();
    await initUserMealMap();
  }

  void onChangeSelected(String value) {
    selected = value;
    notifyListeners();
  }

  Future<void> initGroupMember() async {
    Result<List<UserDetail>> result =
        await userRepository.getAllUsersInGroupByUID(uid: currentGroup.members);

    switch (result) {
      case Ok<List<UserDetail>>():
        groupMembers = result.value;
        break;
      case Error<List<UserDetail>>():
        break;
    }
    notifyListeners();
  }

  Future<void> initUserMealMap() async {
    List<UserMeal> userMeals = [];
    Result<List<UserMeal>> result = await userRepository.getAllUserMealInGroup(
        memberUID: currentGroup.members);

    switch (result) {
      case Ok<List<UserMeal>>():
        userMeals = result.value;
        print("User Meals $userMeals");
        break;
      case Error<List<UserMeal>>():
        return;
    }

    DateTime groupCreatedAtDate = DateTime(
      currentGroup.createdAt.toDate().year,
      currentGroup.createdAt.toDate().month,
      currentGroup.createdAt.toDate().day,
    );

    userMealMap = {
      for (var memberId in currentGroup.members)
        memberId: userMeals.where((meal) => meal.uid == memberId).where((meal) {
          // Normalize the meal's createdAt to date format
          DateTime mealCreatedAtDate = DateTime(
            meal.createdAt!.toDate().year,
            meal.createdAt!.toDate().month,
            meal.createdAt!.toDate().day,
          );
          // Compare the dates
          return mealCreatedAtDate.isAtSameMomentAs(groupCreatedAtDate) ||
              mealCreatedAtDate.isAfter(groupCreatedAtDate);
        }).toList(), // Filter meals for the current user
    };

    notifyListeners(); // Notify
  }
}
