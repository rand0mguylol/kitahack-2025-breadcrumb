import 'package:breadcrumbs/modules/food_database/view_model/food_database_add_view_model.dart';
import 'package:breadcrumbs/utils/loading/loading.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodDatabaseAddScreen extends StatefulWidget {
  const FoodDatabaseAddScreen({required this.foodDatabaseAddViewModel});

  final FoodDatabaseAddViewModel foodDatabaseAddViewModel;
  @override
  State<FoodDatabaseAddScreen> createState() => _FoodDatabaseAddScreenState();
}

class _FoodDatabaseAddScreenState extends State<FoodDatabaseAddScreen> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _fatsController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _sodiumController = TextEditingController();
  final TextEditingController _sugarController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _titleController.addListener(() {
      widget.foodDatabaseAddViewModel.setTitle(_titleController.text);
    });

    _caloriesController.addListener(() {
      double? value = double.tryParse(_caloriesController.text);

      if (value != null) {
        widget.foodDatabaseAddViewModel.setCalories(value);
      }
    });
    _carbsController.addListener(() {
      double? value = double.tryParse(_carbsController.text);

      if (value != null) {
        widget.foodDatabaseAddViewModel.setCarbs(value);
      }
    });
    _fatsController.addListener(() {
      double? value = double.tryParse(_fatsController.text);

      if (value != null) {
        widget.foodDatabaseAddViewModel.setFat(value);
      }
    });
    _proteinController.addListener(() {
      double? value = double.tryParse(_proteinController.text);

      if (value != null) {
        widget.foodDatabaseAddViewModel.setProtein(value);
      }
    });
    _sodiumController.addListener(() {
      double? value = double.tryParse(_sodiumController.text);

      if (value != null) {
        widget.foodDatabaseAddViewModel.setSodium(value);
      }
    });
    _sugarController.addListener(() {
      double? value = double.tryParse(_sugarController.text);

      if (value != null) {
        widget.foodDatabaseAddViewModel.setSugar(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Add',
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: InkWell(
                  onTap: () async {
                    final loadingProvider =
                        Provider.of<LoadingProvider>(context, listen: false);

                    loadingProvider.showLoading();
                    await widget.foodDatabaseAddViewModel
                        .onClickAdd(context, formKey);

                    loadingProvider.hideLoading();
                  },
                  child: Icon(Icons.add)),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: ListenableBuilder(
            listenable: widget.foodDatabaseAddViewModel,
            builder: (BuildContext context, Widget? child) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      _buildDisplayNameForm(context,
                          controller: _titleController, text: 'Title'),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildNumberForm(context,
                          controller: _caloriesController,
                          text: 'Calories (kcal)'),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildNumberForm(context,
                          controller: _carbsController,
                          text: 'Carbohydates (g)'),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildNumberForm(context,
                          controller: _fatsController, text: 'Fats (g)'),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildNumberForm(context,
                          controller: _proteinController, text: 'Protein (g)'),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildNumberForm(context,
                          controller: _sodiumController, text: 'Sodium (mg)'),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildNumberForm(context,
                          controller: _sugarController, text: 'Sugars (g)')
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDisplayNameForm(BuildContext context,
      {required TextEditingController controller, required String text}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        text,
        style: TextStyle(color: Colors.black),
      ),
      const SizedBox(
        height: 15,
      ),
      TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.black),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return "Please enter a valid display name";
          }

          return null;
          // return widget._userOnboardViewModel.validateRequiredField(
          //     value, "Please enter a valid display name");
        },
        // validator: widget._registerViewModel.validateEmail,
        decoration: const InputDecoration(
            hintStyle: TextStyle(color: Color.fromRGBO(130, 132, 144, 1)),
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            fillColor: Colors.white),
      )
    ]);
  }

  Widget _buildNumberForm(BuildContext context,
      {required TextEditingController controller, required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          controller: controller,
          validator: (String? value) {
            if (value == null) {
              return 'Please enter a valid value';
            }

            if (double.tryParse(value) == null) {
              return 'Please enter a valid value';
            }

            return null;
          },
          style: TextStyle(color: Colors.black),
          decoration: const InputDecoration(
              hintStyle: TextStyle(color: Color.fromRGBO(130, 132, 144, 1)),
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              fillColor: Colors.white),
        )
      ],
    );
  }
}
