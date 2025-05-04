import 'package:breadcrumbs/constants/dropdown/form.dart';
import 'package:breadcrumbs/models/meal_planner/meal_plan_item_model.dart';
import 'package:breadcrumbs/models/user/user_nutrition_model.dart';
import 'package:breadcrumbs/repository/auth/auth_repository.dart';
import 'package:breadcrumbs/repository/firebase_function/firebase_function_repository.dart';
import 'package:breadcrumbs/repository/user/user_repository.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:breadcrumbs/services/meal_planner/meal_planner_service.dart';
import 'package:breadcrumbs/services/user/user_detail_service_.dart';
import 'package:breadcrumbs/services/user/user_nutrition_service.dart';
import 'package:breadcrumbs/types/request/request.dart';
import 'package:breadcrumbs/types/response/response.dart';
import 'package:breadcrumbs/utils/alert/alert.dart';
import 'package:breadcrumbs/utils/error_handling/exception.dart';
import 'package:breadcrumbs/utils/error_handling/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TrackerAnalyticViewModel extends ChangeNotifier {
  TrackerAnalyticViewModel(
      {required this.userDetailService,
      required this.userNutritionService,
      required this.userAuthRepository}) {
    initData();
  }

  final UserDetailService userDetailService;
  final UserNutritionService userNutritionService;
  final UserAuthRepository userAuthRepository;
  // final

  bool isLoading = true;
  bool isError = false;

  DateTime startDate = DateTime.now().subtract(Duration(days: 7));

  DateTime endDate = DateTime.now();

  String type = trackerAnalyticsType.first.value;

  List<UserNutrition> userNutritionList = [];

  void setStartDate(DateTime date) {
    if (startDate == date) return;
    startDate = date;
    isLoading = true;
    notifyListeners();
    initData();
  }

  void setEndDate(DateTime date) {
    if (endDate == date) return;
    endDate = date;
    isLoading = true;
    notifyListeners();
    initData();
  }

  void setType(String value) {
    type = value;
    notifyListeners();
  }

  Future<void> initData() async {
    try {
      User? user = userAuthRepository.user;
      String uid = (user?.uid)!;
      List<UserNutrition> getList =
          await userNutritionService.getUserNutritionByDateRange(
              uid: uid, startDate: startDate, endDate: endDate);
      userNutritionList = getList;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
    }
  }
}
