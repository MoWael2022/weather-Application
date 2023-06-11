import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/busniss_logic/profile_cubit/profile_cubit.dart';
import 'package:weather_app/presentation/pages/profile.dart';

import '../../busniss_logic/profile_cubit/profile_state.dart';
import '../../constant/PageRoute.dart';
import '../../constant/color.dart';
import '../Widget/bottomNavigationBar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home.dart';

class HomeScreen extends StatelessWidget {
  TextEditingController locationcontroller = TextEditingController();
  String? country;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Scaffold(
      //backgroundColor: colors.background,
      body: BlocConsumer<ProfileCubit, StateProfile>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
                gradient: BlocProvider.of<ProfileCubit>(context).gradient),
            child: ListView(
              children: [
                Lottie.asset("lotties/9757-welcome.json"),
                Center(
                    child: Text("please enter your location",
                        style: TextStyle(fontSize: 25, color: Colors.teal))),
                Container(
                  padding:
                      EdgeInsets.only(left: 40, top: 30, right: 40, bottom: 10),
                  child: TextFormField(
                    onChanged: (data) {
                      country = data;
                    },
                    controller: locationcontroller,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_on_outlined),
                        labelText: "location",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.zero))),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.only(left: 70, top: 20, right: 70, bottom: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius:
                                BorderRadius.circular(10) // // Background color
                            ),
                        padding: EdgeInsets.all(15)),
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('country', country!);
                      prefs.setString("countryName", country!);
                      Navigator.of(context)
                          .pushReplacementNamed(PageRoutes.home);
                    },
                    child: Text("Enter", style: TextStyle(fontSize: 20)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          clipBehavior: Clip.antiAlias,
          child: bottomNavigationBar()),
    );
  }
}
