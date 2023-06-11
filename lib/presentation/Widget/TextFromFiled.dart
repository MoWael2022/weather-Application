import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFromFieldProject extends StatelessWidget {
  TextFromFieldProject({
    Key? key,
    required this.details,
    required this.icon,
    required this.controller,
  }) : super(key: key);
  String details;
  TextEditingController controller;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, top: 5, right: 30, bottom: 5),
      child: TextFormField(
        controller: controller,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          prefixIcon: Icon(icon),
          labelText: details,
        ),
      ),
    );
  }
}
