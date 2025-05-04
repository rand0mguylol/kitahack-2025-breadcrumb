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

final List<DropdownMenuEntry<String>> mealPlannerGoalEntries =
    UnmodifiableListView<DropdownMenuEntry<String>>(const [
  DropdownMenuEntry(value: 'lose-weight', label: 'Lose Weight'),
  DropdownMenuEntry(value: 'maintain-weight', label: 'Maintain Weight'),
  DropdownMenuEntry(value: 'gain-weight', label: 'Gain Weight'),
  DropdownMenuEntry(value: 'build-muscle', label: 'Build Muscle'),
  DropdownMenuEntry(
      value: 'increase-energy-level', label: 'Increase Energy Level'),
]);

final List<DropdownMenuEntry<String>> trackerAnalyticsType =
    UnmodifiableListView<DropdownMenuEntry<String>>(const [
  DropdownMenuEntry(value: 'calories', label: 'Calories'),
  DropdownMenuEntry(value: 'cholesterol', label: 'Cholesterol'),
  DropdownMenuEntry(value: 'carbohydrates', label: 'Carbohydrates'),
  DropdownMenuEntry(value: 'fats', label: 'Fats'),
  DropdownMenuEntry(value: 'proteins', label: 'Proteins'),
  DropdownMenuEntry(value: 'saturatedFat', label: 'Saturated Fats'),
  DropdownMenuEntry(value: 'sugars', label: 'Sugars'),
  DropdownMenuEntry(value: 'fibers', label: 'Fibers'),
  DropdownMenuEntry(value: 'transFat', label: 'Trans Fat'),
  DropdownMenuEntry(value: 'sodium', label: 'Sodium'),
  DropdownMenuEntry(value: 'unsaturatedFat', label: 'Unsaturated Fat'),
]);

final List<Map<String, dynamic>> LJList = [
  {
    'id': 'LJ001',
    'title': 'Kale Quinoa Chicken Salad',
    'image': 'assets/images/food/kale-quinoa-chicken-salad.png',
    'price': 'RM 28.00',
    'nutrition': {
      'calories': 514,
      'carbs': 35,
      'protein': 32,
      'fats': 27,
    },
  },
  {
    'id': 'LJ002',
    'title': 'Bangkok Salad',
    'image': 'assets/images/food/bangkok-salad.png',
    'price': 'RM 25.00',
    'nutrition': {
      'calories': 545,
      'carbs': 32,
      'protein': 21,
      'fats': 32,
    },
  },
  {
    'id': 'LJ003',
    'title': 'Caesar Salad',
    'image': 'assets/images/food/caesar-salad.png',
    'price': 'RM 26.00',
    'nutrition': {
      'calories': 696,
      'carbs': 35,
      'protein': 41,
      'fats': 43,
    },
  },
  {
    'id': 'LJ004',
    'title': 'Lean & Green',
    'image': 'assets/images/food/lean-and-green.png',
    'price': 'RM 15.00',
    'nutrition': {
      'calories': 495,
      'carbs': 18,
      'protein': 59,
      'fats': 16,
    },
  },
  {
    'id': 'LJ005',
    'title': 'Kale Mushroom Asada Salad',
    'image': 'assets/images/food/kale-mushroom-asada-salad.png',
    'price': 'RM 27.00',
    'nutrition': {
      'calories': 537,
      'carbs': 36,
      'protein': 26,
      'fats': 33,
    },
  },
  {
    'id': 'LJ006',
    'title': 'Pomegranate Salmon Salad',
    'image': 'assets/images/food/pomegranate-salmon-salad.png',
    'price': 'RM 30.00',
    'nutrition': {
      'calories': 543,
      'carbs': 36,
      'protein': 18,
      'fats': 37,
    },
  },
  {
    'id': 'LJ007',
    'title': 'Keto Penang Mee Mamak',
    'image': 'assets/images/food/keto-penang-mee-mamak.png',
    'price': 'RM 32.00',
    'nutrition': {
      'calories': 442,
      'carbs': 10,
      'protein': 21,
      'fats': 35,
    },
  },
  {
    'id': 'LJ008',
    'title': 'Keto Nyonya Laksa Goreng Beef',
    'image': 'assets/images/food/keto-nyonya-laksa-goreng-beef.png',
    'price': 'RM 18.00',
    'nutrition': {
      'calories': 485,
      'carbs': 20,
      'protein': 36,
      'fats': 29,
    },
  },
  {
    'id': 'LJ009',
    'title': 'Keto Nyonya Laksa Goreng Chicken',
    'image': 'assets/images/food/keto-nyonya-laksa-goreng-chicken.png',
    'price': 'RM 22.00',
    'nutrition': {
      'calories': 507,
      'carbs': 21,
      'protein': 36,
      'fats': 31,
    },
  },
  {
    'id': 'LJ010',
    'title': 'Keto Nyonya Laksa Goreng Tofu',
    'image': 'assets/images/food/keto-nyonya-laksa-goreng-tofu.png',
    'price': 'RM 18.00',
    'nutrition': {
      'calories': 327,
      'carbs': 21,
      'protein': 20,
      'fats': 17,
    },
  },
  {
    'id': 'LJ011',
    'title': 'Pesto Caulirice Bowl',
    'image': 'assets/images/food/pesto-caulirice-bowl.png',
    'price': 'RM 20.00',
    'nutrition': {
      'calories': 362,
      'carbs': 16,
      'protein': 9,
      'fats': 30,
    },
  },
  {
    'id': 'LJ012',
    'title': 'Keto Bowl',
    'image': 'assets/images/food/keto-bowl.png',
    'price': 'RM',
    'nutrition': {
      'calories': 355,
      'carbs': 11,
      'protein': 20,
      'fats': 26,
    },
  },
  {
    'id': 'LJ013',
    'title': 'Fried Rice Quinoa',
    'image': 'assets/images/food/fried-rice-quinoa.png',
    'price': 'RM 32.00',
    'nutrition': {
      'calories': 411,
      'carbs': 50,
      'protein': 24,
      'fats': 14,
    },
  },
  {
    'id': 'LJ014',
    'title': 'Super Nasi Lemak Bowl',
    'image': 'assets/images/food/super-nasi-lemak-bowl.png',
    'price': 'RM 20.00',
    'nutrition': {
      'calories': 951,
      'carbs': 65,
      'protein': 53,
      'fats': 54,
    },
  },
  {
    'id': 'LJ015',
    'title': 'Buddha Bowl',
    'image': 'assets/images/food/buddha-bowl.png',
    'price': 'RM 25.00',
    'nutrition': {
      'calories': 620,
      'carbs': 74,
      'protein': 20,
      'fats': 28,
    },
  },
  {
    'id': 'LJ016',
    'title': 'Multigrain Salmon Bowl',
    'image': 'assets/images/food/multigrain-salmon-bowl.png',
    'price': 'RM',
    'nutrition': {
      'calories': 565,
      'carbs': 61,
      'protein': 27,
      'fats': 25,
    },
  },
  {
    'id': 'LJ017',
    'title': 'Teriyaki Chicken Grain Bowl',
    'image': 'assets/images/food/teriyaki-chicken-grain-bowl.png',
    'price': 'RM 28.00',
    'nutrition': {
      'calories': 676,
      'carbs': 71,
      'protein': 43,
      'fats': 24,
    },
  },
  {
    'id': 'LJ018',
    'title': 'Torched Salmon Poke Bowl',
    'image': 'assets/images/food/torched-salmon-poke-bowl.png',
    'price': 'RM 25.00',
    'nutrition': {
      'calories': 546,
      'carbs': 64,
      'protein': 29,
      'fats': 18,
    },
  },
  {
    'id': 'LJ019',
    'title': 'Tokyo Bowl',
    'image': 'assets/images/food/tokyo-bowl.png',
    'price': 'RM 32.00',
    'nutrition': {
      'calories': 716,
      'carbs': 75,
      'protein': 43,
      'fats': 25,
    },
  },
  {
    'id': 'LJ020',
    'title': 'Mushroom Asada Poke Bowl',
    'image': 'assets/images/food/mushroom-asada-poke-bowl.png',
    'price': 'RM 18.00',
    'nutrition': {
      'calories': 521,
      'carbs': 71,
      'protein': 21,
      'fats': 17,
    },
  },
];
