import 'package:breadcrumbs/modules/food_capture/view_model/food_capture_summary_view_model.dart';
import 'package:breadcrumbs/utils/loading/loading.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:breadcrumbs/widgets/button/custom_button.dart';
import 'package:breadcrumbs/widgets/layout/root_body.dart';
import 'package:breadcrumbs/widgets/nutrition/nutrition_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodCaptureSummaryScreen extends StatelessWidget {
  const FoodCaptureSummaryScreen(
      {super.key,
      required FoodCaptureSummaryViewModel foodCaptureSummaryViewModel})
      : _foodCaptureSummaryViewModel = foodCaptureSummaryViewModel;

  final FoodCaptureSummaryViewModel _foodCaptureSummaryViewModel;

  BoxDecoration customBox(Color color) {
    return BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color, // Set the border color here
          width: 1.0, // Set the border width here
        ));
  }

  final headerStyle = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black);

  final titleStyle = const TextStyle(
      fontSize: 13, fontWeight: FontWeight.w400, color: Colors.black);

  final spanStyle = const TextStyle(
      fontSize: 11, fontWeight: FontWeight.w400, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: "Summary",
        ),
        body: RootBody(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    _foodCaptureSummaryViewModel.insights,
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
                    nutrition: _foodCaptureSummaryViewModel.nutrition),
                const SizedBox(
                  height: 16,
                ),
                _buildCTASection(context)
              ],
            ),
          ),
        )));
  }

  Widget _buildCTASection(BuildContext context) {
    return Column(
      spacing: 16.0,
      children: [
        SizedBox(
            width: double.infinity,
            child: CustomButton(
              text: "Add to Tracker",
              onPressed: () async {
                final loadingProvider =
                    Provider.of<LoadingProvider>(context, listen: false);

                loadingProvider.showLoading();
                await _foodCaptureSummaryViewModel.onAddToTracker(context);

                loadingProvider.hideLoading();
              },
            )),
        SizedBox(
            width: double.infinity,
            child: CustomButton(
              text: "Cancel",
              textColor: Colors.black,
              backgroundColor: Colors.white,
            ))
      ],
    );
  }
}
