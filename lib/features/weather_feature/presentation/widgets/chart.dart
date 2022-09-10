import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wheather_app/core/resources/color_manager.dart';

import '../../../../core/resources/value_manger.dart';
import '../../domain/entities/weather_entity.dart';
import '../bloc/weather_bloc.dart';

class LineChartSample5 extends StatelessWidget {
  final List<int> showIndexes = [0, 1, 2, 3, 4, 5, 6, 7];
  final List<WeatherDetails> dayWeather;

  LineChartSample5({Key? key, required this.dayWeather}) : super(key: key);
  List<String> values = [];
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey,
      fontFamily: 'Digital',
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '02:00';
        break;
      case 1:
        text = '05:00';
        break;
      case 2:
        text = '08:00';
        break;
      case 3:
        text = '11:00';
        break;
      case 4:
        text = '14:00';
        break;
      case 5:
        text = '17:00';
        break;
      case 6:
        text = '20:00';
        break;

      case 7:
        text = '23:00';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 2,
      child: Column(
        children: [
          value.toInt() == 0 || value.toInt() == 6 || value.toInt() == 7
              ? Icon(
                  Icons.mode_night,
                  color: ColorManager.yellow,
                  size: AppSize.s16,
                )
              : Icon(
                  Icons.sunny,
                  color: ColorManager.yellow,
                  size: AppSize.s16,
                ),
          Text(text, style: style),
        ],
      ),
    );
  }

  Widget topTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey,
      fontFamily: 'Digital',
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = values[0];
        break;
      case 1:
        text = values[1];
        break;
      case 2:
        text = values[2];
        break;
      case 3:
        text = values[3];
        break;
      case 4:
        text = values[4];
        break;
      case 5:
        text = values[5];
        break;
      case 6:
        text = values[6];
        break;

      case 7:
        text = values[7];
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 20,
      child: Row(
        children: [
          Icon(Icons.water_drop, color: ColorManager.grey,
                  size: AppSize.s12,),
          Text(text, style: style),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<WeatherBloc>(context).getTempData(dayWeather);
    BlocProvider.of<WeatherBloc>(context).getChartData();
    values = BlocProvider.of<WeatherBloc>(context).labels;
    final lineBarsData = [
      LineChartBarData(
        showingIndicators: showIndexes,
        spots: BlocProvider.of<WeatherBloc>(context).list,
        isCurved: false,
        barWidth: 2,
        shadow: Shadow(
          blurRadius: 0,
          color: ColorManager.cyan,
        ),
        dotData: FlDotData(show: false),
        gradient: LinearGradient(
          colors: [
            ColorManager.cyan,
            ColorManager.cyan,
            ColorManager.cyan,
          ],
          stops: [0.1, 0.4, 0.9],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return Container(
      width: double.infinity,
      height: 210,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20,right: 20),
            child: SizedBox(
              height: 180,
              child: LineChart(
                LineChartData(
                  showingTooltipIndicators: showIndexes.map((index) {
                    return ShowingTooltipIndicators([
                      LineBarSpot(
                          tooltipsOnBar,
                          lineBarsData.indexOf(tooltipsOnBar),
                          tooltipsOnBar.spots[index]),
                    ]);
                  }).toList(),
                  lineTouchData: LineTouchData(
                    enabled: false,
                    getTouchedSpotIndicator:
                        (LineChartBarData barData, List<int> spotIndexes) {
                      return spotIndexes.map((index) {
                        return TouchedSpotIndicatorData(
                          FlLine(
                            color: ColorManager.white,
                          ),
                          FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) =>
                                FlDotCirclePainter(
                              radius: 2,
                              color: lerpGradient(
                                barData.gradient!.colors,
                                barData.gradient!.stops!,
                                percent / 100,
                              ),
                              strokeWidth: 2,
                              strokeColor: ColorManager.cyan,
                            ),
                          ),
                        );
                      }).toList();
                    },
                    touchTooltipData: LineTouchTooltipData(
                      tooltipPadding: EdgeInsets.only(bottom: -10),
                      maxContentWidth: 20,
                      tooltipBgColor: ColorManager.white,
                      tooltipRoundedRadius: 4,
                      getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                        return lineBarsSpot.map((lineBarSpot) {
                          return LineTooltipItem(
                            '${lineBarSpot.y.ceil()}' '°'.toString(),
                            TextStyle(color: ColorManager.cyan, fontSize: 12),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  lineBarsData: lineBarsData,
                  minY: 0,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      //axisNameWidget: const Text('count'),
                      sideTitles: SideTitles(
                        showTitles: false,
                        reservedSize: 0,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 70,
                        interval: 1,
                        getTitlesWidget: topTitleWidgets,
                      ),
                    ),
                    rightTitles: AxisTitles(
                      // axisNameWidget: const Text('count'),
                      sideTitles: SideTitles(
                        showTitles: false,
                        reservedSize: 0,
                      ),
                    ),
                    topTitles: AxisTitles(
                      // axisNameWidget: const Text(
                      //   'Wall clock',
                      //   textAlign: TextAlign.left,
                      // ),
                      sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 70,
                          getTitlesWidget: bottomTitleWidgets),
                    ),
                  ),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false, border: Border.all()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Lerps between a [LinearGradient] colors, based on [t]
Color lerpGradient(List<Color> colors, List<double> stops, double t) {
  if (colors.isEmpty) {
    throw ArgumentError('"colors" is empty.');
  } else if (colors.length == 1) {
    return colors[0];
  }

  if (stops.length != colors.length) {
    stops = [];

    /// provided gradientColorStops is invalid and we calculate it here
    colors.asMap().forEach((index, color) {
      final percent = 1.0 / (colors.length - 1);
      stops.add(percent * index);
    });
  }

  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s], rightStop = stops[s + 1];
    final leftColor = colors[s], rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      final sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT)!;
    }
  }
  return colors.last;
}
