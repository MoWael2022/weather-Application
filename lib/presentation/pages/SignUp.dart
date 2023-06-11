import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/Data/firebase.dart';
import 'package:weather_app/busniss_logic/auth_cubit/auth_cubit.dart';
import 'package:weather_app/busniss_logic/auth_cubit/auth_state.dart';
import 'package:weather_app/presentation/Widget/TextFromFiled.dart';
import 'package:weather_app/presentation/pages/home.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/PageRoute.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController email = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return BlocConsumer<AuthCubit,AuthState>(
      listener: (context, state) async {
        if (state is RegisterLoading) {
          isloading = true;
        } else if (state is RegisterSuccess) {
          isloading = false;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isSignedIn', true);
          prefs.setString('name', name.text);
          prefs.setString('email', email.text);
          Fluttertoast.showToast(
              msg: "Successfully Register",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.of(context).pushNamedAndRemoveUntil(
              PageRoutes.SearchPage, (route) => false);
        } else if (state is RegisterFailure){

          Fluttertoast.showToast(
              msg: state.msgErorr,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          isloading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isloading,
        child: Scaffold(
          body: Center(
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Create Account",
                    style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFromFieldProject(
                    details: "Name",
                    icon: Icons.person,
                    controller: name,
                  ),
                  TextFromFieldProject(
                    details: "E-mail",
                    icon: Icons.email,
                    controller: email,
                  ),
                  TextFromFieldProject(
                    details: "Password",
                    icon: Icons.lock,
                    controller: pass,
                  ),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        left: 70, top: 20, right: 70, bottom: 5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.teal,
                          shape: RoundedRectangleBorder(
                              //to set border radius to button
                              borderRadius: BorderRadius.circular(
                                  10) // // Background color
                              ),
                          padding: EdgeInsets.all(15)),
                      onPressed: () {
                        BlocProvider.of<AuthCubit>(context)
                            .SignUp(email.text, pass.text, formKey);
                      },
                      child: Text("SignUp", style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  Container(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, PageRoutes.loginPage);
                      },
                      child: Text("I already have account "),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
