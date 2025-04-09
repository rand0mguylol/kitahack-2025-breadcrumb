import 'package:breadcrumbs/models/group/group_model.dart';
import 'package:breadcrumbs/modules/group/view_model/group_home_view_model.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GroupHome extends StatelessWidget {
  const GroupHome({super.key, required this.groupHomeViewModel});

  final GroupHomeViewModel groupHomeViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Group',
        actions: [
          IconButton(
              onPressed: () {
                context.go(Routes.groupRoute.groupAdd);
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 24,
              )),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: ListenableBuilder(
          listenable: groupHomeViewModel,
          builder: (context, child) {
            if (groupHomeViewModel.userGroups.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: const Center(
                  child: Text(
                    'No groups found',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }
            return Container(
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, int) {
                    Group group = groupHomeViewModel.userGroups[int];
                    return ListTile(
                      onTap: () {
                        context.go(
                          Routes.groupRoute.groupDetail(groupId: group.id!),
                        );
                      },
                      leading: const CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.group),
                      ),
                      title: Text(group.groupName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                      subtitle: Text(
                        '${group.members.length} member(s)',
                        style: TextStyle(
                            color: Colors.black.withValues(alpha: 0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      trailing: Row(
                        spacing: 8.0,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.local_fire_department,
                            color: Colors.orangeAccent,
                            size: 16,
                          ),
                          Text(group.streakCount.toString())
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, int) => const Divider(),
                  itemCount: groupHomeViewModel.userGroups.length),
            );
          },
        ),
      )),
    );
  }
}
