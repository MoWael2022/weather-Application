import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/busniss_logic/watherDetails_cubit/weatherDetailsState.dart';
import 'package:weather_app/constant/StringManager.dart';

import '../../constant/color.dart';

class WeatherCubit extends Cubit<weatherDetailsState> {
  WeatherCubit() : super(WeatherInitial());

  String? image;

  Gradient? gradient;

  getState(String weatherStateName) {
    if (weatherStateName == 'Sunny' || weatherStateName == 'Clear') {
      image = StringManager.clear;
      gradient = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colors.clearLight,
            colors.clearDark,
          ]);
    } else if (weatherStateName == 'Partly cloudy' ||
        weatherStateName == 'Patchy rain possible' ||
        weatherStateName == 'Patchy snow possible' ||
        weatherStateName == 'Patchy sleet possible' ||
        weatherStateName == 'Patchy freezing drizzle possible' ||
        weatherStateName == 'Thundery outbreaks possible') {
      image = StringManager.partlyCloudy;
      gradient = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colors.partlyCloudyLight,
            colors.partlyCloudyDark,
          ]);
    } else if (weatherStateName == 'Patchy light drizzle' ||
        weatherStateName == 'Light drizzle' ||
        weatherStateName == 'Heavy freezing drizzle' ||
        weatherStateName == 'Light rain' ||
        weatherStateName == 'Moderate rain at times' ||
        weatherStateName == 'Moderate rain' ||
        weatherStateName == 'Heavy rain at times' ||
        weatherStateName == 'Heavy rain' ||
        weatherStateName == 'Light freezing rain' ||
        weatherStateName == 'Moderate or heavy freezing rain' ||
        weatherStateName == 'Light snow' ||
        weatherStateName == 'Patchy moderate snow' ||
        weatherStateName == 'Patchy heavy snow' ||
        weatherStateName == 'Heavy snow' ||
        weatherStateName == 'Ice pellets' ||
        weatherStateName == 'Moderate or heavy rain shower' ||
        weatherStateName == 'Torrential rain shower' ||
        weatherStateName == 'Light sleet showers' ||
        weatherStateName == 'Moderate or heavy sleet showers' ||
        weatherStateName == 'Light snow showers' ||
        weatherStateName == 'Moderate or heavy snow showers' ||
        weatherStateName == 'Light snow showers' ||
        weatherStateName == 'Moderate or heavy snow showers' ||
        weatherStateName == 'Light showers of ice pellets' ||
        weatherStateName == 'Moderate or heavy showers of ice pellets') {
      image = StringManager.precipitation;
      gradient = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colors.partlyCloudyLight,
            colors.precipitationDark,
          ]);
    } else if (weatherStateName == 'Cloudy' ||
        weatherStateName == 'Overcast' ||
        weatherStateName == 'Mist') {
      image = StringManager.cloudyOrMisty;
      gradient = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colors.cloudyOrMistyLight,
            colors.cloudyOrMistyDark,
          ]);
    } else if (weatherStateName == 'Thundery outbreaks possible' ||
        weatherStateName == 'Moderate or heavy snow with thunder' ||
        weatherStateName == 'Patchy light snow with thunder' ||
        weatherStateName == 'Moderate or heavy rain with thunder' ||
        weatherStateName == 'Patchy light rain with thunder') {
      image = StringManager.extreme;
      gradient = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colors.extremeLight,
            colors.extremeDark,
          ]);
    } else {
      image = StringManager.clear;
      gradient = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colors.clearLight,
            colors.clearDark,
          ]);
    }
  }
}
