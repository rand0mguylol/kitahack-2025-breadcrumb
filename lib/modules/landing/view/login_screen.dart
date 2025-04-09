import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:breadcrumbs/modules/landing/view_model/login_view_model.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:breadcrumbs/widgets/button/custom_button.dart';
import 'package:breadcrumbs/utils/loading/loading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required LoginViewModel loginViewModel})
      : _loginViewModel = loginViewModel;

  final LoginViewModel _loginViewModel;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      widget._loginViewModel.setEmail(_emailController.text);
    });

    _passwordController.addListener(() {
      widget._loginViewModel.setPassword(_passwordController.text);
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
            listenable: widget._loginViewModel,
            builder: (BuildContext context, _) {
              return Padding(
                padding:
                    const EdgeInsets.only(left: 24.0, right: 24.0, top: 48),
                child: Column(
                  children: [_buildFormSection(context)],
                ),
              );
            }),
      ));
    });
  }

  Widget _buildFormSection(BuildContext context) {
    return Form(
      key: widget._loginViewModel.formKey,
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
                  await widget._loginViewModel.onClickLogin(context);

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
          validator: widget._loginViewModel.validateEmail,
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
          validator: widget._loginViewModel.validatePassword,
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
