import 'package:breadcrumbs/constants/dropdown/form.dart';
import 'package:breadcrumbs/models/mascot/user_mascot_model.dart';
import 'package:breadcrumbs/models/nutrition/nutrition.dart';
import 'package:breadcrumbs/models/user/user_detail_model.dart';
import 'package:breadcrumbs/repository/auth/auth_repository.dart';
import 'package:breadcrumbs/repository/firebase_function/firebase_function_repository.dart';
import 'package:breadcrumbs/repository/mascot/user_mascot_repository.dart';
import 'package:breadcrumbs/repository/user/user_repository.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:breadcrumbs/types/request/request.dart';
import 'package:breadcrumbs/types/response/response.dart';
import 'package:breadcrumbs/utils/alert/alert.dart';
import 'package:breadcrumbs/utils/error_handling/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserOnboardViewModel extends ChangeNotifier {
  // final _formKey = GlobalKey<FormState>();

  // GlobalKey<FormState> get formKey => _formKey;

  UserOnboardViewModel(
      {required this.firebaseFunctionRepository,
      required this.userAuthRepository,
      required this.userRepository,
      required this.userMascotRepository});

  String? displayName;

  int? age;

  double? weight;

  double? height;

  String activityLevel = activityLevelEntries.first.value;

  String gender = genderEntries.first.value;

  final FirebaseFunctionRepository firebaseFunctionRepository;
  final UserAuthRepository userAuthRepository;
  final UserRepository userRepository;
  final UserMascotRepository userMascotRepository;

  void setAge(int value) {
    age = value;
  }

  void setWeight(double value) {
    weight = value;
  }

  void setHeight(double value) {
    height = value;
  }

  void setActivityLevel(String value) {
    activityLevel = value;
  }

  void setDisplayName(String value) {
    displayName = value;
  }

  void setGender(String value) {
    gender = value;
  }

  Future<void> onClickComplete(
      BuildContext context, GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final alert = Alert.of(context);

    Result<UserDetail?> userDetailResult =
        await userRepository.getUserByDisplayName(displayName: displayName!);

    switch (userDetailResult) {
      case Ok<UserDetail?>():
        if (userDetailResult.value != null) {
          alert.showError("Display name already exists");
          return;
        }
      case Error<UserDetail?>():
        alert.showError("Something went wrong");
        return;
    }

    GenerateUserDetailRequest request = GenerateUserDetailRequest(
        age: age!,
        weight: weight!,
        height: height!,
        activityLevel: activityLevel,
        gender: gender);

    Result<GenerateUserDetailResponse<Nutrition>> result =
        await firebaseFunctionRepository.generateUserDetail(
            generateUserDetailRequest: request);

    switch (result) {
      case Ok<GenerateUserDetailResponse<Nutrition>>():
        alert.showSuccess("Generated");
      case Error<GenerateUserDetailResponse<Nutrition>>():
        alert.showError("Something went wrong");
        return;
    }

    final User? user = userAuthRepository.user;
    String uid = user!.uid;

    UserDetail newUserDetail = UserDetail(
        age: age,
        weight: weight,
        height: height,
        activityLevel: activityLevel,
        gender: gender,
        uid: uid,
        displayName: displayName,
        nutrition: result.value.value);

    final addUDResult =
        await userRepository.addUserDetail(userDetail: newUserDetail);

    switch (addUDResult) {
      case Ok<UserDetail>():
        // context.go(Routes.landing.splash);
        break;
      case Error<UserDetail>():
        alert.showError("Something went wrong");
        return;
    }

    UserMascot newUM = UserMascot(
      health: 70,
      status: 'normal',
      uid: uid,
    );

    final addMascotResult =
        await userMascotRepository.createUserMascot(userMascot: newUM);

    if (context.mounted) {
      switch (addMascotResult) {
        case Ok<UserMascot>():
          context.go(Routes.landing.splash);
          break;
        case Error<UserMascot>():
          alert.showError("Something went wrong");
          return;
      }
    }
  }

  String? validateRequiredField(String? value, String message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }
}
