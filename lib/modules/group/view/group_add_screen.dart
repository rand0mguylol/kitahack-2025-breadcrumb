import 'package:breadcrumbs/modules/group/view_model/group_add_view_model.dart';
import 'package:breadcrumbs/utils/loading/loading.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:breadcrumbs/widgets/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupAddScreen extends StatefulWidget {
  const GroupAddScreen({super.key, required this.groupAddViewModel});

  final GroupAddViewModel groupAddViewModel;

  @override
  State<GroupAddScreen> createState() => _GroupAddScreenState();
}

class _GroupAddScreenState extends State<GroupAddScreen> {
  final TextEditingController groupNameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    groupNameController.addListener(() {
      widget.groupAddViewModel.setGroupName(groupNameController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Create',
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: ListenableBuilder(
          listenable: widget.groupAddViewModel,
          builder: (context, child) {
            return Container(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 48),
              child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Group Name",
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: groupNameController,
                        style: const TextStyle(color: Colors.black),
                        validator: (String? value) {
                          return widget.groupAddViewModel.validateRequiredField(
                              value, "Please enter a valid group name");
                        },
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(130, 132, 144, 1)),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            fillColor: Colors.white),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          text: 'Add',
                          onPressed: () async {
                            final loadingProvider =
                                Provider.of<LoadingProvider>(context,
                                    listen: false);
                            loadingProvider.showLoading();
                            await widget.groupAddViewModel
                                .onClickAdd(context, formKey);
                            loadingProvider.hideLoading();
                          },
                        ),
                      )
                    ]),
              ),
            );
          },
        ),
      )),
    );
  }
}
