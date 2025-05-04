import 'package:breadcrumbs/models/user/user_detail_model.dart';
import 'package:breadcrumbs/repository/user/user_repository.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:breadcrumbs/widgets/button/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileHomeScreen extends StatelessWidget {
  const ProfileHomeScreen({super.key, required this.userRepository});

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    UserDetail? userDetail = userRepository.userDetail;

    final nutritionMap = {
      'Calories': userDetail?.nutrition?.calories ?? 'N/A',
      'Cholesterol': userDetail?.nutrition?.cholesterol ?? 'N/A',
      'Carbohydrates': userDetail?.nutrition?.carbohydrates ?? 'N/A',
      'Fats': userDetail?.nutrition?.fats ?? 'N/A',
      'Proteins': userDetail?.nutrition?.proteins ?? 'N/A',
      'Saturated Fat': userDetail?.nutrition?.saturatedFats ?? 'N/A',
      'Sugars': userDetail?.nutrition?.sugars ?? 'N/A',
      'Fibers': userDetail?.nutrition?.fibers ?? 'N/A',
      'Trans Fat': userDetail?.nutrition?.transFat ?? 'N/A',
      'Unsaturated Fat': userDetail?.nutrition?.unsaturatedFats ?? 'N/A',
      'Sodium': userDetail?.nutrition?.sodium ?? 'N/A',
    };

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(16)),
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final entry = nutritionMap.entries.elementAt(index);
                            final key = entry.key; // The key (e.g., 'calories')
                            final value = entry.value; //

                            return ListTile(
                              title: Text(
                                key[0].toUpperCase() +
                                    key.substring(1), // Capitalize the key
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              trailing: Text(
                                (value.toString()),
                              ), // Display the value
                            );
                          },
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: nutritionMap.length),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                          text: 'Sign Out',
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            // await FirebaseAuth.instance.u
                            if (context.mounted) {
                              context.go(Routes.landing.landingScreen);
                            }
                          }),
                    ),
                  ],
                ))),
      ),
    );
  }
}
