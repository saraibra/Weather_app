import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wheather_app/features/weather_feature/presentation/screens/home_screen.dart';

import '../../../../core/network/cashe_helper.dart';
import '../../../../core/resources/color_manager.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;
  PageController boardControler = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/Weather-pana.svg',
        title: 'Discover the weather in your city',
   ),
    BoardingModel(
        image: 'assets/images/Umbrella-amico.svg',
        title: 'Get weather update & Stay safe',
      ),
  
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                submit();
              },
              child: Container(
                height: 25,
                width: 80,
                decoration: BoxDecoration(
                    color: ColorManager.yellow,
                    borderRadius: BorderRadius.circular(20)),
                child:  Center(
                  child: Text(
                    'Skip',
                    style: TextStyle(color: ColorManager.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
         
            Expanded(
              flex: 1,
              child: PageView.builder(
                controller: boardControler,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                     // navigateAndFinish(context, LoginScreen());
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildOnBoardingItem(boarding[index], context),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SmoothPageIndicator(
                controller: boardControler,
                effect:  ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                    expansionFactor: 4,
                    activeDotColor: ColorManager.yellow),
                count: boarding.length),
            const SizedBox(
              height: 16,
            ),
           
          ],
        ),
      ),
    );
  }
  void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => widget), (route) {
      return false;
    });
  void submit() {
  
    // CasheHelper.saveData(key: 'onBoarding', value: true).then((value) {
    //   if (value) {
         navigateAndFinish(context, HomeScreen());
    //   }
    // });
  }

  Widget buildOnBoardingItem(BoardingModel model, context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              child: SvgPicture.asset(model.image)),
          const SizedBox(
            height: 16,
          ),
          Text(
            model.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16,
          ),

        ],
      );
}
class BoardingModel {
  final String image;
  final String title;

  BoardingModel({required this.image, required this.title});
}