import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget buildPage({
  required Color color,
  required String urlimage,
  required String title,
  required String description,


}) => SingleChildScrollView(
  padding: const EdgeInsets.all(8.0),
  child:   Container(

    child: Center(
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          Container(
            height: 350,
              child: Lottie.asset(urlimage)
           ),

          Center(
            child: Text(

              title,

              style: TextStyle(

                color: color,

                fontSize: 32,

                fontWeight: FontWeight.bold

              ),

            ),
          ),

          Container(

            padding: const EdgeInsets.symmetric(horizontal: Checkbox.width),

            child: Center(
              child: Text(

                description,

                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20
                ),

              ),
            ),

          ),

        ],

      ),
    ),



  ),
);