import 'package:breadcrumbs/constants/dropdown/form.dart';
import 'package:breadcrumbs/models/user/user_nutrition_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:flutter/material.dart';

class ChartData {
  ChartData(this.x, this.y);
  final DateTime x;
  final double y;
}

class SynfusionLineChart extends StatefulWidget {
  const SynfusionLineChart({
    super.key,
    required this.type,
    required this.userNutritionList,
  });

  final String type;
  final List<UserNutrition> userNutritionList;

  @override
  State<SynfusionLineChart> createState() => _SynfusionLineChartState();
}

class _SynfusionLineChartState extends State<SynfusionLineChart> {
  late List<ChartData> typeChartData;
  String yAxisLabel = '';

  @override
  void initState() {
    super.initState();
    buildChartData();
    yAxisLabel = getLabelByValue(widget.type);
    // typeChartData = widget.userNutritionList.map((UserNutrition nutrition) {
    //   Map<String, dynamic> nutritionMap = nutrition.toFirestore();

    //   double value = nutritionMap['nutrition'][widget.type];

    //   print(value);
    //   return ChartData(nutrition.createdAt?.toDate().day ?? 0, value);
    // }).toList();
  }

  @override
  void didUpdateWidget(SynfusionLineChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    buildChartData();
    yAxisLabel = getLabelByValue(widget.type);
  }

  void buildChartData() {
    typeChartData = widget.userNutritionList.map((UserNutrition nutrition) {
      Map<String, dynamic> nutritionMap = nutrition.toFirestore();

      double value = nutritionMap['nutrition'][widget.type];

      print(value);
      return ChartData((nutrition.createdAt?.toDate())!, value);
    }).toList();
  }

  String getLabelByValue(String value) {
    try {
      // Use firstWhere to find the matching entry
      final entry = trackerAnalyticsType.firstWhere(
        (item) => item.value == value,
        // orElse: () => null, // Return null if no match is found
      );

      return entry.label; // Return the label if found
    } catch (e) {
      print('Error: $e');
      // return null;
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        // title: ChartAx,
        primaryYAxis: NumericAxis(
          title: AxisTitle(
              text: yAxisLabel,
              textStyle: const TextStyle(
                  color: Colors.deepOrange,
                  fontFamily: 'Roboto',
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300)),
        ),
        primaryXAxis: const DateTimeAxis(
          intervalType: DateTimeIntervalType.days,
        ),
        series: <CartesianSeries>[
          AreaSeries<ChartData, DateTime>(
              borderColor: Colors.orangeAccent,
              color: Colors.orangeAccent,
              dataSource: typeChartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y)
        ]);
  }
}
