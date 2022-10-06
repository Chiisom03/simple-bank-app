import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Charts extends StatefulWidget {
  final double withdrawal;
  final double deposit;
  const Charts({Key? key, required this.withdrawal, required this.deposit})
      : super(key: key);

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: _buildRadiusPieChart(widget.deposit, widget.withdrawal));
  }
}

SfCircularChart _buildRadiusPieChart(double deposit, double withdraw) {
  return SfCircularChart(
    legend: Legend(overflowMode: LegendItemOverflowMode.wrap),
    series: _getRadiusPieSeries(deposit, withdraw),
    onTooltipRender: (TooltipArgs args) {
      final NumberFormat format = NumberFormat.decimalPattern();
      args.text =
          '${args.dataPoints![args.pointIndex!.toInt()].x} : ${format.format(args.dataPoints![args.pointIndex!.toInt()].y)}';
    },
    tooltipBehavior: TooltipBehavior(enable: true),
  );
}

class ChartData {
  ChartData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  final dynamic x;
  final num? y;
  final dynamic xValue;
  final num? yValue;
  final Color? pointColor;
  final num? size;
  final String? text;
  final num? open;
  final num? close;
  final num? low;
  final num? high;
  final num? volume;
}

List<PieSeries<ChartData, String>> _getRadiusPieSeries(
    double depositLen, double withdrawLen) {
  return <PieSeries<ChartData, String>>[
    PieSeries<ChartData, String>(
        dataSource: <ChartData>[
          ChartData(x: 'Deposit', y: depositLen, text: '45%'),
          ChartData(x: 'Withdrawal', y: withdrawLen, text: '53.7%'),
        ],
        xValueMapper: (ChartData data, _) => data.x as String,
        yValueMapper: (ChartData data, _) => data.y,
        dataLabelMapper: (ChartData data, _) => data.x as String,
        startAngle: 180,
        endAngle: 180,
        pointRadiusMapper: (ChartData data, _) => data.text,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, labelPosition: ChartDataLabelPosition.outside))
  ];
}
