import 'package:breadcrumbs/models/group/group_model.dart';
import 'package:breadcrumbs/models/user/user_detail_model.dart';
import 'package:breadcrumbs/repository/auth/auth_repository.dart';
import 'package:breadcrumbs/repository/group/group_repository.dart';
import 'package:breadcrumbs/repository/user/user_repository.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:breadcrumbs/utils/alert/alert.dart';
import 'package:breadcrumbs/utils/error_handling/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GroupMemberAddViewModel extends ChangeNotifier {
  GroupMemberAddViewModel(
      {required this.userRepository,
      required this.authRepository,
      required this.groupRepository,
      required this.groupId}) {
    currentGroup = groupRepository.userGroupsList
        .firstWhere((group) => group.id == groupId);
  }

  List<UserDetail>? searchResults;
  String searchName = '';
  int selectedIndex = -1;

  final UserRepository userRepository;
  final UserAuthRepository authRepository;
  final GroupRepository groupRepository;
  late Group currentGroup;
  final String groupId;

  void setSearchName(String name) {
    searchName = name;
  }

  void refreshData() {
    currentGroup = groupRepository.userGroupsList
        .firstWhere((group) => group.id == groupId);
  }

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  Future<void> onAddMember({required BuildContext context}) async {
    if (selectedIndex == -1) {
      return;
    }

    final alert = Alert.of(context);

    String selectedMemberId = searchResults![selectedIndex].uid!;

    List<String> newMembers = [...currentGroup.members, selectedMemberId];
    Group updatedGroup = currentGroup.copyWith(members: newMembers);

    Result<Group> result =
        await groupRepository.updateGroup(group: updatedGroup);

    switch (result) {
      case Ok<Group>():
        alert.showSuccess('Member added successfully!');
        if (context.mounted) {
          context.go(Routes.groupRoute.groupHome);
        }
        break;
      case Error<Group>():
        alert.showError('Something went wrong!');
        break;
    }
  }

  Future<void> onClickSearch() async {
    if (searchName.isEmpty) {
      return;
    }

    User? user = authRepository.user;
    String uid = user!.uid;

    Result<List<UserDetail>> result =
        await userRepository.searchAllUsersByDisplayName(
            displayName: searchName, groupUID: currentGroup.members);

    switch (result) {
      case Ok<List<UserDetail>>():
        searchResults = result.value;
        notifyListeners();
        break;
      case Error<List<UserDetail>>():
        break;
    }
  }
}
