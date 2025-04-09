import 'package:breadcrumbs/models/group/group_model.dart';
import 'package:breadcrumbs/repository/auth/auth_repository.dart';
import 'package:breadcrumbs/repository/group/group_repository.dart';
import 'package:breadcrumbs/utils/alert/alert.dart';
import 'package:breadcrumbs/utils/error_handling/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupHomeViewModel extends ChangeNotifier {
  GroupHomeViewModel(
      {required this.groupRepository,
      required this.userAuthRepository,
      required this.context}) {
    initData();
  }

  final GroupRepository groupRepository;
  final UserAuthRepository userAuthRepository;
  final BuildContext context;

  List<Group> userGroups = [];

  Future<void> initData() async {
    final alert = Alert.of(context);

    User? user = userAuthRepository.user;

    String uid = user!.uid;

    Result<List<Group>> result = await groupRepository.getUserGroups(uid: uid);
    switch (result) {
      case Ok<List<Group>>():
        userGroups = result.value;
        notifyListeners();
        break;
      case Error<List<Group>>():
        alert.showError('Something went wrong');
        return;
    }
  }
}
