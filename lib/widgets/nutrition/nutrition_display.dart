import 'package:breadcrumbs/models/nutrition/nutrition.dart';
import 'package:flutter/material.dart';

class NutritionDisplay extends StatelessWidget {
  const NutritionDisplay({super.key, required this.nutrition});

  final Nutrition nutrition;

  BoxDecoration customBox(Color color) {
    return BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color, // Set the border color here
          width: 1.0, // Set the border width here
        ));
  }

  final headerStyle = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black);

  final titleStyle = const TextStyle(
      fontSize: 13, fontWeight: FontWeight.w400, color: Colors.black);

  final spanStyle = const TextStyle(
      fontSize: 11, fontWeight: FontWeight.w400, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildFirstSection(context),
          const SizedBox(
            height: 16,
          ),
          _buildSecondSection(context),
          const SizedBox(
            height: 16,
          ),
          _buildThirdSection(context),
          const SizedBox(
            height: 16,
          ),
          _buildFourthSection(context),
          const SizedBox(
            height: 16,
          ),
          _buildVitaminHeader(context),
          const SizedBox(
            height: 16,
          ),
          _buildVitamin1Section(context),
          const SizedBox(
            height: 16,
          ),
          _buildVitamin2Section(context),
        ],
      ),
    );
  }

  Widget _buildFirstSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: customBox(const Color.fromRGBO(254, 250, 224, 1)),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${nutrition.calories} kcal",
            style: headerStyle,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Calories",
            style: titleStyle,
          )
        ],
      ),
    );
  }

  Widget _buildSecondSection(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          spacing: 8,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: customBox(const Color.fromRGBO(250, 237, 205, 1)),
                child: Column(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${nutrition.carbohydrates} g",
                      style: headerStyle,
                    ),
                    Text(
                      "Carbohyrates",
                      style: titleStyle,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                          text: TextSpan(
                        text: 'Sugar: ',
                        style: spanStyle,
                        children: <TextSpan>[
                          TextSpan(
                            text: '${nutrition.sugars} g',
                            style: spanStyle,
                          ),
                        ],
                      )),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                          text: TextSpan(
                        text: 'Fibers: ',
                        style: spanStyle,
                        children: <TextSpan>[
                          TextSpan(
                            text: '${nutrition.fibers} g',
                            style: spanStyle,
                          ),
                        ],
                      )),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: customBox(const Color.fromRGBO(250, 237, 205, 1)),
                child: Column(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${nutrition.fats} g",
                      style: headerStyle,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Fats",
                      style: titleStyle,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                          text: TextSpan(
                        text: 'Trans Fat: ',
                        style: spanStyle,
                        children: <TextSpan>[
                          TextSpan(
                            text: '${nutrition.transFat} g',
                            style: spanStyle,
                          ),
                        ],
                      )),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                          text: TextSpan(
                        text: 'Saturated Fats: ',
                        style: spanStyle,
                        children: <TextSpan>[
                          TextSpan(
                            text: '${nutrition.saturatedFats} g',
                            style: spanStyle,
                          ),
                        ],
                      )),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                          text: TextSpan(
                        text: 'Unsaturated Fats: ',
                        style: spanStyle,
                        children: <TextSpan>[
                          TextSpan(
                            text: '${nutrition.unsaturatedFats} g',
                            style: spanStyle,
                          ),
                        ],
                      )),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildThirdSection(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: customBox(const Color.fromRGBO(233, 237, 201, 1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${nutrition.proteins} g",
                  style: headerStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Protein",
                  style: titleStyle,
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: customBox(const Color.fromRGBO(233, 237, 201, 1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${nutrition.sodium} g",
                  style: headerStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Sodium",
                  style: titleStyle,
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: customBox(const Color.fromRGBO(233, 237, 201, 1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${nutrition.proteins} mg",
                  style: headerStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Iron",
                  style: titleStyle,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFourthSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: customBox(const Color.fromRGBO(204, 213, 174, 1)),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${nutrition.cholesterol} mg",
            style: headerStyle,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Cholesterol",
            style: titleStyle,
          )
        ],
      ),
    );
  }

  Widget _buildVitaminHeader(BuildContext context) {
    return const Align(
      child: Text(
        "Vitamin",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildVitamin1Section(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: customBox(const Color.fromRGBO(254, 250, 224, 1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${nutrition.vitamins?.a ?? 0} mcg",
                  style: headerStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "A",
                  style: titleStyle,
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: customBox(const Color.fromRGBO(254, 250, 224, 1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${nutrition.vitamins?.b ?? 0} mg",
                  style: headerStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "B6",
                  style: titleStyle,
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: customBox(const Color.fromRGBO(254, 250, 224, 1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${nutrition.vitamins?.c ?? 0} mg",
                  style: headerStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "C",
                  style: titleStyle,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVitamin2Section(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: customBox(const Color.fromRGBO(221, 161, 94, 1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${nutrition.vitamins?.d ?? 0} mcg",
                  style: headerStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "D",
                  style: titleStyle,
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: customBox(const Color.fromRGBO(221, 161, 94, 1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${nutrition.vitamins?.e ?? 0} mg",
                  style: headerStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "E",
                  style: titleStyle,
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: customBox(const Color.fromRGBO(221, 161, 94, 1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${nutrition.vitamins?.k ?? 0} mcg",
                  style: headerStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "K",
                  style: titleStyle,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
