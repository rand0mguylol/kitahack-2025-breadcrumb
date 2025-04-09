import 'package:breadcrumbs/models/user/user_meal_model.dart';
import 'package:breadcrumbs/modules/meal/view_model/meal_home_view_model.dart';
import 'package:breadcrumbs/utils/loading/loading.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:breadcrumbs/widgets/button/custom_button.dart';
import 'package:flutter/material.dart';

class MealHomeScreen extends StatelessWidget {
  MealHomeScreen({required MealHomeViewModel mealHomeViewModel})
      : _mealHomeViewModel = mealHomeViewModel;

  final MealHomeViewModel _mealHomeViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: "Meals",
        ),
        body: SingleChildScrollView(
          child: LoadingScreen(
            child: ListenableBuilder(
              listenable: _mealHomeViewModel,
              builder: (context, child) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                  child: Column(
                    children: [
                      _buildDateSelection(context),
                      const SizedBox(
                        height: 32,
                      ),
                      _buildMealSection(context)
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }

  Widget _buildDateSelection(BuildContext context) {
    return Column(
      spacing: 12.0,
      children: [
        Text(
          "${_mealHomeViewModel.date.day}/${_mealHomeViewModel.date.month}/${_mealHomeViewModel.date.year}",
          style: const TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12.0,
          children: [
            Expanded(
                child: CustomButton(
              text: "Select Date",
              textColor: Colors.black,
              backgroundColor: Colors.white,
              onPressed: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _mealHomeViewModel.date,
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2026),
                );

                if (pickedDate != null) {
                  _mealHomeViewModel.onChangeDate(pickedDate);
                }
              },
            )),
            // Expanded(child: CustomButton(text: "Search")),
          ],
        )
      ],
    );
  }

  Widget _buildMealSection(BuildContext context) {
    // return Column(
    //   spacing: 16.0,
    //   children: [_mealListTile(context)],
    // );

    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          UserMeal userMeal = _mealHomeViewModel.userMeal[index];
          return _mealListTile(context, userMeal);
        },
        separatorBuilder: (context, _) => SizedBox(
              height: 16.0,
            ),
        itemCount: _mealHomeViewModel.userMeal.length);
  }

  Widget _mealListTile(BuildContext context, UserMeal userMeal) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          _mealHomeViewModel.onNavigateToMealDetail(context, userMeal.id!);
        },
        leading: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          width: 40,
          height: 40,
          child: Image.asset(
            "assets/images/meal/breakfast.png",
            fit: BoxFit.fill,
          ),
        ),
        title: Text(
          userMeal.additionalContext?.dishName ?? "",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          userMeal.additionalContext?.mealType.toUpperCase() ?? "",
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 18,
        ),
      ),
    );
  }
}
