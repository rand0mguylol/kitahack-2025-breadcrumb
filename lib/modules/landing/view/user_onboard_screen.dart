import 'package:breadcrumbs/constants/dropdown/form.dart';
import 'package:breadcrumbs/modules/landing/view_model/user_onboard_view_model.dart';
import 'package:breadcrumbs/widgets/form/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:breadcrumbs/modules/landing/view_model/register_view_model.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:breadcrumbs/widgets/button/custom_button.dart';
import 'package:breadcrumbs/utils/loading/loading.dart';

class UserOnboardScreen extends StatefulWidget {
  UserOnboardScreen(
      {super.key, required UserOnboardViewModel userOnboardViewModel})
      : _userOnboardViewModel = userOnboardViewModel;

  final UserOnboardViewModel _userOnboardViewModel;

  @override
  State<UserOnboardScreen> createState() => _UserOnboardScreenState();
}

class _UserOnboardScreenState extends State<UserOnboardScreen> {
  final TextEditingController _ageController = TextEditingController();
  // final TextEditingController _genderController = TextEditingController();

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // final TextEditingController _activityLevelController =
  //     TextEditingController();

  @override
  void initState() {
    super.initState();

    _displayNameController.addListener(() {
      widget._userOnboardViewModel.setDisplayName(_displayNameController.text);
    });

    _ageController.addListener(() {
      int? value = int.tryParse(_ageController.text);

      if (value != null) {
        widget._userOnboardViewModel.setAge(value);
      }
    });

    _weightController.addListener(() {
      double? value = double.tryParse(_weightController.text);

      if (value != null) {
        widget._userOnboardViewModel.setWeight(value);
      }
    });

    _heightController.addListener(() {
      double? value = double.tryParse(_heightController.text);

      if (value != null) {
        widget._userOnboardViewModel.setHeight(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      child: Scaffold(
        appBar: CustomAppBar(
          isBlankBackground: true,
        ),
        body: SingleChildScrollView(
          child: ListenableBuilder(
              listenable: widget._userOnboardViewModel,
              builder: (BuildContext context, _) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 24.0, right: 24.0, top: 48),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [_buildFormSection(context)],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

extension _UserOnboardView on _UserOnboardScreenState {
  Widget _buildFormSection(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          _buildDisplayNameForm(context),
          const SizedBox(
            height: 20,
          ),
          _buildAgeForm(context),
          const SizedBox(
            height: 30,
          ),
          _buildGenderForm(context),
          const SizedBox(
            height: 20,
          ),
          _buildWeightForm(context),
          const SizedBox(
            height: 20,
          ),
          _buildHeightForm(context),
          const SizedBox(
            height: 30,
          ),
          _buildActivityLevelForm(context),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: "Complete",
                onPressed: () async {
                  final loadingProvider =
                      Provider.of<LoadingProvider>(context, listen: false);

                  loadingProvider.showLoading();
                  // widget._registerViewModel.onClickRegister(context);
                  await widget._userOnboardViewModel
                      .onClickComplete(context, formKey);
                  loadingProvider.hideLoading();
                },
              ))
        ],
      ),
    );
  }

  Widget _buildDisplayNameForm(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        "Display Name",
        style: TextStyle(color: Colors.black),
      ),
      const SizedBox(
        height: 15,
      ),
      TextFormField(
        controller: _displayNameController,
        style: TextStyle(color: Colors.black),
        validator: (String? value) {
          return widget._userOnboardViewModel.validateRequiredField(
              value, "Please enter a valid display name");
        },
        // validator: widget._registerViewModel.validateEmail,
        decoration: const InputDecoration(
            hintStyle: TextStyle(color: Color.fromRGBO(130, 132, 144, 1)),
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            fillColor: Colors.white),
      )
    ]);
  }

  Widget _buildAgeForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Age",
          style: TextStyle(color: Colors.black),
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
          keyboardType: TextInputType.number, // Set the keyboard to numerical
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly, // Allow only digits
          ],
          controller: _ageController,
          style: TextStyle(color: Colors.black),
          // validator: widget._registerViewModel.validateEmail,
          decoration: const InputDecoration(
              hintStyle: TextStyle(color: Color.fromRGBO(130, 132, 144, 1)),
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              fillColor: Colors.white),
        )
      ],
    );
  }

  Widget _buildGenderForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropdownMenu(
            initialSelection: genderEntries.first.value,
            dropdownMenuEntries: genderEntries,
            onSelected: (String? value) {
              widget._userOnboardViewModel.setGender(value!);
              // widget._foodCapturePreviewViewModel.setMealType(value!);
            },
            label: "Gender"),
      ],
    );
  }

  Widget _buildWeightForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Weight (KG)",
          style: TextStyle(color: Colors.black),
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
          keyboardType: TextInputType.number, // Set the keyboard to numerical
          // inputFormatters: [
          //   FilteringTextInputFormatter.digitsOnly, // Allow only digits
          // ],
          controller: _weightController,
          style: TextStyle(color: Colors.black),
          // validator: widget._registerViewModel.validateEmail,
          decoration: const InputDecoration(
              hintStyle: TextStyle(color: Color.fromRGBO(130, 132, 144, 1)),
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              fillColor: Colors.white),
        )
      ],
    );
  }

  Widget _buildHeightForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Height (KG)",
          style: TextStyle(color: Colors.black),
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
          keyboardType: TextInputType.number, // Set the keyboard to numerical
          // inputFormatters: [
          //   FilteringTextInputFormatter.digitsOnly, // Allow only digits
          // ],
          controller: _heightController,
          style: TextStyle(color: Colors.black),
          // validator: widget._registerViewModel.validateEmail,
          decoration: const InputDecoration(
              hintStyle: TextStyle(color: Color.fromRGBO(130, 132, 144, 1)),
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              fillColor: Colors.white),
        )
      ],
    );
  }

  Widget _buildActivityLevelForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Text(
        //   "Activity Level",
        //   style: TextStyle(color: Colors.black),
        // ),
        // const SizedBox(
        //   height: 15,
        // ),
        // TextFormField(
        //   controller: _activityLevelController,
        //   style: TextStyle(color: Colors.black),
        //   // validator: widget._registerViewModel.validateEmail,
        //   decoration: const InputDecoration(
        //       hintStyle: TextStyle(color: Color.fromRGBO(130, 132, 144, 1)),
        //       filled: true,
        //       border: OutlineInputBorder(
        //           borderRadius: BorderRadius.all(Radius.circular(8.0))),
        //       fillColor: Colors.white),
        // )
        CustomDropdownMenu(
            initialSelection: activityLevelEntries.first.value,
            dropdownMenuEntries: activityLevelEntries,
            onSelected: (String? value) {
              widget._userOnboardViewModel.setActivityLevel(value!);
              // widget._foodCapturePreviewViewModel.setMealType(value!);
            },
            label: "Activity Level"),
      ],
    );
  }
}
