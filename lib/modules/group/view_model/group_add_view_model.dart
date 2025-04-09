import 'package:breadcrumbs/models/group/group_model.dart';
import 'package:breadcrumbs/repository/auth/auth_repository.dart';
import 'package:breadcrumbs/repository/group/group_repository.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:breadcrumbs/utils/alert/alert.dart';
import 'package:breadcrumbs/utils/error_handling/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GroupAddViewModel extends ChangeNotifier {
  GroupAddViewModel({
    required this.userAuthRepository,
    required this.groupRepository,
  });
  String? groupName;

  final UserAuthRepository userAuthRepository;
  final GroupRepository groupRepository;

  void setGroupName(String value) {
    groupName = value;
  }

  String? validateRequiredField(String? value, String message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  Future<void> onClickAdd(
      BuildContext context, GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final alert = Alert.of(context);
    User? user = userAuthRepository.user;
    String uid = user!.uid;

    Group newGroup = Group(
        groupName: groupName!,
        createdAt: Timestamp.fromDate(DateTime.now()),
        members: [uid],
        createdBy: uid,
        streakExpireDate: Timestamp.fromDate(DateTime.now()),
        streakCount: 0);

    Result<Group> newGroupResult =
        await groupRepository.createGroup(group: newGroup);

    switch (newGroupResult) {
      case Ok<Group>():
        alert.showSuccess('Group created successfully');
        break;
      case Error<Group>():
        alert.showError('Could not create group');
        return;
    }

    if (context.mounted) {
      context.go(Routes.groupRoute.groupHome);
    }
  }
}
