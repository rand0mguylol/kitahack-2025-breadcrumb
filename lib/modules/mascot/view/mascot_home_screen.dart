import 'package:breadcrumbs/models/goal/goal_model.dart';
import 'package:breadcrumbs/models/goal/user_goal_model.dart';
import 'package:breadcrumbs/modules/mascot/view_model/mascot_home_view_model.dart';
import 'package:breadcrumbs/modules/mascot/widget/goal_list_tile.dart';
import 'package:breadcrumbs/repository/mascot/user_mascot_repository.dart';
import 'package:breadcrumbs/utils/loading/loading.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:breadcrumbs/widgets/text/view_all_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart' hide Image;
import 'package:breadcrumbs/widgets/chart/custom_pie_chart.dart';

class MascotHomeScreen extends StatelessWidget {
  const MascotHomeScreen({super.key, required this.mascotHomeViewModel});

  final MascotHomeViewModel mascotHomeViewModel;

  @override
  Widget build(BuildContext context) {
    double eatenPercentage = mascotHomeViewModel.userMascot.health.toDouble();
    double leftPercentage = mascotHomeViewModel.userMascot.health - 100;
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Companion',
      ),
      body: LoadingScreen(
        child: SingleChildScrollView(
          child: ListenableBuilder(
              listenable: mascotHomeViewModel,
              builder: (context, child) {
                if (mascotHomeViewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (mascotHomeViewModel.isError) {
                  return const Center(
                      child: Text('Something went wrong',
                          style: TextStyle(color: Colors.red)));
                }
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 32),
                  child: Column(
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final chartWidth = constraints.maxWidth * 0.5;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                          height: 250,
                                          child: Row(
                                            spacing: 24,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  mascotHomeViewModel.setMascot(
                                                      MascotEnum.chicken);
                                                },
                                                child: SizedBox(
                                                  width: 100,
                                                  height: 100,
                                                  child: Image.asset(
                                                      'assets/images/mascot/chicken.png'),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  mascotHomeViewModel.setMascot(
                                                      MascotEnum.sparky);
                                                },
                                                child: SizedBox(
                                                  width: 100,
                                                  height: 100,
                                                  child: Image.asset(
                                                      'assets/images/mascot/sparky.png'),
                                                ),
                                              )
                                            ],
                                          ));
                                    },
                                  );
                                },
                                child: SizedBox(
                                  width: chartWidth,
                                  height: chartWidth,
                                  child: CustomPieChart(
                                    data: leftPercentage >= 100
                                        ? [
                                            PieChartData(Colors.redAccent,
                                                eatenPercentage)
                                          ]
                                        : [
                                            PieChartData(Colors.transparent,
                                                leftPercentage),
                                            PieChartData(Colors.redAccent,
                                                eatenPercentage),
                                          ],
                                    radius: 20,
                                    strokeWidth: 20,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white, // Background color
                                        // Rounded corners
                                      ),
                                      width: chartWidth,
                                      height: chartWidth,
                                      child: mascotHomeViewModel.mascotType ==
                                              MascotEnum.chicken
                                          ? const RiveAnimation.asset(
                                              'assets/rive/chicken.riv',
                                              fit: BoxFit.fitWidth,
                                              alignment: Alignment.topRight,
                                            )
                                          : RiveAnimation.asset(
                                              mascotHomeViewModel
                                                          .userMascot.health >=
                                                      80
                                                  ? 'assets/rive/sparky_happy.riv'
                                                  : mascotHomeViewModel
                                                              .userMascot
                                                              .health <=
                                                          59
                                                      ? 'assets/rive/sparky_sad.riv'
                                                      : 'assets/rive/sparky_normal.riv',
                                              // 'assets/rive/sparky_happy.riv',
                                              fit: BoxFit.contain,
                                              alignment: Alignment.topRight,
                                            ),
                                      // child: RiveAnimation.asset(
                                      //   mascotHomeViewModel.userMascot.health >=
                                      //           80
                                      //       ? 'assets/rive/sparky_happy.riv'
                                      //       : mascotHomeViewModel
                                      //                   .userMascot.health <=
                                      //               59
                                      //           ? 'assets/rive/sparky_sad.riv'
                                      //           : 'assets/rive/sparky_normal.riv',
                                      //   // 'assets/rive/sparky_happy.riv',
                                      //   fit: BoxFit.contain,
                                      //   alignment: Alignment.topRight,
                                      // ),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                spacing: 12,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: Row(
                                      spacing: 8.0,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.favorite,
                                          color: Colors.redAccent,
                                        ),
                                        Text(
                                          mascotHomeViewModel.userMascot.health
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: Row(
                                      spacing: 8.0,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'BMI',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          mascotHomeViewModel.bmi
                                              .toStringAsFixed(2),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: Row(
                                      spacing: 8.0,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Est. BMI',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          mascotHomeViewModel.estimatedBmi
                                              .toStringAsFixed(2),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      ViewAllTile(title: "Goals", onTap: () {}),
                      const SizedBox(
                        height: 18,
                      ),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: mascotHomeViewModel.goalList.length,
                        itemBuilder: (context, int) {
                          Goal goal = mascotHomeViewModel.goalList[int];
                          UserGoal userGoal =
                              mascotHomeViewModel.userGoalsList[int];
                          return GoalListTile(
                            text: goal.title,
                            isCompleted: userGoal.isCompleted,
                            onTap: () async {
                              final loadingProvider =
                                  Provider.of<LoadingProvider>(context,
                                      listen: false);
                              loadingProvider.showLoading();
                              await mascotHomeViewModel.checkGoalCompletion(
                                  goal: goal,
                                  userGoal: userGoal,
                                  context: context);

                              loadingProvider.hideLoading();
                            },
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 18,
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
