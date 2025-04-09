import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavigationBar extends StatelessWidget {
  // final Function(int) onChangeDestination;
  final int index;

  final StatefulNavigationShell _navigationShell;

  const CustomNavigationBar(
      {super.key,
      // required this.onChangeDestination,
      required this.index,
      required StatefulNavigationShell navigationShell})
      : _navigationShell = navigationShell;

  @override
  Widget build(BuildContext context) {
    //  GoRouter.of(context).go('/');
    return Scaffold(
      body: _navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _navigationShell.currentIndex,
        onDestinationSelected: (int index) {
          // GoRouter.of(context).go('/home');
          _navigationShell.goBranch(index);
        },
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.calendar_month),
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Tracker',
          ),
          // SizedBox(
          //   height: 100,
          //   child: Stack(clipBehavior: Clip.none, children: [
          //     Positioned(
          //         height: 80,
          //         // top: 0,
          //         left: 0,
          //         right: 0,
          //         bottom: 20,
          //         child: Container(
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(50),
          //           ),
          //           child: Center(
          //               child: FloatingActionButton(
          //                   // icon: const Icon(Icons.camera_alt_outlined),
          //                   child: const Icon(Icons.camera_alt_outlined),
          //                   shape: const CircleBorder(),
          //                   onPressed: () {
          //                     _navigationShell.goBranch(2);
          //                     // RouteHelper().redirectTo(const OCRScannerScreen());
          //                   })),
          //         ))
          //   ]),
          // ),

          const NavigationDestination(
            selectedIcon: Icon(Icons.group),
            icon: Icon(Icons.group_outlined),
            label: 'Group',
          ),
          const NavigationDestination(
            selectedIcon: Icon(Icons.food_bank),
            icon: Icon(Icons.food_bank_outlined),
            label: 'Marketplace',
          ),
        ],
      ),
    );
  }
}
