import 'package:breadcrumbs/modules/food_capture/view_model/food_capture_preview_view_model.dart';
import 'package:breadcrumbs/types/ingredient/ingredient.dart';
import 'package:breadcrumbs/utils/loading/loading.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:breadcrumbs/widgets/form/dropdown.dart';
import 'package:breadcrumbs/widgets/form/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:breadcrumbs/constants/dropdown/form.dart';
import 'package:provider/provider.dart';

class FoodCapturePreviewScreen extends StatefulWidget {
  const FoodCapturePreviewScreen(
      {super.key,
      required FoodCapturePreviewViewModel foodCapturePreviewViewModel})
      : _foodCapturePreviewViewModel = foodCapturePreviewViewModel;

  final FoodCapturePreviewViewModel _foodCapturePreviewViewModel;

  @override
  State<FoodCapturePreviewScreen> createState() =>
      _FoodCapturePreviewScreenState();
}

class _FoodCapturePreviewScreenState extends State<FoodCapturePreviewScreen> {
  final TextEditingController _dishNameController = TextEditingController();
  final TextEditingController _brandRestaurantNameController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _dishNameController.addListener(() {
      widget._foodCapturePreviewViewModel.setDishName(_dishNameController.text);
    });
    _brandRestaurantNameController.addListener(() {
      widget._foodCapturePreviewViewModel
          .setBrandRestaurantName(_brandRestaurantNameController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _dishNameController.dispose();
    _brandRestaurantNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Preview",
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: GestureDetector(
                  onTap: () async {
                    final loadingProvider =
                        Provider.of<LoadingProvider>(context, listen: false);

                    loadingProvider.showLoading();
                    await widget._foodCapturePreviewViewModel
                        .onValidateForm(context);

                    loadingProvider.hideLoading();
                  },
                  child: const Icon(Icons.smart_toy)),
            )
          ],
        ),
        body: Stack(
          children: [
            Expanded(
              child: Image.file(
                widget._foodCapturePreviewViewModel.file,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            ListenableBuilder(
              listenable: widget._foodCapturePreviewViewModel,
              builder: (BuildContext context, _) {
                return DraggableScrollableSheet(
                    initialChildSize: 0.5,
                    minChildSize: 0.3,
                    maxChildSize: 0.6,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return SingleChildScrollView(
                        controller: scrollController,
                        child: Container(
                          color: Colors.white,
                          width: double.infinity,
                          // height: double.maxFinite,
                          padding: const EdgeInsets.all(16.0),
                          child: _buildForm(context),
                        ),
                      );
                    });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: widget._foodCapturePreviewViewModel.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ..._buildTopForm(context),
          ..._buildIngredientForm(context),
        ],
      ),
    );
  }

  List<Widget> _buildTopForm(BuildContext context) {
    return [
      const Text(
        "Details",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
      ),
      const SizedBox(
        height: 15,
      ),
      CustomTextFormField(
          textEditingController: _dishNameController,
          validator: (String? value) {
            return widget._foodCapturePreviewViewModel
                .validateRequiredField(value, "Please enter a valid dish name");
          },
          label: "Dish Name",
          hintText: "Chicken Burger"),
      const SizedBox(
        height: 15,
      ),
      CustomDropdownMenu(
          initialSelection: mealTypeEntries.first.value,
          dropdownMenuEntries: mealTypeEntries,
          onSelected: (String? value) {
            widget._foodCapturePreviewViewModel.setMealType(value!);
          },
          label: "Meal Type"),
      const SizedBox(
        height: 15,
      ),
      CustomDropdownMenu(
          initialSelection: portionSizeEntries.first.value,
          dropdownMenuEntries: portionSizeEntries,
          onSelected: (String? value) {
            widget._foodCapturePreviewViewModel.setPortionSize(value!);
          },
          label: "Portion Size"),
      const SizedBox(
        height: 15,
      ),
      CustomDropdownMenu(
          initialSelection: cookingMethodEntries.first.value,
          dropdownMenuEntries: cookingMethodEntries,
          onSelected: (String? value) {
            widget._foodCapturePreviewViewModel.setCookingMethod(value!);
          },
          label: "Cooking Method"),
      const SizedBox(
        height: 15,
      ),
      CustomTextFormField(
          textEditingController: _brandRestaurantNameController,
          label: "Brand / Restaurant Name",
          hintText: "Mcdonald"),
      const SizedBox(
        height: 15,
      ),
    ];
  }

  List<Widget> _buildIngredientForm(BuildContext context) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Expanded(
              child: Text(
            "Ingredients",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
          )),
          // Icon(Icons.add),
          IconButton(
              onPressed:
                  widget._foodCapturePreviewViewModel.onAddIngredientField,
              icon: Icon(Icons.add)),
          const SizedBox(
            width: 15,
          ),
          IconButton(
              onPressed:
                  widget._foodCapturePreviewViewModel.onRemoveIngredientField,
              icon: Icon(Icons.remove))
        ],
      ),
      ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(
                height: 15,
              ),
          itemCount:
              widget._foodCapturePreviewViewModel.ingredientFieldData.length,
          itemBuilder: (context, index) {
            final fieldData =
                widget._foodCapturePreviewViewModel.ingredientFieldData[index];
            return Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    textEditingController: fieldData.ingredientNameController,
                    validator: (String? value) {
                      return widget._foodCapturePreviewViewModel
                          .validateRequiredField(
                              value, "Please enter a valid ingredient name");
                    },
                    label: "Name",
                    hintText: "Tomato",
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomTextFormField(
                    textEditingController: fieldData.ingredientAmountController,
                    label: "Amount",
                    hintText: "1",
                    validator: (String? value) {
                      return widget._foodCapturePreviewViewModel
                          .validateNumberField(
                              value, "Please enter a valid amount");
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomDropdownMenu(
                      initialSelection: ingredientUnitEntries.first.value,
                      dropdownMenuEntries: ingredientUnitEntries,
                      onSelected: (String? value) {
                        fieldData.ingredientUnitController.text = value!;
                      },
                      label: "Unit"),
                ),
              ],
            );
          })
    ];
  }
}


  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _showBottomSheet();
  //   });
  // }

  // void _showBottomSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         color: Colors.white,
  //         width: double.infinity,
  //         height: 500,
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.max,
  //           children: <Widget>[
  //             const Text(
  //               "Details",
  //               style:
  //                   TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
  //             ),
  //             const SizedBox(
  //               height: 15,
  //             ),
  //             CustomTextFormField(
  //                 textEditingController: _dishNameController,
  //                 label: "Dish Name",
  //                 hintText: "Chicken Burger"),
  //             const SizedBox(
  //               height: 15,
  //             ),
  //             CustomDropdownMenu(
  //                 initialSelection: mealTypeEntries.first.value,
  //                 dropdownMenuEntries: mealTypeEntries,
  //                 onSelected: (String? value) {},
  //                 label: "Meal Type"),
  //             const SizedBox(
  //               height: 15,
  //             ),
  //             CustomDropdownMenu(
  //                 initialSelection: portionSizeEntries.first.value,
  //                 dropdownMenuEntries: portionSizeEntries,
  //                 onSelected: (String? value) {},
  //                 label: "Portion Size"),
  //             const SizedBox(
  //               height: 15,
  //             ),
  //             CustomDropdownMenu(
  //                 initialSelection: cookingMethodEntries.first.value,
  //                 dropdownMenuEntries: cookingMethodEntries,
  //                 onSelected: (String? value) {},
  //                 label: "Cooking Method"),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }