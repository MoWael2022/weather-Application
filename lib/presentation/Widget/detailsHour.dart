import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class DetailsHours extends StatelessWidget {
   DetailsHours({Key? key,required this.temperture,required this.Url,required this.time}) : super(key: key);
String temperture ;
String Url;
String time;
  @override
  Widget build(BuildContext context) {
    return  Container(
      height:15.h,
      width : 15.h,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: Text(
              time ,
              style: TextStyle(
                  fontSize: 5.w
              ),
            ),
          ),
          Expanded(child: Image(image: NetworkImage("https:${Url}"))),
          Container(
            alignment: Alignment.topCenter,
            child: Text(
             "${temperture}°c" ,
              style: TextStyle(
                fontSize: 5.w
              ),
            ),
          ),

        ],
      ),
    );
  }
}
