import 'package:breadcrumbs/modules/home/view_model/home_view_model.dart';
import 'package:breadcrumbs/modules/home/widget/home_calorie_card.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:breadcrumbs/widgets/button/custom_button.dart';
import 'package:breadcrumbs/widgets/button/floating_action_button.dart';
import 'package:breadcrumbs/widgets/layout/root_body.dart';
import 'package:breadcrumbs/widgets/text/view_all_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required HomeViewModel homeViewModel})
      : _homeViewModel = homeViewModel;

  final HomeViewModel _homeViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingButton(
        action2: () {
          context.push(Routes.foodCapture.foodCaptureEntry);
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ListenableBuilder(
            listenable: _homeViewModel,
            builder: (BuildContext context, _) {
              if (_homeViewModel.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (_homeViewModel.isError) {
                return Text(_homeViewModel.errorMessage,
                    style: TextStyle(color: Colors.red));
              }

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Welcome Back ${_homeViewModel.displayName}!",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.push(Routes.profileRoute.profileHome);
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Colors.orangeAccent,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final chartWidth = constraints.maxWidth * 0.5;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.push(Routes.mascotRoute.mascotHome);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white, // Background color
                                  // Rounded corners
                                ),
                                width: chartWidth,
                                height: chartWidth,
                                child: RiveAnimation.asset(
                                  // 'assets/rive/sparky_happy.riv',

                                  _homeViewModel.userMascot.health >= 80
                                      ? 'assets/rive/sparky_happy.riv'
                                      : _homeViewModel.userMascot.health <= 59
                                          ? 'assets/rive/sparky_sad.riv'
                                          : 'assets/rive/sparky_normal.riv',
                                  fit: BoxFit.contain,
                                  alignment: Alignment.topRight,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    HomeCalorieCard(
                      calorieEaten: _homeViewModel.caloriesEaten,
                      calorieLeft: _homeViewModel.caloriesLeft,
                      progressValue: _homeViewModel.progressValue,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    ViewAllTile(
                        title: "Today's Nutritional Intake", onTap: () {}),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 16, right: 40, top: 16, bottom: 16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          // Use constraints.maxWidth to determine the available width
                          final maxWidth = constraints.maxWidth;

                          // Dynamically adjust spacing or behavior based on maxWidth
                          return Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            // runAlignment: WrapAlignment.start,
                            // crossAxisAlignment: WrapCrossAlignment.start,
                            spacing:
                                maxWidth * 0.3, // Adjust spacing based on width
                            runSpacing: 28, // Vertical spacing between rows
                            children: List.generate(
                              _homeViewModel
                                  .nutritionSnippet.length, // Number of items
                              (index) {
                                NutritionSnippet snippet =
                                    _homeViewModel.nutritionSnippet[index];

                                return _buildNutritionSnippet(context,
                                    snippet.value, snippet.unit, snippet.text);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Explore",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        children: [
                          Column(
                            spacing: 8.0,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.push(Routes.mealRoute.mealHome);
                                },
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: const Icon(
                                    Icons.restaurant,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              const Text(
                                "Meals",
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNutritionSnippet(
      BuildContext context, String value, String unit, String text) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$value ', // The value
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: unit, // The label
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black
                    // color: Colors.grey,
                    ),
              ),
            ],
          ),
        ),
        Text(
          text,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
        ),
      ],
    );
  }
}
