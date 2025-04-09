import 'package:breadcrumbs/modules/landing/view_model/splash_screen_view_model.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen(
      {super.key, required SplashScreenViewModel splashScreenViewModel})
      : _splashScreenViewModel = splashScreenViewModel;

  final SplashScreenViewModel _splashScreenViewModel;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<String> status;

  @override
  void initState() {
    super.initState();
    status = _checkStatus();
  }

  Future<String> _checkStatus() async {
    return await widget._splashScreenViewModel.checkLoginStatus();
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<String>(
            future: status,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                // if (snapshot.data == true) {
                //   WidgetsBinding.instance.addPostFrameCallback((_) {
                //     context.go(Routes.home.home);
                //   });
                // } else {
                //   WidgetsBinding.instance.addPostFrameCallback((_) {
                //     context.go(Routes.landing.landingScreen);
                //   });
                // }
                if (snapshot.data != null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.go(snapshot.data!);
                  });
                }
              }
              return const Center(
                child: Text(
                  "Splash Screen",
                  style: TextStyle(color: Colors.black),
                ),
              );
            }));
  }
}



// ListenableBuilder(
//         listenable: widget._splashScreenViewModel,
//         builder: (BuildContext context, _) {
//           if (widget._splashScreenViewModel.isInit == false) {
//             if (widget._splashScreenViewModel.status) {
//               context.go(Routes.home.home);
//             }

//             context.go(Routes.landing.landingScreen);
//           }

//           return const Center(
//             child: Text("Splash Screen"),
//           );
//         },
//       ),