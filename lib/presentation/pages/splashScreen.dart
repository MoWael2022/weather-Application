import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';


import '../../constant/PageRoute.dart';
import 'Home.dart';
import 'SearchPage.dart';
import 'onboarding.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);


  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navScreen();
  }


  _navScreen() async {
    await Future.delayed(Duration(seconds: 4), () {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSign = prefs.getBool('isSignedIn')as bool ;
    //ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed(isSign ? PageRoutes.SearchPage : PageRoutes.onboarding);
    //Navigator.of(context).push(RoutePage( page : Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedCrossFade(
          firstChild: Container(
            color: Colors.white,
          ),
          duration: Duration(seconds: 1),
          crossFadeState: CrossFadeState.showSecond,

          secondChild: Container(
            padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 5.h),
            child: const Image(
              image: AssetImage("images/weather-icon.png"),
              //color: Colors.blueAccent,
            ),
          ),
        ),
      ),
    );
  }
}
