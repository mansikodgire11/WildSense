import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomChart extends StatelessWidget {
  const CustomChart({Key? key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: 300,
        height: 300,
        child: SfCircularChart(
          legend: const Legend(
            isVisible: true,
            overflowMode: LegendItemOverflowMode.wrap,
          ),
          series: _getCustomChartSeries(),
          tooltipBehavior: TooltipBehavior(enable: true),
        ),
      ),
    );
  }

  List<DoughnutSeries<ChartSampleData, String>> _getCustomChartSeries() {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
        dataSource: <ChartSampleData>[
          ChartSampleData(x: 'Category 1', y: 20),
          ChartSampleData(x: 'Category 2', y: 30),
          ChartSampleData(x: 'Category 3', y: 25),
          ChartSampleData(x: 'Category 4', y: 15),
          ChartSampleData(x: 'Category 5', y: 10),
        ],
        xValueMapper: (ChartSampleData data, _) => data.x,
        yValueMapper: (ChartSampleData data, _) => data.y,
        startAngle: 90,
        endAngle: 90,
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          labelPosition: ChartDataLabelPosition.outside,
          textStyle: TextStyle(
            color: Colors.white,
          ),
          color: Colors.transparent, // Set color to transparent to avoid default black color
        ),
      ),
    ];
  }
}

class ChartSampleData {
  final String x;
  final double y;

  ChartSampleData({required this.x, required this.y});
}
