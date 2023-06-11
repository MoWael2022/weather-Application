import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DetailsDays extends StatelessWidget {
  DetailsDays(
      {Key? key,
      required this.condition,
      required this.url,
      required this.date,
      required this.maxtemp,
      required this.mintemp})
      : super(key: key);
  String date;

  String url;

  String condition;

  String maxtemp;
  String mintemp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.w, right: 2.w),
      child: Row(
        children: [
          Text(
            date,
            style: TextStyle(color: Colors.white, fontSize: 4.w),
          ),
          SizedBox(
            width: 3.5.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage("https:${url}"),
              ),
              SizedBox(
                width: 25.w,
                child: Text(
                  condition,
                  style: TextStyle(color: Colors.white, fontSize: 3.w),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 3.5.w,
          ),
          Text("${maxtemp}/${mintemp}°c",
              style: TextStyle(fontSize: 4.w, color: Colors.white)),
        ],
      ),
    );
  }
}
