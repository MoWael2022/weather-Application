import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/Data/model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_app/constant/StringManager.dart';
import "package:bloc/bloc.dart";
import 'package:weather_app/presentation/Widget/ImageSetting.dart';
import 'package:weather_app/presentation/pages/SignIn.dart';
import 'package:weather_app/presentation/pages/home.dart';
import '../../busniss_logic/profile_cubit/profile_cubit.dart';
import '../../busniss_logic/profile_cubit/profile_state.dart';
import '../../constant/PageRoute.dart';
import '../../constant/color.dart';
import '../Widget/FiledProfile.dart';
import '../Widget/bottomNavigationBar.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({Key? key}) : super(key: key);

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  var ref = FirebaseStorage.instance.ref();

  List<Future<String>>? data;
  String? name;
  String? email;

  Future<String> getprefsName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("name")!;
  }

  Future<String> getprefsEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("email")!;
  }

  @override
  void initState() {
    super.initState();
    getprefsName().then((value) => name = value);
    getprefsEmail().then((value) => email = value);
    data = [getprefsName(), getprefsEmail()];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String?>>(
        future: Future.wait(data!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BlocConsumer<ProfileCubit, StateProfile>(
              listener: (context, state) {},
              builder: (context, state) {
                return Scaffold(
                  body: Container(
                    decoration: BoxDecoration(
                        gradient:
                            BlocProvider.of<ProfileCubit>(context).gradient),
                    child: ListView(
                      children: [
                        FutureBuilder(
                            future: BlocProvider.of<ProfileCubit>(context)
                                .returnUrl(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return BlocConsumer<ProfileCubit, StateProfile>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    return CircleAvatar(
                                      radius: 35.w,
                                      // adjust the size of the avatar as needed
                                      backgroundImage:
                                          NetworkImage(snapshot.data!),
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return ImageSetting(
                                                  fun1: () {
                                                    BlocProvider.of<
                                                                ProfileCubit>(
                                                            context)
                                                        .setImage();
                                                    Navigator.pop(context);
                                                  },
                                                  fun2: () {
                                                    BlocProvider.of<
                                                                ProfileCubit>(
                                                            context)
                                                        .deleteImage();
                                                    Navigator.pop(context);
                                                  },
                                                );
                                              });
                                          // BlocProvider.of<ProfileCubit>(context).setImage();
                                        },
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                        Center(
                            child: Text(
                          "${snapshot.data![0]}",
                          style: TextStyle(
                              color:
                                  BlocProvider.of<ProfileCubit>(context).text,
                              fontSize: 10.w),
                        )),
                        Center(
                            child: Text(
                          "${snapshot.data![1]}",
                          style: TextStyle(
                              color:
                                  BlocProvider.of<ProfileCubit>(context).text,
                              fontSize: 4.w),
                        )),
                        SizedBox(
                          height: 8.h,
                        ),
                        FieldProfile(
                          data: "Setting",
                          icon: Icons.settings,
                        ),
                        FieldProfile(
                          data: "Language",
                          icon: Icons.language,
                        ),
                        Padding(
                          padding: EdgeInsets.all(2.w),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                            color: Colors.white,
                            child: ListTile(
                              leading: const Icon(
                                Icons.nightlight_outlined,
                                color: Colors.black,
                              ),
                              title: Text(
                                BlocProvider.of<ProfileCubit>(context).theme,
                              ),
                              trailing: Switch(
                                value: BlocProvider.of<ProfileCubit>(context)
                                    .value,
                                onChanged: (val) {
                                  BlocProvider.of<ProfileCubit>(context)
                                      .getColor(val);
                                  setState(() {
                                    BlocProvider.of<ProfileCubit>(context)
                                        .value = val;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        FieldProfile(
                            data: "Sign Out",
                            icon: Icons.exit_to_app,
                            fun1: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.clear();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  PageRoutes.loginPage, (route) => false);
                            }),
                      ],
                    ),
                  ),
                  bottomNavigationBar: bottomNavigationBar(),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error"));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

// class profileScreen extends StatefulWidget{
//
//   @override
//   State<profileScreen> createState() => _profileScreenState();
// }
//
// class _profileScreenState extends State<profileScreen> {
//   bool isSwitched = false;
//
//   void toggleSwitch(bool value) {
//
//     // if(isSwitched == false)
//     // {
//     //   setState(() {
//     //     isSwitched = true;
//     //     colors.background=Colors.black26;
//     //
//     //   });
//     //   print('Switch Button is ON');
//     // }
//     // else
//     // {
//     //   setState(() {
//     //     isSwitched = false;
//     //     colors().background=Colors.white;
//     //   });
//     //   print('Switch Button is OFF');
//     // }
//   }
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     //throw UnimplementedError();
//     return Scaffold(
//       backgroundColor: colors.background,
//       body:
//       SingleChildScrollView(
//         child: Container(
//           width: double.infinity,
//           margin: EdgeInsets.all(20),
//           child: Column(
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.black,
//                 radius: 61,
//                 child:
//                 CircleAvatar(
//                   radius: 60,
//                   backgroundImage: AssetImage("images/551-5511364_circle-profile-man-hd-png-download.png"),
//                 ),),
//               SizedBox(
//                 height: 8,
//               ),
//               Text("Alex Marshall",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//               SizedBox(
//                 height: 5,
//               ),
//               Text("@alex_marshall",style: TextStyle(color: Colors.grey),),
//               SizedBox(
//                 height: 35,
//               ),
//               Divider(
//                 color: Colors.black12,
//               ),
//               Wrap(
//                 spacing: 8.0, // gap between adjacent chips
//                 runSpacing: 15.0, // gap between lines
//                 children: <Widget>[
//                   TextButton(
//                       style: OutlinedButton.styleFrom(
//                           backgroundColor: Colors.white),
//                       child: Row(
//                         children: [
//                           Icon(Icons.settings,color: Colors.black,),
//                           SizedBox(
//                             width: 20,
//                           ),
//                           Text("Setting",style: TextStyle(color: Colors.black,fontSize: 18,),)
//                         ],
//                       ),
//                       onPressed: () => {
//
//                       }
//                   ),
//                   TextButton(
//                       style: OutlinedButton.styleFrom(
//                         backgroundColor: Colors.white,),
//                       child: Row(
//                         children: [
//                           Icon(Icons.language,color: Colors.black),
//                           SizedBox(
//                             width: 20,
//                           ),
//                           Text("Language",style: TextStyle(color: Colors.black,fontSize: 18),)
//                         ],
//                       ),
//                       onPressed: () => {
//
//                       }
//                   ),
//                   TextButton(
//                       style: OutlinedButton.styleFrom(
//                           backgroundColor: Colors.white),
//                       child: Row(
//                         children: [
//                           Icon(Icons.dark_mode_outlined,color: Colors.black),
//                           SizedBox(
//                             width: 20,
//                           ),
//                           Text("Dark Mood",style: TextStyle(color: Colors.black,fontSize: 18),),
//                           Spacer(),
//                           Transform.scale(
//                               scale: 1,
//                               child: Switch(
//                                 onChanged: toggleSwitch,
//                                 value: isSwitched,
//                               )
//                           ),
//                         ],
//                       ),
//                       onPressed: () => {
//                       }
//                   ),
//                   TextButton(
//                       style: OutlinedButton.styleFrom(
//                         backgroundColor: Colors.white,),
//                       child: Row(
//                         children: [
//                           Icon(Icons.exit_to_app,color: Colors.black),
//                           SizedBox(
//                             width: 20,
//                           ),
//                           Text("Sign Out",style: TextStyle(color: Colors.black,fontSize: 18),),
//
//                         ],
//                       ),
//                       onPressed: () => {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => SignIn()),
//                         )
//
//                       }
//                   ),
//
//                 ],
//               ),
//             ],),
//
//         ),
//       ),
//       bottomNavigationBar: const BottomAppBar(
//           shape: CircularNotchedRectangle(),
//           notchMargin: 5,
//           clipBehavior: Clip.antiAlias,
//           child: bottomNavigationBar(),
//       ),
//
//     );
//   }
// }
