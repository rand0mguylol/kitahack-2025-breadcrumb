import 'package:breadcrumbs/repository/analyse/analyse_repository.dart';
import 'package:breadcrumbs/repository/camera/camera_repository.dart';
import 'package:breadcrumbs/repository/firebase_function/firebase_function_repository.dart';
import 'package:breadcrumbs/repository/firebase_storage/firebase_storage_repository.dart';
import 'package:breadcrumbs/repository/goal/goal_repository.dart';
import 'package:breadcrumbs/repository/group/group_repository.dart';
import 'package:breadcrumbs/repository/mascot/user_mascot_repository.dart';
import 'package:breadcrumbs/repository/user/user_repository.dart';
import 'package:breadcrumbs/services/auth/auth_service.dart';
import 'package:breadcrumbs/repository/auth/auth_repository.dart';
import 'package:breadcrumbs/services/firebase_function/firebase_function_service.dart';
import 'package:breadcrumbs/services/firebase_storage/firebase_storage_service.dart';
import 'package:breadcrumbs/services/goal/goal_service.dart';
import 'package:breadcrumbs/services/goal/user_goal_service.dart';
import 'package:breadcrumbs/services/group/group_service.dart';
import 'package:breadcrumbs/services/mascot/user_mascot_service.dart';
import 'package:breadcrumbs/services/user/user_detail_service_.dart';
import 'package:breadcrumbs/services/user/user_meal_service.dart';
import 'package:breadcrumbs/services/user/user_nutrition_service.dart';
import 'package:breadcrumbs/utils/loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// Root Providers
List<SingleChildWidget> rootProviders() => [
      ChangeNotifierProvider(create: (context) => LoadingProvider()),
      ...userProviders,
      ...cameraProviders,
      ...firebaseStorageProviders,
      ...firebaseFunctionProviders,
      ...analyseProviders,
      ...userGoalProviders,
      ...userMascotProviders,
      ...groupProviders,
    ];

List<SingleChildWidget> userProviders = [
  // ----------------- Services -----------------
  // User Auth Service
  Provider(
    create: (context) => AuthService(),
    lazy: false,
  ),
  Provider(
    create: (context) => UserNutritionService(),
    // lazy: false,
  ),

  Provider(
    create: (context) => UserDetailService(),
    // lazy: false,
  ),

  Provider(
    create: (context) => UserMealService(),
    // lazy: false,
  ),

  // ----------------- Repositories -----------------
  Provider(
    create: (context) => UserAuthRepository(userAuthService: context.read()),
    lazy: false,
  ),
  Provider(
    create: (context) => UserRepository(
      userNutritionService: context.read(),
      userDetailService: context.read(),
      userMealService: context.read(),
    ),
    // lazy: false,
  ),
];

List<SingleChildWidget> cameraProviders = [
  Provider(
    create: (context) => CameraRepository(),
    lazy: false,
  )
];

List<SingleChildWidget> firebaseStorageProviders = [
  Provider(create: (context) => FirebaseStorageService()),
  Provider(
      create: (context) =>
          FirebaseStorageRepository(firebaseStorageService: context.read()))
];

List<SingleChildWidget> firebaseFunctionProviders = [
  Provider(create: (context) => FirebaseFunctionService()),
  Provider(
      create: (context) =>
          FirebaseFunctionRepository(firebaseFunctionService: context.read()))
];

List<SingleChildWidget> analyseProviders = [
  Provider(create: (context) => AnalyseRepository()),
];

List<SingleChildWidget> userGoalProviders = [
  Provider(create: (context) => UserGoalService()),
  Provider(
    create: (context) => GoalService(),
  ),
  Provider(create: (context) => GoalRepository(userGoalService: context.read()))
];

List<SingleChildWidget> userMascotProviders = [
  Provider(create: (context) => UserMascotService()),
  Provider(
      create: (context) =>
          UserMascotRepository(userMascotService: context.read()))
];

List<SingleChildWidget> groupProviders = [
  Provider(create: (context) => GroupService()),
  Provider(create: (context) => GroupRepository(groupService: context.read()))
];
