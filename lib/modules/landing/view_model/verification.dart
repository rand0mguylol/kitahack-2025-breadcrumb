import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import 'package:breadcrumbs/repository/auth/auth_repository.dart';
// import 'package:wealth_ai/router/routes.dart';

class EmailVerificationViewModel {
  EmailVerificationViewModel({required UserAuthRepository userAuthRepository})
      : _userAuthRepository = userAuthRepository {
    user = _userAuthRepository.user;
    // timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //   checkEmailVerified();
    // });
  }

  final UserAuthRepository _userAuthRepository;
  late Timer timer;
  late User? user;

  void startEmailVerificationCheck(BuildContext context) {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _checkEmailVerified(context);
    });
  }

  Future<void> _checkEmailVerified(BuildContext context) async {
    print("Loop");
    await user?.reload();
    user = _userAuthRepository.user;
    if (user?.emailVerified == false) return;
    timer.cancel();

    // if (context.mounted) {
    //   context.go(Routes.home.home);
    // }
  }

  // @override
  // void dispose() {
  //   timer.cancel();
  //   super.dispose();
  // }
}
