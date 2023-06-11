import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ImageSetting extends StatelessWidget {
  ImageSetting({Key? key,required this.fun1 ,required this.fun2}) : super(key: key);

  var fun1;
  var fun2;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        Column(
          children: [
            SizedBox(
                width: 70.w,
                child: ElevatedButton(
                    onPressed: fun1, child: const Text("Add Image"))),
            SizedBox(
              width: 70.w,
                child: ElevatedButton(
                    onPressed: fun2, child: const Text("delete Image"))),
          ],
        )
      ],
    );
  }
}
