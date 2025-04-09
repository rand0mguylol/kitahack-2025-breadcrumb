import 'package:breadcrumbs/modules/meal/view_model/meal_detail_view_model.dart';
import 'package:breadcrumbs/utils/loading/loading.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:breadcrumbs/widgets/nutrition/nutrition_display.dart';
import 'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen(
      {required this.mealId, required MealDetailViewModel mealDetailViewModel})
      : _mealDetailViewModel = mealDetailViewModel;

  final String mealId;
  final MealDetailViewModel _mealDetailViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: "Meals",
        ),
        body: SingleChildScrollView(
          child: ListenableBuilder(
              listenable: _mealDetailViewModel,
              builder: (context, _) {
                if (_mealDetailViewModel.userMeal == null) return Container();
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                  child: Column(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16)),
                        width: double.infinity,
                        height: 500,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            (_mealDetailViewModel.userMeal?.additionalContext
                                ?.imagePath)!, // Replace with your image URL
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          _mealDetailViewModel.userMeal?.insights ?? "",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      NutritionDisplay(
                          nutrition:
                              (_mealDetailViewModel.userMeal!.nutrition)!)
                    ],
                  ),
                );
              }),
        ));
  }
}
