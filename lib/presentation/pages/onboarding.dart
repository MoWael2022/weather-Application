import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_app/presentation/pages/SignIn.dart';

import '../Widget/bildpage.dart';
import 'SearchPage.dart';

/*Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs=await SharedPreferences.getInstance();
  final showHome=prefs.getBool('showHome') ?? false;
  runApp(_onboardingScreenState(showHome : showHome));
}*/
class onboardingScreen extends StatefulWidget{
  @override
  State<onboardingScreen> createState() => _onboardingScreenState();
}

class _onboardingScreenState extends State<onboardingScreen> {
  final controller1 = PageController();
  bool isLastPage = false;
  @override
  void dispose(){
    controller1.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      padding: const EdgeInsets.only(bottom: 80),
      child: PageView(
        controller: controller1,
        onPageChanged: (index) {
          setState(() => isLastPage = index == 2
          );
        },
        children: [
          buildPage(
              color: Colors.lightBlueAccent,
              title: "Welcome to\nMyWeatherApp",
              description: "",
              urlimage: "lotties/58713-weather-icon.json"
          ),
          buildPage(
              color: Colors.lightBlueAccent,
              title: "what is MyWeatherApp",
              description: "MyWeatherApp is an application which present weather in different places in different days.",
              urlimage: "lotties/61302-weather-icon.json"
          ),
          buildPage(
              color: Colors.lightBlueAccent,
              title: "let's begin",
              description: "",
              urlimage: "lotties/61302-weather-icon.json"
          ),
        ],
      ),
    ),
    bottomSheet: isLastPage?
    TextButton(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            primary: Colors.white,
            backgroundColor: Colors.lightBlueAccent,
            minimumSize: const Size.fromHeight(80)
        ),

        onPressed: ()async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('showHome', true);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context)=> SignIn())
          );

        },
        child: const Text("Get Started",style: TextStyle(fontSize: 24),
        )) :
    Container(
      padding: const EdgeInsets.symmetric(horizontal:Checkbox.width ),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(onPressed: ()=>controller1.jumpToPage(2), child: Text("Skip")),
          Center(
            child: SmoothPageIndicator(
              controller : controller1,
              count:3,
              effect: WormEffect(
                  spacing: 16,
                  dotColor: Colors.black26,
                  activeDotColor: Colors.blue
              ),
              onDotClicked: (index)=>controller1.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.easeIn),
            ),
          ),
          TextButton(onPressed: ()=>controller1.nextPage(
              duration: Duration(milliseconds: 500), curve: Curves.easeInOut), child: Text("Next"))

        ],
      ),
    ),
  );
}