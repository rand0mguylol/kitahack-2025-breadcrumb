import 'package:breadcrumbs/constants/dropdown/form.dart';
import 'package:breadcrumbs/modules/meal_planner/view_model/meal_planner_add_view_model.dart';
import 'package:breadcrumbs/modules/meal_planner/view_model/meal_planner_home_view_model.dart';
import 'package:breadcrumbs/utils/loading/loading.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:breadcrumbs/widgets/date/scrollable_day_picker.dart';
import 'package:breadcrumbs/widgets/form/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MealPlannerAddScreen extends StatefulWidget {
  const MealPlannerAddScreen(
      {super.key, required this.mealPlannerAddViewModel});

  final MealPlannerAddViewModel mealPlannerAddViewModel;
  @override
  State<MealPlannerAddScreen> createState() => _MealPlannerAddScreenState();
}

class _MealPlannerAddScreenState extends State<MealPlannerAddScreen> {
  final TextEditingController _budgetController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void budgetListener() {
    double? value = double.tryParse(_budgetController.text);

    if (value != null) {
      widget.mealPlannerAddViewModel.setBudget(value);
    }
  }

  @override
  void initState() {
    super.initState();

    _budgetController.addListener(budgetListener);
  }

  @override
  void dispose() {
    _budgetController.removeListener(budgetListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Add Planner",
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: InkWell(
                onTap: () async {
                  final loadingProvider =
                      Provider.of<LoadingProvider>(context, listen: false);

                  loadingProvider.showLoading();
                  await widget.mealPlannerAddViewModel
                      .onAddMealPlanner(context, formKey);
                  loadingProvider.hideLoading();
                },
                child: Icon(Icons.add),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: ListenableBuilder(
                listenable: widget.mealPlannerAddViewModel,
                builder: (context, child) {
                  return Form(
                    key: formKey,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Budget",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                              validator: (String? value) {
                                return widget.mealPlannerAddViewModel
                                    .validateNumberField(
                                        value, 'Please enter a valid budget');
                              },
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              inputFormatters: [
                                // Allow Decimal Number With Precision of 2 Only
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}')),
                              ],
                              controller: _budgetController,
                              decoration: const InputDecoration(
                                  // contentPadding: EdgeInsets.only(left: 8), // Add
                                  prefix: Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Text('RM'),
                                  ),
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(130, 132, 144, 1)),
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                  fillColor: Colors.white)),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomDropdownMenu(
                              initialSelection:
                                  mealPlannerGoalEntries.first.value,
                              dropdownMenuEntries: mealPlannerGoalEntries,
                              onSelected: (String? value) {
                                widget.mealPlannerAddViewModel.setGoal(value!);
                              },
                              label: "Goal"),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Date",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 8),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                                border:
                                    Border.all(width: 1, color: Colors.black)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(DateFormat('d/MM/yyyy').format(
                                    widget.mealPlannerAddViewModel.date)),
                                InkWell(
                                  onTap: () async {
                                    final DateTime? pickedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate:
                                          widget.mealPlannerAddViewModel.date,
                                      firstDate: DateTime(2023),
                                      lastDate: DateTime(2026),
                                    );

                                    if (pickedDate != null) {
                                      widget.mealPlannerAddViewModel
                                          .setDate(pickedDate);
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
                  );
                })),
      ),
    );
  }
}
