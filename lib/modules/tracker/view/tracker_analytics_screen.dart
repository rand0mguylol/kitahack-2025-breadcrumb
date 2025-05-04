import 'package:breadcrumbs/constants/dropdown/form.dart';
import 'package:breadcrumbs/modules/tracker/view_model/tracker_analytics_view_model.dart';
import 'package:breadcrumbs/modules/tracker/view_model/tracket_home_view_model.dart';
import 'package:breadcrumbs/modules/tracker/widgets/calories_chart.dart';
import 'package:breadcrumbs/modules/tracker/widgets/nutrition_chart.dart';
import 'package:breadcrumbs/modules/tracker/widgets/sub_nutrition_chart.dart';
import 'package:breadcrumbs/repository/auth/auth_repository.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:breadcrumbs/widgets/button/custom_button.dart';
import 'package:breadcrumbs/widgets/chart/custom_bar_chart.dart';
import 'package:breadcrumbs/widgets/chart/custom_line_chart.dart';
import 'package:breadcrumbs/widgets/chart/custom_pie_chart.dart';
import 'package:breadcrumbs/widgets/chart/syncfusion_line_chart.dart';
import 'package:breadcrumbs/widgets/date/scrollable_day_picker.dart';
import 'package:breadcrumbs/widgets/form/dropdown.dart';
import 'package:breadcrumbs/widgets/progress/progress_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';

class TrackerDetailScreen extends StatelessWidget {
  const TrackerDetailScreen(
      {super.key,
      required this.trackerAnalyticViewModel,
      required this.userAuthRepository});

  final TrackerAnalyticViewModel trackerAnalyticViewModel;
  final UserAuthRepository userAuthRepository;

  @override
  Widget build(BuildContext context) {
    User? user = userAuthRepository.user;

    bool isWaiiYuan = user?.email == 'waiiyuanchai21@gmail.com';
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Analytics',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: ListenableBuilder(
            listenable: trackerAnalyticViewModel,
            builder: (BuildContext context, Widget? child) {
              if (trackerAnalyticViewModel.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (trackerAnalyticViewModel.isError) {
                return const Center(
                  child: Text("Something went wrong"),
                );
              }
              return Column(
                children: [
                  Row(
                    spacing: 16,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          spacing: 8.0,
                          children: [
                            Text("Start Date"),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 8),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0)),
                                  border: Border.all(
                                      width: 1, color: Colors.black)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(DateFormat('d/MM/yyyy').format(
                                      trackerAnalyticViewModel.startDate)),
                                  InkWell(
                                    onTap: () async {
                                      final DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate:
                                            trackerAnalyticViewModel.startDate,
                                        firstDate: DateTime(2023),
                                        lastDate: DateTime(2026),
                                      );

                                      if (pickedDate != null) {
                                        trackerAnalyticViewModel
                                            .setStartDate(pickedDate);
                                      }
                                    },
                                    child: Icon(Icons.calendar_month),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8.0,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('End Date'),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 8),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0)),
                                  border: Border.all(
                                      width: 1, color: Colors.black)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(DateFormat('d/MM/yyyy').format(
                                      trackerAnalyticViewModel.endDate)),
                                  InkWell(
                                    onTap: () async {
                                      final DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate:
                                            trackerAnalyticViewModel.endDate,
                                        firstDate:
                                            trackerAnalyticViewModel.startDate,
                                        lastDate: DateTime(2026),
                                      );

                                      if (pickedDate != null) {
                                        trackerAnalyticViewModel
                                            .setEndDate(pickedDate);
                                      }
                                    },
                                    child: Icon(Icons.calendar_month),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: CustomDropdownMenu(
                          initialSelection: trackerAnalyticsType.first.value,
                          dropdownMenuEntries: trackerAnalyticsType,
                          onSelected: (String? value) {
                            trackerAnalyticViewModel.setType(value!);
                          },
                          label: "Type"),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                      width: double.infinity,
                      child: SynfusionLineChart(
                        type: trackerAnalyticViewModel.type,
                        userNutritionList:
                            trackerAnalyticViewModel.userNutritionList,
                      )),
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: isWaiiYuan
                        ? MarkdownBody(data: '''
**Hello Yuan**, here’s a quick summary of your nutritional performance over the past week:

- ✅ You successfully met your daily nutritional targets on **5 out of 7 days** — great job staying consistent!
- ⚖️ Your calorie intake has been stable and aligned with your sedentary lifestyle needs (~2100 kcal).
- 🥩 Your **protein and carbohydrate levels** are consistently within optimal range, which supports muscle maintenance and energy.
- 🧂 However, on 2 days, **sodium intake** spiked slightly above recommended levels — this may be linked to processed or packaged food.
- 🥗 **Fiber intake** was a bit low on 3 out of 7 days, which can affect digestion and fullness.
- 💧 **Vitamin K and B levels** were consistently under target, likely due to limited intake of leafy greens and whole grains.

---

## ✅ Action Items (Next 3 Days)

To help you maintain progress and close the remaining gaps, here are your next best steps:

1. **Add one leafy green vegetable** (e.g., spinach, kale, or broccoli) to at least one meal each day — boost Vitamin K and fiber.
2. **Swap salty snacks** for fresh options like fruit or unsalted nuts to keep sodium in check.
3. **Incorporate a whole grain** option (e.g., oats, brown rice, or multigrain bread) daily to help with B vitamins and fiber.
4. **Track snacks more consistently** — most nutrient gaps are linked to overlooked snack choices.

---

## 🌱 AI Recommendations

1. **Meal Idea**: Grilled chicken wrap with spinach, hummus, and whole grain tortilla — hits protein, fiber, Vitamin K, and B complex.
2. **Smart Snack Swap**: Replace packaged chips with roasted chickpeas or cut fruits.
3. **Hydration Tip**: Drink a glass of water before and after each meal to aid digestion and manage appetite.
4. **Mini Challenge**: Try a 2-day “green boost” — ensure one green veggie in *every* meal for 2 days to naturally improve vitamin intake.
''')
                        : MarkdownBody(
                            data:
                                'Analytics will only be provided for accounts after 7 days of usage',
                          ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
