import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/busniss_logic/auth_cubit/auth_cubit.dart';
import 'package:weather_app/busniss_logic/profile_cubit/profile_cubit.dart';
import 'package:weather_app/constant/PageRoute.dart';
import 'package:weather_app/presentation/pages/SearchPage.dart';
import 'package:weather_app/presentation/pages/SignIn.dart';
import 'package:weather_app/presentation/pages/SignUp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/presentation/pages/home.dart';
import 'package:weather_app/presentation/pages/onboarding.dart';
import 'package:weather_app/presentation/pages/profile.dart';
import 'package:weather_app/presentation/pages/splashScreen.dart';

import 'busniss_logic/watherDetails_cubit/weatherDetailsCubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isSignedIn = prefs.getBool('isSignedIn') ?? false;
  runApp(MyApp(isSignedIn: isSignedIn));
}

class MyApp extends StatelessWidget {
  final bool isSignedIn;

  MyApp({super.key, required this.isSignedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, oriantation, devicetype) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
            BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()),
            BlocProvider<WeatherCubit>(create: (context) => WeatherCubit()),
          ],
          child: MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            routes: {
              PageRoutes.splashScreen: (context) => const Splash(),
              PageRoutes.loginPage: (context) => const SignIn(),
              PageRoutes.registerPage: (context) => const SignUp(),
              PageRoutes.profilePage: (context) => profileScreen(),
              PageRoutes.home: (context) => const weatherScreen(),
              PageRoutes.SearchPage: (context) => HomeScreen(),
              PageRoutes.onboarding: (context) => onboardingScreen(),
            },
            home: profileScreen(),
          ),
        );
      },
    );
  }
}
