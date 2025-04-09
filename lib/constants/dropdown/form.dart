import 'dart:collection';

import 'package:flutter/material.dart';

final List<DropdownMenuEntry<String>> mealTypeEntries =
    UnmodifiableListView<DropdownMenuEntry<String>>(const [
  DropdownMenuEntry(value: "breakfast", label: "Breakfast"),
  DropdownMenuEntry(value: "lunch", label: "Lunch"),
  DropdownMenuEntry(value: "dinner", label: "Dinner"),
  DropdownMenuEntry(value: "snack", label: "Snack"),
  DropdownMenuEntry(value: "dessert", label: "Dessert"),
  DropdownMenuEntry(value: "others", label: "Others"),
]);

final List<DropdownMenuEntry<String>> cookingMethodEntries =
    UnmodifiableListView<DropdownMenuEntry<String>>(const [
  DropdownMenuEntry(value: "boiled", label: "Boiled"),
  DropdownMenuEntry(value: "steamed", label: "Steamed"),
  DropdownMenuEntry(value: "grilled", label: "Grilled"),
  DropdownMenuEntry(value: "baked", label: "Baked"),
  DropdownMenuEntry(value: "roasted", label: "Roasted"),
  DropdownMenuEntry(value: "fried", label: "Fried"),
  DropdownMenuEntry(value: "deep-fried", label: "Deep-Fried"),
  DropdownMenuEntry(value: "sauteed", label: "Sauteed"),
  DropdownMenuEntry(value: "stir-fried", label: "Stir-Fried"),
  DropdownMenuEntry(value: "microwaved", label: "Microwaved"),
  DropdownMenuEntry(value: "others", label: "Others"),
]);

final List<DropdownMenuEntry<String>> portionSizeEntries =
    UnmodifiableListView<DropdownMenuEntry<String>>(const [
  DropdownMenuEntry(value: "small (1/4 serving)", label: "Small (1/4 serving)"),
  DropdownMenuEntry(
      value: "medium (1/2 serving)", label: "Medium (1/2 serving)"),
  DropdownMenuEntry(value: "large (3/4 serving)", label: "Large (3/4 serving)"),
  DropdownMenuEntry(value: "full serving (1x)", label: "Full serving (1x)"),
  DropdownMenuEntry(value: "others", label: "Others"),
]);

final List<DropdownMenuEntry<String>> ingredientUnitEntries =
    UnmodifiableListView<DropdownMenuEntry<String>>(const [
  DropdownMenuEntry(value: "gram (g)", label: "Gram (g)"),
  DropdownMenuEntry(value: "kilogram (kg)", label: "Kilogram (kg)"),
  DropdownMenuEntry(value: "ounce (oz)", label: "Ounce (oz)"),
  DropdownMenuEntry(value: "pound (lb)", label: "Pound (lb)"),
  DropdownMenuEntry(value: "milliliter (ml)", label: "Milliliter (ml)"),
  DropdownMenuEntry(value: "liter (l)", label: "Liter (l)"),
  DropdownMenuEntry(value: "cup", label: "Cup"),
  DropdownMenuEntry(value: "tablespoon (tbsp)", label: "Tablespoon (tbsp)"),
  DropdownMenuEntry(value: "teaspoon (tsp)", label: "Teaspoon (tsp)"),
]);

final List<DropdownMenuEntry<String>> activityLevelEntries =
    UnmodifiableListView<DropdownMenuEntry<String>>(const [
  DropdownMenuEntry(value: "sedentary", label: "Sedentary"),
  DropdownMenuEntry(value: "lightlyActive", label: "Lightly Active"),
  DropdownMenuEntry(value: "moderatelyActive", label: "Moderately Active"),
  DropdownMenuEntry(value: "veryActive", label: "Very Active"),
]);

final List<DropdownMenuEntry<String>> genderEntries =
    UnmodifiableListView<DropdownMenuEntry<String>>(const [
  DropdownMenuEntry(value: "male", label: "Male"),
  DropdownMenuEntry(value: "female", label: "Female"),
]);
