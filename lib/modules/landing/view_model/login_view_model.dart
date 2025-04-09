import 'package:breadcrumbs/modules/home/view/home_screen.dart';
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

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({required UserAuthRepository userAuthRepository})
      : _userAuthRepository = userAuthRepository;

  final UserAuthRepository _userAuthRepository;

  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;

  GlobalKey<FormState> get formKey => _formKey;

  void setEmail(String value) {
    email = value;
  }

  void setPassword(String value) {
    password = value;
  }

  String? validateEmail(String? value) {
    return ValidatorHelper().validEmailAddressFormat(value);
  }

  String? validatePassword(String? value) {
    return ValidatorHelper().required(value);
  }

  Future<void> onClickLogin(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Result<User?> result = await _userAuthRepository.signInWithEmailAndPassword(
        email: email!, password: password!);

    if (context.mounted) {
      switch (result) {
        case Ok<User?>():
          User? user = result.value;
          context.go(Routes.landing.splash);
          break;
        case Error<User?>():
          CustomException exception = result.error as CustomException;
          Alert.of(context).showError(exception.message);
      }
    }
  }
}
