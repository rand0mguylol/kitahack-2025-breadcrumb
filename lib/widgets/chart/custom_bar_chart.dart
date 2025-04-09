import 'dart:async';
import 'dart:math';

// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
// import 'package:fl_chart_app/util/extensions/color_extensions.dart';
import 'package:breadcrumbs/models/nutrition/nutrition.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class VitaminValue {
  VitaminValue(
      {required this.limit, required this.consumed, required this.text});

  final double limit;
  final double consumed;
  final String text;
}

class CustomBarChart extends StatefulWidget {
  CustomBarChart({super.key, required this.vitaminList});

  final List<NutritionDisplay> vitaminList;

  final Color barBackgroundColor = Colors.green.withValues(alpha: 0.1);
  final Color barColor = Colors.green;
  final Color touchedBarColor = Colors.brown;

  @override
  State<StatefulWidget> createState() => CustomBarChartState();
}

class CustomBarChartState extends State<CustomBarChart> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: BarChart(
                    mainBarData(),
                    duration: animDuration,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 10,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor.withAlpha(80))
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 100,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() {
    List<BarChartGroupData> barGroup = [];

    for (int index = 0; index < widget.vitaminList.length; index++) {
      final vitamin = widget.vitaminList[index];
      double calc = (vitamin.consumed / vitamin.limit) * 100;
      double percentage = calc <= 100 ? calc : 100;
      barGroup.add(makeGroupData(index, percentage));
    }

    return barGroup;
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            final vitamin = widget.vitaminList[group.x];
            // String weekDay;
            // switch (group.x) {
            //   case 0:
            //     weekDay = 'A';
            //     break;
            //   case 1:
            //     weekDay = 'B6';
            //     break;
            //   case 2:
            //     weekDay = 'C';
            //     break;
            //   case 3:
            //     weekDay = 'D';
            //     break;
            //   case 4:
            //     weekDay = 'E';
            //     break;
            //   case 5:
            //     weekDay = 'K';
            //     break;
            //   default:
            //     weekDay = 'K';
            //     break;
            // }

            return BarTooltipItem(
              '${vitamin.text}\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      '${(vitamin.consumed).toStringAsFixed(0)} / ${vitamin.limit.toStringAsFixed(0)} ${vitamin.unit}',
                  style: const TextStyle(
                    color: Colors.white, //widget.touchedBarColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    return SideTitleWidget(
      meta: meta,
      space: 16,
      child: Text(
        widget.vitaminList[value.toInt()].text,
        style: style,
      ),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
      animDuration + const Duration(milliseconds: 50),
    );
    if (isPlaying) {
      await refreshState();
    }
  }
}
