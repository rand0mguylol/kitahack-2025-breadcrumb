import 'package:breadcrumbs/models/food_database/food_database_model.dart';
import 'package:breadcrumbs/models/nutrition/nutrition.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:breadcrumbs/services/food_database/food_database_service.dart';
import 'package:breadcrumbs/utils/alert/alert.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FoodDatabaseHomeViewModel extends ChangeNotifier {
  FoodDatabaseHomeViewModel({required this.foodDatabaseService}) {
    initData();
  }
  final FoodDatabaseService foodDatabaseService;

  List<FoodDatabaseModel> foodItemList = [];

  bool isLoading = true;
  bool isError = false;

  Future<void> initData() async {
    try {
      List<FoodDatabaseModel> getItems =
          await foodDatabaseService.getAllFoodDatabaseItems();

      if (getItems.isNotEmpty) {
        foodItemList = getItems;
        isLoading = false;
        notifyListeners();
      } else {
        throw Exception('Something went wrong');
      }
    } catch (e) {
      isLoading = false;
      isError = true;
    }
  }
}
