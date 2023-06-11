import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/PageRoute.dart';
import '../pages/SearchPage.dart';
import '../pages/profile.dart';

class bottomNavigationBar extends StatelessWidget {
  const bottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kBottomNavigationBarHeight,
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          PageRoutes.SearchPage, (route) => false);
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.home,
                          color: Colors.black,
                        ),
                        Text(
                          "Home",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    )),
              ],
            ),
            Column(
              children: [
                InkWell(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      if (prefs.getString('country') == null) {
                        // ignore: use_build_context_synchronously
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Error"),
                                content: const Text(
                                    """no country found please enter the country first"""),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("return")),
                                ],
                              );
                            });
                      } else {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            PageRoutes.home, (route) => false);
                      }
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.details,
                          color: Colors.teal,
                        ),
                        Text(
                          "Details",
                          style: TextStyle(color: Colors.teal),
                        )
                      ],
                    )),
              ],
            ),
            Column(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          PageRoutes.profilePage, (route) => false);
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.account_circle,
                          color: Colors.black,
                        ),
                        Text("Account")
                      ],
                    )),
              ],
            ),
          ]),
    );
  }
}
