// ignore: unnecessary_import
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appbar_animated/appbar_animated.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/Data/firebase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/constant/PageRoute.dart';
import 'package:weather_app/presentation/pages/profile.dart';
import '../../Data/WeatherData.dart';
import '../../busniss_logic/watherDetails_cubit/weatherDetailsCubit.dart';
import '../../busniss_logic/watherDetails_cubit/weatherDetailsState.dart';
import '../../constant/StringManager.dart';
import '../Widget/bottomNavigationBar.dart';
import '../Widget/detailsDays.dart';
import '../Widget/detailsHour.dart';
import 'SearchPage.dart';
import 'SignIn.dart';

class weatherScreen extends StatefulWidget {
  const weatherScreen({super.key});

  @override
  State<weatherScreen> createState() => _weatherScreenState();
}

class _weatherScreenState extends State<weatherScreen> {
  Future<String?>? _countryNameFuture;

  Future<String?> getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("country");
  }

  @override
  void initState() {
    // TODO: implement initState
    _countryNameFuture = getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    double height1 = MediaQuery.of(context).size.height;
    // TODO: implement build
    //throw UnimplementedError();
    return SafeArea(
      child: FutureBuilder(
          future: _countryNameFuture,
          builder: (context, snapshot) {
            String? countryName = snapshot.data;
            if (snapshot.hasData) {
              return FutureBuilder(
                future: FetchWeatherData.weatherData(countryName!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return BlocConsumer<WeatherCubit, weatherDetailsState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        BlocProvider.of<WeatherCubit>(context)
                            .getState(snapshot.data!.condition);
                        return Scaffold(
                          body: CustomScrollView(
                            slivers: [
                              SliverAppBar(
                                elevation: 0,
                                flexibleSpace: FlexibleSpaceBar(
                                  background: Container(
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          opacity: .6,
                                      image: AssetImage(
                                          BlocProvider.of<WeatherCubit>(context)
                                              .image!),
                                      fit: BoxFit.cover,
                                    )),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 2.w,right: 2.w,bottom: 3.w),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: 25.h,
                                          ),
                                          Row(
                                            verticalDirection:
                                                VerticalDirection.down,
                                            children: [
                                              Text(
                                                "${snapshot.data!.temp.round()}°c",
                                                style: TextStyle(
                                                    fontSize: 20.w,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              Container(
                                                alignment: Alignment.bottomLeft,
                                                height: 20.w,
                                                width: 50.w,
                                                child: Text(
                                                  snapshot.data!.condition,
                                                  style: TextStyle(
                                                      fontSize: 8.w,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                snapshot.data!.time
                                                    .substring(0, 11),
                                                style: TextStyle(
                                                    fontSize: 6.w,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              Text(
                                                "${snapshot.data!.maxTemp.round()}°c/${snapshot.data!.minTemp.round()}°c",
                                                style: TextStyle(
                                                    fontSize: 7.w,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  centerTitle: true,
                                  title: Align(
                                    //alignment: Alignment.topCenter,
                                    child: Padding(
                                      padding:  EdgeInsets.all(2.w),
                                      child: Row(
                                        children: [
                                          Text(
                                            snapshot.data!.name,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 7.w,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.white,
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.white,
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.settings,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                pinned: true,
                                expandedHeight: 50.h,
                              ),
                              SliverList(
                                delegate: SliverChildListDelegate([
                                  Container(
                                    decoration: BoxDecoration(
                                        gradient: BlocProvider.of<WeatherCubit>(
                                                context)
                                            .gradient),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        NotificationListener<
                                            ScrollNotification>(
                                          onNotification: (notification) {
                                            if (notification
                                                is ScrollUpdateNotification) {
                                              // Handle the scroll update notification.
                                            }
                                            return true;
                                          },
                                          child: SingleChildScrollView(
                                            scrollDirection:
                                                Axis.horizontal,
                                            child: Row(
                                              children:
                                                  List.generate(24, (i) {
                                                return DetailsHours(
                                                  temperture: snapshot.data!
                                                      .hours[i]['temp_c']
                                                      .toString(),
                                                  Url: snapshot
                                                          .data!.hours[i]
                                                      ['condition']['icon'],
                                                  time: snapshot.data!
                                                      .hours[i]['time']
                                                      .toString()
                                                      .substring(11),
                                                );
                                              }),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: 7,
                                            itemBuilder: (context, i) {
                                              return DetailsDays(
                                                  date: snapshot.data!.days[i]
                                                  ['date'],
                                                  condition: snapshot.data!.days[i]
                                                  ['day']['condition']['text'],
                                                  url: snapshot.data!.days[i]['day']
                                                  ['condition']['icon'],
                                                  maxtemp: snapshot.data!
                                                      .days[i]['day']['maxtemp_c']
                                                      .toString(),
                                                  mintemp: snapshot.data!
                                                      .days[i]['day']['mintemp_c']
                                                      .toString());
                                            }),
                                      ],
                                    ),
                                  ),

                                ]),
                              )
                            ],
                          ),
                          bottomNavigationBar: const BottomAppBar(
                              shape: CircularNotchedRectangle(),
                              notchMargin: 5,
                              clipBehavior: Clip.antiAlias,
                              child: bottomNavigationBar()),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return AlertDialog(
                      title: const Text("Error"),
                      content: const Text("""please check the internet """),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(PageRoutes.home);
                            },
                            child: Text("Rety")),
                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              );
            } else if (snapshot.hasError) {
              return const Text(
                "error",
                style: TextStyle(fontSize: 20, color: Colors.black),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
