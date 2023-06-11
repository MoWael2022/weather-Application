import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:weather_app/Data/firebase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:weather_app/busniss_logic/auth_cubit/auth_cubit.dart';
import '../../busniss_logic/auth_cubit/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/PageRoute.dart';
import '../Widget/TextFromFiled.dart';
import 'home.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isloading = false;
  bool ?val ;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is LoginLoading) {
          isloading = true;
        } else if (state is LoginSuccess) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isSignedIn', true);
          prefs.setString('name', name.text);
          prefs.setString('email', email.text);
          String? test = await prefs.getString("name");
          isloading = false;
          Fluttertoast.showToast(
              msg: "Successfully Register",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.of(context)
              .pushNamedAndRemoveUntil(PageRoutes.SearchPage, (route) => false);
        } else if (state is LoginFailure) {
          print("here ${state.msgErorr}");
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
                  const SizedBox(
                    height: 10,
                  ),
                  Container(child: Lottie.asset("lotties/124956-login.json"),height: 200,),
                  const Text(
                    "Sign In",
                    style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                  const SizedBox(
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
                    padding:const EdgeInsets.only(
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
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        print("HERE ${name.text}");

                        BlocProvider.of<AuthCubit>(context)
                            .SignIn(email.text!, pass.text!, formKey);
                      },
                      child: Text("SignUp", style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  Container(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, PageRoutes.registerPage);
                      },
                      child: Text("Sign up"),
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
