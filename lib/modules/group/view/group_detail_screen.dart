import 'package:breadcrumbs/models/user/user_detail_model.dart';
import 'package:breadcrumbs/models/user/user_meal_model.dart';
import 'package:breadcrumbs/modules/group/view_model/group_detail_view_model.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GroupDetailScreen extends StatelessWidget {
  const GroupDetailScreen(
      {super.key, required this.groupId, required this.groupDetailViewModel});

  final String groupId;
  final GroupDetailViewModel groupDetailViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Detail', actions: [
          IconButton(
              onPressed: () {
                context.go(Routes.groupRoute.groupMemberAdd(groupId: groupId));
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 24,
              )),
        ]),
        body: SafeArea(
            child: SingleChildScrollView(
          child: ListenableBuilder(
            listenable: groupDetailViewModel,
            builder: (context, child) {
              return Container(
                padding: const EdgeInsets.all(12.0),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          width: constraints.maxWidth * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            spacing: 8.0,
                            children: [
                              const Icon(Icons.local_fire_department,
                                  size: 45, color: Colors.orangeAccent),
                              Text(
                                groupDetailViewModel.currentGroup.streakCount
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 24),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12.0),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Members",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  if (groupDetailViewModel.groupMembers == null)
                    const SizedBox.shrink()
                  else
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: groupDetailViewModel.groupMembers!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(groupDetailViewModel
                                .groupMembers![index].displayName!),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 34.0),
                  _buildMealTypeSection(),
                  const SizedBox(height: 34.0),
                  if (groupDetailViewModel.groupMembers == null)
                    const SizedBox.shrink()
                  else
                    _buildMealDisplay(context)
                ]),
              );
            },
          ),
        )));
  }

  Widget _buildMealDisplay(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Start of Users
              Row(
                children: groupDetailViewModel.groupMembers!
                    .map((user) => Container(
                          width: 120,
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            user.displayName!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),

              // Start of Meals
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: groupDetailViewModel.groupMembers!.map((user) {
                  List<UserMeal> um =
                      groupDetailViewModel.userMealMap[user.uid] ?? [];
                  List<UserMeal> filteredMeals = um
                      .where((meal) =>
                          meal.additionalContext!.mealType ==
                          groupDetailViewModel.selected)
                      .toList();

                  if (filteredMeals.isEmpty) {
                    return Container(
                      width: 120,
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: const Text(
                        "No meals recorded",
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  // Start of inidividual user meal cards
                  return Column(
                    spacing: 16.0,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: filteredMeals.map((meal) {
                      // Start of Card
                      return GestureDetector(
                        onTap: () {
                          // Navigate to meal detail screen
                          context.push(
                              Routes.mealRoute.mealDetail(mealId: meal.id!));
                        },
                        child: Container(
                          width: 120,
                          height: 150,
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          // Start of Meal Cards Content
                          child: Column(
                            spacing: 12.0,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(16),
                                    shape: BoxShape.circle),
                                width: 40,
                                height: 40,
                                child: Image.network(
                                  meal.additionalContext!.imagePath,
                                  // "assets/images/meal/breakfast.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  meal.additionalContext!.dishName,
                                  style: const TextStyle(color: Colors.black),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }).toList(),
              )
            ],
          ),
        ));
  }

  Widget buildDynamicGridWithListView(
    List<UserDetail> groupMembers,

    // Map<String, List<String>> userMeals
  ) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal, // Enable horizontal scrolling
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First Row: Users
            Row(
              mainAxisSize: MainAxisSize.max,
              children: groupMembers.map((user) {
                return Container(
                  width: 120, // Fixed width for each column
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      // CircleAvatar(
                      //   radius: 24,
                      //   child:
                      //       Text(user.displayName[0]), // Display first letter
                      // ),
                      const SizedBox(height: 8),
                      Text(
                        user.displayName!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ],
    );
  }

  Widget _buildMealTypeSection() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Wrap(
        spacing: 24.0,
        runSpacing: 24.0,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          _buildMealTypeSelection(
              image: "assets/images/meal/breakfast.png",
              text: 'Breakfast',
              selectedType: 'breakfast'),
          _buildMealTypeSelection(
              image: "assets/images/meal/lunch.png",
              text: 'Lunch',
              selectedType: 'lunch'),
          _buildMealTypeSelection(
              image: "assets/images/meal/dinner.png",
              text: 'Dinner',
              selectedType: 'dinner'),
          _buildMealTypeSelection(
              image: "assets/images/meal/dessert.png",
              text: 'Dessert',
              selectedType: 'dessert'),
          _buildMealTypeSelection(
              image: "assets/images/meal/snack.png",
              text: 'Snack',
              selectedType: 'snack'),
          _buildMealTypeSelection(
              image: "assets/images/meal/others.png",
              text: 'Others',
              selectedType: 'others'),
        ],
      ),
    );
  }

  Widget _buildMealTypeSelection(
      {required String image,
      required String text,
      required String selectedType}) {
    return GestureDetector(
      onTap: () {
        groupDetailViewModel.onChangeSelected(selectedType);
      },
      child: Container(
        alignment: Alignment.center,
        width: 80,
        height: 90,
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          border: selectedType == groupDetailViewModel.selected
              ? Border.all(color: Colors.blue)
              : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          spacing: 8.0,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              width: 40,
              height: 40,
              child: Image.asset(
                image,
                // ,
                fit: BoxFit.fill,
              ),
            ),
            Text(
              text,
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
