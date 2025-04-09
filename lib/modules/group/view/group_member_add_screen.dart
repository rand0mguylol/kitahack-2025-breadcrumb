import 'package:breadcrumbs/models/user/user_detail_model.dart';
import 'package:breadcrumbs/modules/group/view_model/group_member_add_view_model.dart';
import 'package:breadcrumbs/utils/loading/loading.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:breadcrumbs/widgets/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupMemberAddScreen extends StatefulWidget {
  const GroupMemberAddScreen(
      {super.key,
      required this.groupId,
      required this.groupMemberAddViewModel});

  final String groupId;

  final GroupMemberAddViewModel groupMemberAddViewModel;

  @override
  State<GroupMemberAddScreen> createState() => _GroupMemberAddScreenState();
}

class _GroupMemberAddScreenState extends State<GroupMemberAddScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      widget.groupMemberAddViewModel.setSearchName(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Add Members",
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 18,
            ),
            onPressed: () async {
              final loadingProvider =
                  Provider.of<LoadingProvider>(context, listen: false);
              loadingProvider.showLoading();

              await widget.groupMemberAddViewModel
                  .onAddMember(context: context);
              loadingProvider.hideLoading();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ListenableBuilder(
            listenable: widget.groupMemberAddViewModel,
            builder: (context, child) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 24),
                    decoration: const BoxDecoration(
                      color: Colors.white, // Background color
                    ),
                    child: Column(
                      spacing: 16.0,
                      children: [
                        TextFormField(
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          controller: _searchController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            hintText: "Username",
                            prefixIcon: const Icon(Icons.search),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20), // Padding inside the field
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                              text: 'Search',
                              onPressed: () async {
                                final loadingProvider =
                                    Provider.of<LoadingProvider>(context,
                                        listen: false);
                                loadingProvider.showLoading();
                                await widget.groupMemberAddViewModel
                                    .onClickSearch();
                                loadingProvider.hideLoading();
                              }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (widget.groupMemberAddViewModel.searchResults == null)
                    const SizedBox.shrink()
                  else if (widget
                      .groupMemberAddViewModel.searchResults!.isEmpty)
                    const Text("No results found",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ))
                  else
                    ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          widget.groupMemberAddViewModel.searchResults!.length,
                      itemBuilder: (context, index) {
                        UserDetail userDetail = widget
                            .groupMemberAddViewModel.searchResults![index];
                        return ListTile(
                          selected: index ==
                              widget.groupMemberAddViewModel.selectedIndex,
                          leading: const CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.group),
                          ),
                          title: Text(userDetail.displayName!),
                          trailing: index ==
                                  widget.groupMemberAddViewModel.selectedIndex
                              ? IconButton(
                                  icon: const Icon(Icons.check_circle),
                                  onPressed: () {
                                    widget.groupMemberAddViewModel
                                        .setSelectedIndex(-1);
                                  },
                                )
                              : IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    widget.groupMemberAddViewModel
                                        .setSelectedIndex(index);
                                  },
                                ),
                        );
                      },
                    )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
