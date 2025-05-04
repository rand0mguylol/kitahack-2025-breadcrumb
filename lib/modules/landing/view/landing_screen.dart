import 'package:breadcrumbs/modules/landing/view/login_screen.dart';
import 'package:breadcrumbs/modules/landing/view/register_screen.dart';
import 'package:breadcrumbs/modules/landing/view_model/login_view_model.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:breadcrumbs/widgets/button/custom_button.dart';
import 'package:rive/rive.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: double.infinity,
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Container(
              color: const Color.fromRGBO(242, 242, 247, 1),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildHeader(context),
                  _buildIcon(context),
                  _buildCTASection(context)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        Text(
          "Healthcrumbs",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 33,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }

  Widget _buildIcon(BuildContext context) {
    // return SizedBox(
    //   width: 250,
    //   height: 250,
    //   child: Image.asset("assets/images/onboarding/wallet.png"),
    // );

    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        width: constraints.maxWidth * 0.8,
        height: constraints.maxWidth * 0.8,
        child: RiveAnimation.asset("assets/rive/sparky_happy.riv"),
      );
    });
  }

  Widget _buildCTASection(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            text: "Get Started",
            backgroundColor: const Color.fromRGBO(28, 28, 30, 1),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                context.go(Routes.landing.newLogin);
              }
            },
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        // SizedBox(
        //   width: double.infinity,
        //   child: CustomButton(
        //     text: "Register",
        //     onPressed: () {
        //       context.go(Routes.landing.register);
        //     },
        //   ),
        // ),
      ],
    );
  }
}
