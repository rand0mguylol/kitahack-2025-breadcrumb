import 'dart:io';

import 'package:breadcrumbs/constants/dropdown/form.dart';
import 'package:breadcrumbs/models/nutrition/nutrition.dart';
import 'package:breadcrumbs/repository/analyse/analyse_repository.dart';
import 'package:breadcrumbs/repository/auth/auth_repository.dart';
import 'package:breadcrumbs/repository/camera/camera_repository.dart';
import 'package:breadcrumbs/repository/firebase_function/firebase_function_repository.dart';
import 'package:breadcrumbs/repository/firebase_storage/firebase_storage_repository.dart';
import 'package:breadcrumbs/repository/user/user_repository.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:breadcrumbs/types/ingredient/ingredient.dart';
import 'package:breadcrumbs/types/request/request.dart';
import 'package:breadcrumbs/types/response/response.dart';
import 'package:breadcrumbs/utils/alert/alert.dart';
import 'package:breadcrumbs/utils/error_handling/exception.dart';
import 'package:breadcrumbs/utils/error_handling/result.dart';
import 'package:breadcrumbs/utils/validator/validator.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class FoodCapturePreviewViewModel extends ChangeNotifier {
  FoodCapturePreviewViewModel(
      {required CameraRepository cameraRepository,
      required FirebaseStorageRepository firebaseStorageRepository,
      required FirebaseFunctionRepository firebaseFunctionRepository,
      required UserAuthRepository userAuthRepository,
      required AnalyseRepository analyseRepository,
      required this.userRepository})
      : _cameraRepository = cameraRepository,
        _firebaseStorageRepository = firebaseStorageRepository,
        _firebaseFunctionRepository = firebaseFunctionRepository,
        _userAuthRepository = userAuthRepository,
        _analyseRepository = analyseRepository {
    file = _cameraRepository.file;
  }
  final CameraRepository _cameraRepository;
  final FirebaseStorageRepository _firebaseStorageRepository;
  final UserAuthRepository _userAuthRepository;
  final FirebaseFunctionRepository _firebaseFunctionRepository;
  final AnalyseRepository _analyseRepository;
  final UserRepository userRepository;
  final uuid = const Uuid();

  final List<IngredientFieldData> _ingredientFieldData = [];

  List<IngredientFieldData> get ingredientFieldData => _ingredientFieldData;

  late File file;

  String dishName = "";
  String brandRestaurantName = "";
  String mealType = mealTypeEntries.first.value;
  String portionSize = portionSizeEntries.first.value;
  String cookingMethod = cookingMethodEntries.first.value;
  String? downloadUrl;

  final formKey = GlobalKey<FormState>();

  void setDishName(String value) {
    dishName = value;
  }

  void setBrandRestaurantName(String value) {
    brandRestaurantName = value;
  }

  void setMealType(String value) {
    mealType = value;
  }

  void setPortionSize(String value) {
    portionSize = value;
  }

  void setCookingMethod(String value) {
    cookingMethod = value;
  }

  Future<Map<String, String>> _uploadFoodPicture() async {
    final File file = _cameraRepository.file;
    final User? user = _userAuthRepository.user;

    Result<Map<String, String>> result = await _firebaseStorageRepository
        .uploadFile(file: file, uploadPath: 'dish/${user!.uid}/${uuid.v4()}');

    Map<String, String> object = {};

    switch (result) {
      case Ok<Map<String, String>>():
        object = result.value;
        return object;

      case Error<Map<String, String>>():
        print(result.error);
        return {};
    }
  }

  void onAddIngredientField() {
    if (_ingredientFieldData.length == 10) return;

    _ingredientFieldData.add(IngredientFieldData(
        ingredientAmountController: TextEditingController(),
        ingredientNameController: TextEditingController(),
        ingredientUnitController:
            TextEditingController(text: ingredientUnitEntries.first.value)));

    notifyListeners();
  }

  void onRemoveIngredientField() {
    _ingredientFieldData.removeLast();

    notifyListeners();
  }

  String? validateRequiredField(String? value, String message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  String? validateNumberField(String? value, String message) {
    if (value == null) return message;

    double? convert = double.tryParse(value);

    if (convert == null) return message;

    return null;
  }

  Future<void> onValidateForm(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      for (IngredientFieldData i in _ingredientFieldData) {}
      return;
    }
    final alert = Alert.of(context);

    Map<String, String> object = await _uploadFoodPicture();

    if (object.isEmpty) return;

    String url = object["url"]!;
    String path = object['path']!;

    List<IngredientData> ingredientDataList = _ingredientFieldData
        .map((i) => IngredientData(
            ingredientAmount: double.parse(i.ingredientAmountController.text),
            ingredientName: i.ingredientNameController.text,
            ingredientUnit: i.ingredientUnitController.text))
        .toList();

    AnalyzeFoodRequest analyzeFoodRequest = AnalyzeFoodRequest(
      imagePath: path,
      dishName: dishName,
      brandRestaurantName: brandRestaurantName,
      mealType: mealType,
      portionSize: portionSize,
      cookingMethod: cookingMethod,
      ingredients: ingredientDataList,
      userDetail: userRepository.userDetail!,
    );

    final result = await _firebaseFunctionRepository.analyseFood(
        analyseFoodRequest: analyzeFoodRequest);

    switch (result) {
      case Error<AnalyseFoodResponse<Nutrition>>():
        CustomException exception = result.error as CustomException;
        alert.showError(exception.message);
        return;

      case Ok<AnalyseFoodResponse<Nutrition>>():
        AnalyseFoodResponse<Nutrition> analyseFoodResponse = result.value;
        AdditionalContext additionalContext = AdditionalContext(
            imagePath: url,
            dishName: dishName,
            brandRestaurantName: brandRestaurantName,
            mealType: mealType,
            portionSize: portionSize,
            cookingMethod: cookingMethod,
            ingredients: ingredientDataList);

        _analyseRepository.nutrition = analyseFoodResponse.value;
        _analyseRepository.additionalContext = additionalContext;
        _analyseRepository.insights = analyseFoodResponse.insights;
    }

    if (context.mounted) {
      context.push(Routes.foodCapture.foodCaptureSummary);
    }
  }
}
