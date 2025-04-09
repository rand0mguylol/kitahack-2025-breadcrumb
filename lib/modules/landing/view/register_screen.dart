// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

import 'package:breadcrumbs/modules/landing/view_model/register_view_model.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:breadcrumbs/widgets/button/custom_button.dart';
import 'package:breadcrumbs/utils/loading/loading.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen(
      {super.key, required RegisterViewModel registerViewModel})
      : _registerViewModel = registerViewModel;

  final RegisterViewModel _registerViewModel;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      widget._registerViewModel.setEmail(_emailController.text);
    });

    _passwordController.addListener(() {
      widget._registerViewModel.setPassword(_passwordController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isBlankBackground: true,
      ),
      body: _build(context),
    );
  }

  Widget _build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return LoadingScreen(
          child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: double.infinity,
          minHeight: viewportConstraints.maxHeight,
        ),
        child: ListenableBuilder(
            listenable: widget._registerViewModel,
            builder: (BuildContext context, _) {
              return Padding(
                padding:
                    const EdgeInsets.only(left: 24.0, right: 24.0, top: 48),
                child: Column(
                  children: [
                    _buildFormSection(context)
                    // _buildConfirmPasswordForm(context)
                  ],
                ),
              );
            }),
      ));
    });
  }

  Widget _buildFormSection(BuildContext context) {
    return Form(
      key: widget._registerViewModel.formKey,
      child: Column(
        children: [
          _buildEmailForm(context),
          const SizedBox(
            height: 20,
          ),
          _buildPasswordForm(context),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: "Next",
                onPressed: () async {
                  final loadingProvider =
                      Provider.of<LoadingProvider>(context, listen: false);

                  loadingProvider.showLoading();
                  widget._registerViewModel.onClickRegister(context);

                  loadingProvider.hideLoading();
                },
              ))
        ],
      ),
    );
  }

  Widget _buildEmailForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Email",
          style: TextStyle(color: Colors.black),
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
          controller: _emailController,
          style: TextStyle(color: Colors.black),
          validator: widget._registerViewModel.validateEmail,
          decoration: const InputDecoration(
              hintText: "example@gmail.com",
              hintStyle: TextStyle(color: Color.fromRGBO(130, 132, 144, 1)),
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              fillColor: Colors.white),
        )
      ],
    );
  }

  Widget _buildPasswordForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Password",
          style: TextStyle(color: Colors.black),
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
          obscureText: true,
          controller: _passwordController,
          style: TextStyle(color: Colors.black),
          validator: widget._registerViewModel.validatePassword,
          decoration: const InputDecoration(
              hintText: "***",
              hintStyle: TextStyle(color: Color.fromRGBO(130, 132, 144, 1)),
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              fillColor: Colors.white),
        )
      ],
    );
  }
}
