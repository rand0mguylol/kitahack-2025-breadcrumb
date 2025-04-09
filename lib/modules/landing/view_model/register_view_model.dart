import 'dart:io';

import 'package:breadcrumbs/modules/home/view/home_screen.dart';
import 'package:breadcrumbs/modules/landing/view_model/user_onboard_view_model.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:breadcrumbs/repository/auth/auth_repository.dart';
import 'package:breadcrumbs/utils/alert/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:breadcrumbs/utils/loading/loading.dart';

import 'package:breadcrumbs/utils/validator/validator.dart';
import 'package:breadcrumbs/utils/error_handling/result.dart';

class RegisterViewModel extends ChangeNotifier {
  RegisterViewModel({required UserAuthRepository userAuthRepository})
      : _userAuthRepository = userAuthRepository;

  final UserAuthRepository _userAuthRepository;

  final _formKey = GlobalKey<FormState>();

  bool _checkBoxValue = false;
  String? email;
  String? password;

  bool get checkBoxValue => _checkBoxValue;

  GlobalKey<FormState> get formKey => _formKey;

  void setEmail(String value) {
    email = value;
  }

  void setPassword(String value) {
    password = value;
  }

  void onClickRegister(BuildContext context) async {
    // context.go(Routes.landing.userOnboard);

    // return;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    Result<User?> result = await _userAuthRepository
        .createUserWithEmailAndPassword(email: email!, password: password!);

    if (context.mounted) {
      switch (result) {
        case Ok<User?>():
          // TODO
          // Add back email verification screen later on
          // _userAuthRepository.sendEmailVerification();

          context.go(Routes.landing.userOnboard);

          break;
        case Error<User?>():
          Alert.of(context).showError("Something went wrong");
          break;
      }
    }
  }

  void onClickChecbox(bool? value) {
    _checkBoxValue = value ?? false;
    notifyListeners();
  }

  String? validateEmail(String? value) {
    return ValidatorHelper().validEmailAddressFormat(value);
  }

  String? validatePassword(String? value) {
    return ValidatorHelper().validPasswordFormat(value);
  }
}
