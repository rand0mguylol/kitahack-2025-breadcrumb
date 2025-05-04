import 'package:breadcrumbs/modules/meal_planner/view_model/meal_planner_home_view_model.dart';
import 'package:breadcrumbs/repository/meal_planner/meal_planner_repository.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:breadcrumbs/utils/alert/alert.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:breadcrumbs/widgets/date/scrollable_day_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'dart:convert';

class MealPlannerHomeScreen extends StatefulWidget {
  const MealPlannerHomeScreen({
    super.key,
    required this.mealPlannerViewModel,
  });

  final MealPlannerViewModel mealPlannerViewModel;

  @override
  State<MealPlannerHomeScreen> createState() => _MealPlannerHomeScreenState();
}

class _MealPlannerHomeScreenState extends State<MealPlannerHomeScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemWidth = (size.width - 16);
    final double itemHeight = itemWidth * 0.95;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Meal Planner",
        actions: [
          InkWell(
            onTap: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: widget.mealPlannerViewModel.date,
                firstDate: DateTime(2023),
                lastDate: DateTime(2026),
              );

              if (pickedDate != null) {
                widget.mealPlannerViewModel.onChangeDate(pickedDate);
              }
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.calendar_month),
            ),
          )
        ],
      ),
      body: ListenableBuilder(
        listenable: widget.mealPlannerViewModel,
        builder: (context, child) {
          if (widget.mealPlannerViewModel.isError == true) {
            final alert = Alert.of(context);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              alert.showError("Something went wrong");
            });
            return Container();
          }

          if (widget.mealPlannerViewModel.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (widget.mealPlannerViewModel.userMeal == null) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 24),
                  child: _buildDateSelection(context),
                ),
                Divider(
                  thickness: 4,
                  height: 2,
                  color: Colors.black.withOpacity(0.1),
                ),
                Center(
                    child: Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text('No Data')))
              ],
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 24),
                child: _buildDateSelection(context),
              ),
              Divider(
                thickness: 4,
                height: 2,
                color: Colors.black.withOpacity(0.1),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                color: Colors.white,
                child: TabBar(
                  unselectedLabelColor: Colors.grey,
                  controller: _tabController,
                  labelColor: Colors.white,
                  labelPadding: const EdgeInsets.all(5),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  dividerHeight: 0,
                  tabs: const <Widget>[
                    Text(
                      "Breakfast",
                      style: TextStyle(),
                    ),
                    Text(
                      "Lunch",
                      style: TextStyle(),
                    ),
                    Text(
                      "Dinner",
                      style: TextStyle(),
                    ),
                    Text(
                      "Snack",
                      style: TextStyle(),
                    )
                  ],
                ),
              ),
              Divider(
                indent: 16,
                endIndent: 16,
                height: 2,
                color: Colors.black.withOpacity(0.1),
              ),
              Expanded(
                  child: TabBarView(controller: _tabController, children: [
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 1,
                  childAspectRatio: itemWidth / itemHeight,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (widget.mealPlannerViewModel.userMeal?.items[0]
                                .itemType ==
                            'RECIPE') {
                          widget.mealPlannerViewModel.mealPlannerRepository
                                  .recipe =
                              widget.mealPlannerViewModel.userMeal?.items[0];
                          context
                              .push(Routes.mealPlannerRoute.mealPlannerRecipe);
                          return;
                        }
                        if (widget.mealPlannerViewModel.userMeal?.items[0]
                                .itemType ==
                            'FOOD') {
                          context.push(Routes.mealPlannerRoute
                              .marketplaceDetail(
                                  foodId: widget.mealPlannerViewModel.userMeal
                                          ?.items[0].partnerId ??
                                      '0'));
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        color: Colors.white,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black.withValues(alpha: 0.1),
                              ),
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LayoutBuilder(
                                builder: (builder, constraints) {
                                  final width = constraints.maxWidth;
                                  return SizedBox(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8)),
                                      clipBehavior: Clip.hardEdge,
                                      child: Image.asset(
                                        widget.mealPlannerViewModel.userMeal
                                                    ?.items[0].mealType ==
                                                'BREAKFAST'
                                            ? 'assets/images/meal_planner/meal_planner_breakfast.jpg'
                                            : 'assets/images/brand/nissin1.png',
                                        fit: BoxFit.cover,
                                        width: width,
                                        height: width / 2,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Text(
                                    widget.mealPlannerViewModel.userMeal
                                            ?.items[0].title ??
                                        '',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 16.0, bottom: 16.0),
                                child: Row(
                                  spacing: 16,
                                  children: [
                                    Text(
                                      widget.mealPlannerViewModel.userMeal
                                              ?.items[0].itemType ??
                                          '',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Text(
                                      '${widget.mealPlannerViewModel.userMeal?.items[0].nutrition?.calories?.toStringAsFixed(0)} kcal',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 1,
                  childAspectRatio: itemWidth / itemHeight,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (widget.mealPlannerViewModel.userMeal?.items[1]
                                .itemType ==
                            'RECIPE') {
                          widget.mealPlannerViewModel.mealPlannerRepository
                                  .recipe =
                              widget.mealPlannerViewModel.userMeal?.items[1];
                          context
                              .push(Routes.mealPlannerRoute.mealPlannerRecipe);
                          return;
                        }
                        if (widget.mealPlannerViewModel.userMeal?.items[1]
                                .itemType ==
                            'FOOD') {
                          context.push(Routes.mealPlannerRoute
                              .marketplaceDetail(
                                  foodId: widget.mealPlannerViewModel.userMeal
                                          ?.items[1].partnerId ??
                                      '1'));
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        color: Colors.white,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black.withValues(alpha: 0.1),
                              ),
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LayoutBuilder(
                                builder: (builder, constraints) {
                                  final width = constraints.maxWidth;
                                  return SizedBox(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8)),
                                      clipBehavior: Clip.hardEdge,
                                      child: Image.asset(
                                        widget.mealPlannerViewModel.userMeal
                                                    ?.items[1].mealType ==
                                                'LUNCH'
                                            ? 'assets/images/meal_planner/meal_planner_lunch.jpg'
                                            : 'assets/images/brand/nissin1.png',
                                        fit: BoxFit.cover,
                                        width: width,
                                        height: width / 2,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Text(
                                    widget.mealPlannerViewModel.userMeal
                                            ?.items[1].title ??
                                        '',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 16.0, bottom: 16.0),
                                child: Row(
                                  spacing: 16,
                                  children: [
                                    Text(
                                      widget.mealPlannerViewModel.userMeal
                                              ?.items[1].itemType ??
                                          '',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Text(
                                      '${widget.mealPlannerViewModel.userMeal?.items[1].nutrition?.calories?.toStringAsFixed(0)} kcal',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 1,
                  childAspectRatio: itemWidth / itemHeight,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (widget.mealPlannerViewModel.userMeal?.items[2]
                                .itemType ==
                            'RECIPE') {
                          widget.mealPlannerViewModel.mealPlannerRepository
                                  .recipe =
                              widget.mealPlannerViewModel.userMeal?.items[2];
                          context
                              .push(Routes.mealPlannerRoute.mealPlannerRecipe);
                          return;
                        }
                        if (widget.mealPlannerViewModel.userMeal?.items[2]
                                .itemType ==
                            'FOOD') {
                          context.push(Routes.mealPlannerRoute
                              .marketplaceDetail(
                                  foodId: widget.mealPlannerViewModel.userMeal
                                          ?.items[2].partnerId ??
                                      '2'));
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        color: Colors.white,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black.withValues(alpha: 0.1),
                              ),
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LayoutBuilder(
                                builder: (builder, constraints) {
                                  final width = constraints.maxWidth;
                                  return SizedBox(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8)),
                                      clipBehavior: Clip.hardEdge,
                                      child: Image.asset(
                                        widget.mealPlannerViewModel.userMeal
                                                    ?.items[2].mealType ==
                                                'DINNER'
                                            ? 'assets/images/meal_planner/meal_planner_dinner.jpg'
                                            : 'assets/images/brand/nissin1.png',
                                        fit: BoxFit.cover,
                                        width: width,
                                        height: width / 2,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Text(
                                    widget.mealPlannerViewModel.userMeal
                                            ?.items[2].title ??
                                        '',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 16.0, bottom: 16.0),
                                child: Row(
                                  spacing: 16,
                                  children: [
                                    Text(
                                      widget.mealPlannerViewModel.userMeal
                                              ?.items[2].itemType ??
                                          '',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Text(
                                      '${widget.mealPlannerViewModel.userMeal?.items[2].nutrition?.calories?.toStringAsFixed(0)} kcal',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 1,
                  childAspectRatio: itemWidth / itemHeight,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (widget.mealPlannerViewModel.userMeal?.items[3]
                                .itemType ==
                            'RECIPE') {
                          widget.mealPlannerViewModel.mealPlannerRepository
                                  .recipe =
                              widget.mealPlannerViewModel.userMeal?.items[3];
                          context
                              .push(Routes.mealPlannerRoute.mealPlannerRecipe);
                          return;
                        }

                        if (widget.mealPlannerViewModel.userMeal?.items[3]
                                .itemType ==
                            'FOOD') {
                          context.push(Routes.mealPlannerRoute
                              .marketplaceDetail(
                                  foodId: widget.mealPlannerViewModel.userMeal
                                          ?.items[3].partnerId ??
                                      '3'));
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        color: Colors.white,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black.withValues(alpha: 0.1),
                              ),
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LayoutBuilder(
                                builder: (builder, constraints) {
                                  final width = constraints.maxWidth;
                                  return SizedBox(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8)),
                                      clipBehavior: Clip.hardEdge,
                                      child: Image.asset(
                                        widget.mealPlannerViewModel.userMeal
                                                    ?.items[3].mealType ==
                                                'SNACK'
                                            ? 'assets/images/meal_planner/meal_planner_snack.jpg'
                                            : 'assets/images/brand/nissin1.png',
                                        fit: BoxFit.cover,
                                        width: width,
                                        height: width / 2,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Text(
                                    widget.mealPlannerViewModel.userMeal
                                            ?.items[3].title ??
                                        '',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 16.0, bottom: 16.0),
                                child: Row(
                                  spacing: 16,
                                  children: [
                                    Text(
                                      widget.mealPlannerViewModel.userMeal
                                              ?.items[3].itemType ??
                                          '',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Text(
                                      '${widget.mealPlannerViewModel.userMeal?.items[3].nutrition?.calories?.toStringAsFixed(0)} kcal',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ])),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(Routes.mealPlannerRoute.mealPlannerAdd);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDateSelection(BuildContext context) {
    return Column(
      spacing: 24.0,
      children: [
        Text(
          "${DateFormat('MMM').format(widget.mealPlannerViewModel.date)} ${DateFormat('d').format(widget.mealPlannerViewModel.date)}, ${widget.mealPlannerViewModel.date.year}",
          style: const TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        ResponsiveScrollableDayPicker(
          selectedDate: widget.mealPlannerViewModel.date,
          onClickCallback: (DateTime date) {
            widget.mealPlannerViewModel.onChangeDate(date);
          },
        )
      ],
    );
  }
}
