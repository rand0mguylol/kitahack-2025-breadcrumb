import 'package:breadcrumbs/models/meal_planner/meal_plan_item_model.dart';

abstract final class Routes {
  static OnboardingRoute onboarding = OnboardingRoute();
  static HomeRoute home = HomeRoute();
  static WalletRoute wallet = WalletRoute();
  static LandingRoute landing = LandingRoute();
  static FoodCaptureRoute foodCapture = FoodCaptureRoute();
  static MealRoute mealRoute = MealRoute();
  static TrackerRoute trackerRoute = TrackerRoute();
  static MarketplaceRoute marketplaceRoute = MarketplaceRoute();
  static MascotRoute mascotRoute = MascotRoute();
  static GroupRoute groupRoute = GroupRoute();
  static ProfileRoute profileRoute = ProfileRoute();
  static MealPlannerRoute mealPlannerRoute = MealPlannerRoute();
  static FoodDatabaseRoute foodDatabaseRoute = FoodDatabaseRoute();
}

final class LandingRoute {
  static const String basePath = "/landing";

  final String landingScreen = basePath;

  final String login = "$basePath/login";
  final String loginRelative = "/login";

  final String register = "$basePath/register";
  final String registerRelative = "/register";

  final String emailVerification = "/email-verification";

  // final String userOnboard = '$basePath/user-onboard';
  final String userOnboard = '/user-onboard';

  final String splash = '/splash';
  final String splashRelative = '/splash';

  final String newLogin = '$basePath/new-login';
  final String newLoginRelative = '/new-login';
}

final class OnboardingRoute {
  static const String basePath = "/onboarding";

  final String landingScreen = basePath;
}

final class HomeRoute {
  static const String _basePath = "home";
  final String home = "/$_basePath";
}

final class WalletRoute {
  static const String basePath = "/wallet";
  final String walletHome = basePath;

  final String walletAdd = "$basePath/add";
  final String walletAddRelative = "/add";

  String walletDetail({required String walletId}) => "$basePath/$walletId";
  final String walletDetailRelative = "/:walletId";
  String walletSetting({required String walletId}) =>
      "$basePath/$walletId/setting";
  final String walletSettingRelative = "/setting";
}

final class FoodCaptureRoute {
  static const String basePath = '/food-capture';

  final String foodCaptureEntry = basePath;

  final String foodCapturePreview = '$basePath/preview';
  // String foodCapturePreview({required String filePath}) => '$basePath/preview';
  final String foodCapturePreviewRelative = '/preview';

  final String foodCaptureSummary = '$basePath/summary';
  final String foodCaptureSummaryRelative = '/summary';

  // final String foodCaptureCamera = '$basePath/camera';
  // final String foodCaptureCameraRelative = '/camera';
}

final class MealRoute {
  static const String basePath = '/meal';

  final String mealHome = basePath;
  // final String mealHomeRelative = '/home';

  String mealDetail({required String mealId}) => '$basePath/$mealId';
  final String mealDetailRelative = '/:mealId';
}

final class TrackerRoute {
  static const String basePath = '/tracker';

  final String trackerHome = basePath;

  final String trackerAnalytics = '$basePath/analytics';

  final String trackerAnalyticsRelative = '/analytics';
}

final class MarketplaceRoute {
  static const String basePath = '/marketplace';

  final String marketplaceHome = basePath;

  String marketplaceDetail({required String foodId}) => '$basePath/$foodId';
  final String marketplaceDetailRelative = '/:foodId';
}

final class MascotRoute {
  static const String basePath = '/mascot';

  final String mascotHome = basePath;
}

final class GroupRoute {
  static const String basePath = '/group';

  final String groupHome = basePath;

  final String groupAdd = '$basePath/add';
  final String groupAddRelative = '/add';

  String groupDetail({required String groupId}) => '$basePath/$groupId';
  final String groupDetailRelative = '/:groupId';

  String groupMemberAdd({required String groupId}) =>
      '$basePath/$groupId/add-member';

  final String groupMemberAddRelative = '/add-member';
}

final class ProfileRoute {
  static const String basePath = '/profile';

  final String profileHome = basePath;
}

final class MealPlannerRoute {
  static const String basePath = '/meal-planner';

  final String mealPlannerHome = basePath;

  final String mealPlannerAdd = '$basePath/add';

  final String mealPlannerAddRelative = '/add';

  final String mealPlannerRecipe = '$basePath/recipe';
  String mealPlannerRecipeRelative = '/recipe';

  String marketplaceDetail({required String foodId}) => '$basePath/$foodId';
  final String marketplaceDetailRelative = '/:foodId';
}

final class FoodDatabaseRoute {
  static const String basePath = '/food-database';

  final String foodDatabaseHome = basePath;

  final String foodDatabaseAdd = '$basePath/add';

  final String foodDatabaseAddRelative = '/add';

  final String foodDatabaseDetail = '$basePath/detail';

  final String foodDatabaseDetailRelative = '/detail';

  // final String foodDatabaseHom
}
