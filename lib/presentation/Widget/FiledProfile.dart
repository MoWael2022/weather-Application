import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FieldProfile extends StatelessWidget {
   FieldProfile({Key? key,required this.data,required this.icon,this.fun1,this.widget}) : super(key: key);

  String data ;
  IconData icon ;
  var fun1;
  Widget? widget;
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Padding(
          padding: EdgeInsets.all(2.w),
          child: TextButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white),
              child: SizedBox(
                width:90.w,
                child: Row(
                  children: [
                    Icon(
                      icon,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Text(
                      data,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),

                  ],
                ),
              ),
              onPressed: fun1),
        ),
      ],
    );
  }
}
