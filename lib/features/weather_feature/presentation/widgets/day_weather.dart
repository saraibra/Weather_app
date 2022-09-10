// //import 'package:d_chart/d_chart.dart';
// import 'package:charts_painter/chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:wheather_app/features/weather_feature/domain/entities/weather_entity.dart';
// import 'package:wheather_app/features/weather_feature/presentation/bloc/weather_bloc.dart';
// import 'package:wheather_app/features/weather_feature/presentation/widgets/day_weather_item.dart';

// import '../../../../core/resources/color_manager.dart';
// import '../../../../core/resources/value_manger.dart';
// import '../../../../core/utils/methods.dart';

// class DayWeather extends StatelessWidget {
//   const DayWeather({Key? key, required this.dayWeather}) : super(key: key);
//   final List<WeatherDetails> dayWeather;

//   @override
//   Widget build(BuildContext context) {
//     BlocProvider.of<WeatherBloc>(context).getChartData(dayWeather);
//     return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
//       return Container(
//           width: double.infinity,
//           height: MediaQuery.of(context).size.height * 0.4,
//           child: Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20)),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
     
//       child: Chart<void>(
//         height: 200.0,
//         state: ChartState(
//           ChartData.fromList(
            
//             /// CHANGE: Change [BarValue<void>] to [BubbleValue<void>]
//             BlocProvider.of<WeatherBloc>(context).tempList.map((e) => BubbleValue<void>(e.toDouble())).toList(),
//             axisMax: 60.0,
//           ),
          
//           /// CHANGE: From [BarItemOptions] to [BubbleItemOptions]
//           itemOptions: BubbleItemOptions(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             /// REMOVED: Radius doesn't exist in [BubbleItemOptions]
//             // radius: BorderRadius.vertical(top: Radius.circular(12.0)),

//             /// ADDED: Make [BubbleValue] items smaller
//             maxBarWidth: 4.0,
//           ),
//           backgroundDecorations: [
//             // GridDecoration(
//             //   verticalAxisStep: 1,
//             //   horizontalAxisStep: 1,
//             // ),
//           ],
//           foregroundDecorations: [

//             /// ADDED: Add spark line decoration ([SparkLineDecoration]) on foreground
//             SparkLineDecoration(
              
//             ),
//           ],
          
//         ),
      
//     )
//                 // DChartBar(
//                 //   showBarValue: true,
//                 //   axisLinePointWidth: 0,
//                 // measureLabelPaddingToTick:4,
//                 // minimumPaddingBetweenLabel: 20,
//                 //   barValue: (lineData,id){return '${lineData['measure'].toString()}''°';},
//                 //   barValuePosition: BarValuePosition.outside,
//                 //   measureLabelPaddingToAxisLine: 16,
//                 //     data:[{'id':'line','data':BlocProvider.of<WeatherBloc>(context).lineData}],
//                 //     barColor: (lineData, index,String id) {
//                 //       return ColorManager.babyBlue;
//                 //     }),
//               )
//           )
//           );
//     });
//   }
// }
