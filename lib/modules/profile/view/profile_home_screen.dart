import 'package:breadcrumbs/router/routes.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:breadcrumbs/widgets/button/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileHomeScreen extends StatelessWidget {
  const ProfileHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
      ),
      body: SafeArea(
          child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(
                    text: 'Sign Out',
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      if (context.mounted) {
                        context.go(Routes.landing.landingScreen);
                      }
                    }),
              ))),
    );
  }
}
