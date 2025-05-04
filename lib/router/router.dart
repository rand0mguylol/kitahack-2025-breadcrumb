import 'package:breadcrumbs/modules/food_capture/view/food_capture_camera_screen.dart';
import 'package:breadcrumbs/modules/food_capture/view/food_capture_preview_screen.dart';
import 'package:breadcrumbs/modules/food_capture/view/food_capture_summary_screen.dart';
import 'package:breadcrumbs/modules/food_capture/view_model/food_capture_camera_view_model.dart';
import 'package:breadcrumbs/modules/food_capture/view_model/food_capture_preview_view_model.dart';
import 'package:breadcrumbs/modules/food_capture/view_model/food_capture_summary_view_model.dart';
import 'package:breadcrumbs/modules/food_database/view/food_database_add_screen.dart';
import 'package:breadcrumbs/modules/food_database/view/food_database_detail_screen.dart';
import 'package:breadcrumbs/modules/food_database/view/food_database_home_screen.dart';
import 'package:breadcrumbs/modules/food_database/view_model/food_database_add_view_model.dart';
import 'package:breadcrumbs/modules/food_database/view_model/food_database_home_view_model.dart';
import 'package:breadcrumbs/modules/group/view/group_add_screen.dart';
import 'package:breadcrumbs/modules/group/view/group_detail_screen.dart';
import 'package:breadcrumbs/modules/group/view/group_home_screen.dart';
import 'package:breadcrumbs/modules/group/view/group_member_add_screen.dart';
import 'package:breadcrumbs/modules/group/view_model/group_add_view_model.dart';
import 'package:breadcrumbs/modules/group/view_model/group_detail_view_model.dart';
import 'package:breadcrumbs/modules/group/view_model/group_home_view_model.dart';
import 'package:breadcrumbs/modules/group/view_model/group_member_add_view_model.dart';
import 'package:breadcrumbs/modules/home/view_model/home_view_model.dart';
import 'package:breadcrumbs/modules/landing/view/new_login_screen.dart';
import 'package:breadcrumbs/modules/landing/view/splash_screen.dart';
import 'package:breadcrumbs/modules/landing/view/user_onboard_screen.dart';
import 'package:breadcrumbs/modules/landing/view_model/splash_screen_view_model.dart';
import 'package:breadcrumbs/modules/landing/view_model/user_onboard_view_model.dart';
import 'package:breadcrumbs/modules/marketplace/view/marketplace_detail_screen.dart';
import 'package:breadcrumbs/modules/marketplace/view/marketplace_home_screen.dart';
import 'package:breadcrumbs/modules/mascot/view/mascot_home_screen.dart';
import 'package:breadcrumbs/modules/mascot/view_model/mascot_home_view_model.dart';
import 'package:breadcrumbs/modules/meal/view/meal_detail_screen.dart';
import 'package:breadcrumbs/modules/meal/view/meal_home_screen.dart';
import 'package:breadcrumbs/modules/meal/view_model/meal_detail_view_model.dart';
import 'package:breadcrumbs/modules/meal/view_model/meal_home_view_model.dart';
import 'package:breadcrumbs/modules/meal_planner/view/meal_planner_add_screen.dart';
import 'package:breadcrumbs/modules/meal_planner/view/meal_planner_home_screen.dart';
import 'package:breadcrumbs/modules/meal_planner/view/meal_planner_recipe_screen.dart';
import 'package:breadcrumbs/modules/meal_planner/view_model/meal_planner_add_view_model.dart';
import 'package:breadcrumbs/modules/meal_planner/view_model/meal_planner_home_view_model.dart';
import 'package:breadcrumbs/modules/profile/view/profile_home_screen.dart';
import 'package:breadcrumbs/modules/tracker/view/tracker_analytics_screen.dart';
import 'package:breadcrumbs/modules/tracker/view/tracker_home_screen.dart';
import 'package:breadcrumbs/modules/tracker/view_model/tracker_analytics_view_model.dart';
import 'package:breadcrumbs/modules/tracker/view_model/tracket_home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// import 'package:breadcrumbs/modules/landing/view_model/email_verification_view_model.dart';
import 'package:breadcrumbs/modules/landing/view_model/login_view_model.dart';
import 'package:breadcrumbs/modules/landing/view_model/register_view_model.dart';
// import 'package:breadcrumbs/modules/landing/view/email_verification_screen.dart';
import 'package:breadcrumbs/modules/landing/view/login_screen.dart';
import 'package:breadcrumbs/modules/landing/view/landing_screen.dart';
import 'package:breadcrumbs/modules/landing/view/register_screen.dart';

import "package:breadcrumbs/widgets/nav_bar/custom_nav_bar.dart";
import "package:breadcrumbs/router/routes.dart";

import 'package:breadcrumbs/modules/home/view/home_screen.dart';

GoRouter router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'root'),
    initialLocation: Routes.landing.landingScreen,
    routes: [
      GoRoute(
          path: Routes.profileRoute.profileHome,
          builder: (BuildContext context, GoRouterState state) {
            return ProfileHomeScreen(
              userRepository: context.read(),
            );
          }),
      GoRoute(
          path: Routes.landing.splash,
          builder: (BuildContext context, GoRouterState state) {
            final viewModel = SplashScreenViewModel(
                goalService: context.read(),
                userGoalService: context.read(),
                goalRepository: context.read(),
                userAuthRepository: context.read(),
                userRepository: context.read(),
                userMascotRepository: context.read());

            return SplashScreen(splashScreenViewModel: viewModel);
          }),
      GoRoute(
          path: Routes.landing.userOnboard,
          builder: (BuildContext context, GoRouterState state) {
            final viewModel = UserOnboardViewModel(
                firebaseFunctionRepository: context.read(),
                userAuthRepository: context.read(),
                userRepository: context.read(),
                userMascotRepository: context.read());

            return UserOnboardScreen(
              userOnboardViewModel: viewModel,
            );
          }),
      GoRoute(
          path: Routes.landing.landingScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const LandingScreen();
          },
          routes: [
            GoRoute(
                path: Routes.landing.registerRelative,
                builder: (BuildContext context, GoRouterState state) {
                  final viewModel =
                      RegisterViewModel(userAuthRepository: context.read());

                  return RegisterScreen(
                    registerViewModel: viewModel,
                  );
                }),
            GoRoute(
                path: Routes.landing.loginRelative,
                builder: (BuildContext context, GoRouterState state) {
                  final viewModel =
                      LoginViewModel(userAuthRepository: context.read());

                  return LoginScreen(
                    loginViewModel: viewModel,
                  );
                }),
            GoRoute(
                path: Routes.landing.newLoginRelative,
                builder: (BuildContext context, GoRouterState state) {
                  return NewLoginScreen();
                })
          ]),
      GoRoute(
          path: Routes.foodCapture.foodCaptureEntry,
          builder: (BuildContext context, GoRouterState state) {
            final FoodCaptureCameraViewModel viewModel =
                FoodCaptureCameraViewModel(cameraRepository: context.read());

            return FoodCaptureCameraScreen(
              foodCaptureCameraViewModel: viewModel,
            );
          },
          routes: [
            GoRoute(
                path: Routes.foodCapture.foodCapturePreviewRelative,
                builder: (BuildContext context, GoRouterState state) {
                  final FoodCapturePreviewViewModel viewModel =
                      FoodCapturePreviewViewModel(
                    userRepository: context.read(),
                    cameraRepository: context.read(),
                    userAuthRepository: context.read(),
                    firebaseStorageRepository: context.read(),
                    firebaseFunctionRepository: context.read(),
                    analyseRepository: context.read(),
                  );

                  return FoodCapturePreviewScreen(
                      userAuthRepository: context.read(),
                      foodCapturePreviewViewModel: viewModel);
                }),
            GoRoute(
                path: Routes.foodCapture.foodCaptureSummaryRelative,
                builder: (BuildContext context, GoRouterState state) {
                  final viewModel = FoodCaptureSummaryViewModel(
                      analyseRepository: context.read(),
                      userAuthRepository: context.read(),
                      userRepository: context.read());

                  return FoodCaptureSummaryScreen(
                    foodCaptureSummaryViewModel: viewModel,
                  );
                }),
          ]),
      GoRoute(
          path: Routes.mealRoute.mealHome,
          builder: (BuildContext context, GoRouterState state) {
            final viewModel = MealHomeViewModel(
                userRepository: context.read(),
                userAuthRepository: context.read());

            return MealHomeScreen(
              mealHomeViewModel: viewModel,
            );
          },
          routes: [
            GoRoute(
                path: Routes.mealRoute.mealDetailRelative,
                builder: (BuildContext context, GoRouterState state) {
                  final viewModel = MealDetailViewModel(
                      userRepository: context.read(),
                      mealId: state.pathParameters["mealId"]!);

                  return MealDetailScreen(
                    mealId: state.pathParameters["mealId"]!,
                    mealDetailViewModel: viewModel,
                  );
                })
          ]),
      GoRoute(
          path: Routes.mealPlannerRoute.mealPlannerHome,
          builder: (BuildContext context, GoRouterState state) {
            // final viewModel = MealHomeViewModel(
            //     userRepository: context.read(),
            //     userAuthRepository: context.read());

            final vm = MealPlannerViewModel(
                mealPlannerService: context.read(),
                userAuthRepository: context.read(),
                mealPlannerRepository: context.read());

            return MealPlannerHomeScreen(
              mealPlannerViewModel: vm,
            );
          },
          routes: [
            GoRoute(
                path: Routes.mealPlannerRoute.mealPlannerAddRelative,
                builder: (BuildContext context, GoRouterState state) {
                  final vm = MealPlannerAddViewModel(
                      userRepository: context.read(),
                      userAuthRepository: context.read(),
                      firebaseFunctionRepository: context.read(),
                      mealPlannerService: context.read());

                  return MealPlannerAddScreen(
                    mealPlannerAddViewModel: vm,
                  );
                }),
            GoRoute(
                path: Routes.mealPlannerRoute.mealPlannerRecipeRelative,
                builder: (BuildContext context, GoRouterState state) {
                  return MealPlannerRecipeScreen(
                    mealPlannerRepository: context.read(),
                  );
                }),
            GoRoute(
                path: Routes.mealPlannerRoute.marketplaceDetailRelative,
                builder: (BuildContext context, GoRouterState state) {
                  return MarketplaceDetailScreen(
                    foodId: state.pathParameters['foodId']!,
                  );
                }),
          ]),
      GoRoute(
          path: Routes.mascotRoute.mascotHome,
          builder: (BuildContext context, GoRouterState state) {
            final viewModel = MascotHomeViewModel(
                userDetailService: context.read(),
                goalRepository: context.read(),
                userAuthRepository: context.read(),
                userRepository: context.read(),
                userMascotRepository: context.read());
            return MascotHomeScreen(
              mascotHomeViewModel: viewModel,
            );
          }),
      GoRoute(
          path: Routes.foodDatabaseRoute.foodDatabaseHome,
          builder: (BuildContext context, GoRouterState state) {
            final vm =
                FoodDatabaseHomeViewModel(foodDatabaseService: context.read());
            return FoodDatabaseHomeScreen(
              foodDatabaseRepository: context.read(),
              foodDatabaseHomeViewModel: vm,
            );
          },
          routes: [
            GoRoute(
                path: Routes.foodDatabaseRoute.foodDatabaseAddRelative,
                builder: (BuildContext context, GoRouterState state) {
                  final vm = FoodDatabaseAddViewModel(
                      foodDatabaseService: context.read());
                  return FoodDatabaseAddScreen(
                    foodDatabaseAddViewModel: vm,
                  );
                }),
            GoRoute(
              path: Routes.foodDatabaseRoute.foodDatabaseDetailRelative,
              builder: (context, state) {
                return FoodDatabaseDetailScreen(
                    foodDatabaseRepository: context.read());
              },
            )
          ]),
      StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state,
              StatefulNavigationShell navigationShell) {
            return CustomNavigationBar(
              navigationShell: navigationShell,
              index: 0,
            );
          },
          branches: [
            homeShellBranch,
            trackerShellBranch,
            groupShellBranch,
            marketplaceShellBranch
          ])
    ]);

final StatefulShellBranch homeShellBranch = StatefulShellBranch(
  navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'homeTab'),
  routes: [
    GoRoute(
        path: Routes.home.home,
        builder: (BuildContext context, GoRouterState state) {
          final viewModel = HomeViewModel(
            userAuthRepository: context.read(),
            userRepository: context.read(),
            userMascotRepository: context.read(),
          );
          return HomeScreen(
            homeViewModel: viewModel,
          );
        }),
  ],
);

final StatefulShellBranch trackerShellBranch = StatefulShellBranch(
    navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'trackerTab'),
    routes: [
      GoRoute(
          path: Routes.trackerRoute.trackerHome,
          builder: (BuildContext context, GoRouterState state) {
            final viewModel = TrackerHomeViewModel(
                userRepository: context.read(),
                userAuthRepository: context.read());

            return TrackerHomeScreen(
              trackerHomeViewModel: viewModel,
            );
          },
          routes: [
            GoRoute(
                path: Routes.trackerRoute.trackerAnalyticsRelative,
                builder: (BuildContext context, GoRouterState state) {
                  final vm = TrackerAnalyticViewModel(
                      userAuthRepository: context.read(),
                      userNutritionService: context.read(),
                      userDetailService: context.read());
                  return TrackerDetailScreen(
                    userAuthRepository: context.read(),
                    trackerAnalyticViewModel: vm,
                  );
                })
          ])
    ]);

final StatefulShellBranch marketplaceShellBranch = StatefulShellBranch(
    navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'marketplaceTab'),
    routes: [
      GoRoute(
          path: Routes.marketplaceRoute.marketplaceHome,
          builder: (BuildContext context, GoRouterState state) {
            return MarketplaceHomeScreen();
          },
          routes: [
            GoRoute(
                path: Routes.marketplaceRoute.marketplaceDetailRelative,
                builder: (BuildContext context, GoRouterState state) {
                  return MarketplaceDetailScreen(
                      foodId: state.pathParameters['foodId']!);
                })
          ])
    ]);

final StatefulShellBranch groupShellBranch = StatefulShellBranch(routes: [
  GoRoute(
      path: Routes.groupRoute.groupHome,
      builder: (BuildContext context, GoRouterState state) {
        final viewModel = GroupHomeViewModel(
          groupRepository: context.read(),
          userAuthRepository: context.read(),
          context: context,
        );
        return GroupHome(
          groupHomeViewModel: viewModel,
        );
      },
      routes: [
        GoRoute(
          path: Routes.groupRoute.groupAddRelative,
          builder: (context, state) {
            final viewModel = GroupAddViewModel(
              userAuthRepository: context.read(),
              groupRepository: context.read(),
            );
            return GroupAddScreen(
              groupAddViewModel: viewModel,
            );
          },
        ),
        GoRoute(
            path: Routes.groupRoute.groupDetailRelative,
            builder: (context, state) {
              final viewModel = GroupDetailViewModel(
                authRepository: context.read(),
                groupRepository: context.read(),
                userRepository: context.read(),
                groupId: state.pathParameters["groupId"]!,
              );

              return GroupDetailScreen(
                groupDetailViewModel: viewModel,
                groupId: state.pathParameters["groupId"]!,
              );
            },
            routes: [
              GoRoute(
                path: Routes.groupRoute.groupMemberAddRelative,
                builder: (context, state) {
                  final viewModel = GroupMemberAddViewModel(
                    groupId: state.pathParameters["groupId"]!,
                    userRepository: context.read(),
                    authRepository: context.read(),
                    groupRepository: context.read(),
                  );

                  return GroupMemberAddScreen(
                    groupMemberAddViewModel: viewModel,
                    groupId: state.pathParameters["groupId"]!,
                  );
                },
              )
            ])
      ]),
]);
