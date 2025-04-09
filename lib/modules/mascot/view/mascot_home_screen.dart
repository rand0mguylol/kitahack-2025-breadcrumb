import 'package:breadcrumbs/models/goal/goal_model.dart';
import 'package:breadcrumbs/models/goal/user_goal_model.dart';
import 'package:breadcrumbs/modules/mascot/view_model/mascot_home_view_model.dart';
import 'package:breadcrumbs/modules/mascot/widget/goal_list_tile.dart';
import 'package:breadcrumbs/utils/loading/loading.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:breadcrumbs/widgets/text/view_all_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:breadcrumbs/widgets/chart/custom_pie_chart.dart';

class MascotHomeScreen extends StatelessWidget {
  const MascotHomeScreen({super.key, required this.mascotHomeViewModel});

  final MascotHomeViewModel mascotHomeViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Mascot',
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
                              SizedBox(
                                width: chartWidth,
                                height: chartWidth,
                                child: CustomPieChart(
                                  data: [
                                    PieChartData(Colors.transparent, 30),
                                    PieChartData(Colors.redAccent, 70),
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
                                    child: RiveAnimation.asset(
                                      mascotHomeViewModel.userMascot.health >=
                                              80
                                          ? 'assets/rive/sparky_happy.riv'
                                          : mascotHomeViewModel
                                                      .userMascot.health <=
                                                  59
                                              ? 'assets/rive/sparky_sad.riv'
                                              : 'assets/rive/sparky_normal.riv',
                                      // 'assets/rive/sparky_happy.riv',
                                      fit: BoxFit.contain,
                                      alignment: Alignment.topRight,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Row(
                                  spacing: 8.0,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      ViewAllTile(title: "Today's Goals", onTap: () {}),
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
