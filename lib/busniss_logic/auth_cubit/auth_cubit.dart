import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  UserCredential? User;
  FirebaseAuth auth = FirebaseAuth.instance;

  //GlobalKey<FormState> formKey = GlobalKey<FormState>();


  void SignUp(String email, String password, GlobalKey<FormState> formKey,
      ) async {
    emit(RegisterLoading());
    if (formKey.currentState!.validate()) {
      try {
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          User = value;
          emit(RegisterSuccess());
        });
        // await auth.currentUser!.updateDisplayName(name);
        // await auth.currentUser!.reload();
        // if(user.user!=null){
        //   return user.user;
        // }
      } on FirebaseAuthException catch (e) {
        if (e.code == "email-already-in-use") {
          emit(RegisterFailure(
              msgErorr: "The account is already exists for this email"));
        } else if (e.code == "weak-password") {
          emit(RegisterFailure(msgErorr: "the password is too weak"));
        }
      }
    }
  }

  void SignIn(
      String email, String password, GlobalKey<FormState> formKey) async {
    emit(LoginLoading());
    if (formKey.currentState!.validate()) {
      try {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          User = value;

          emit(LoginSuccess());
          // if (user.user != null) {
          //   return user.user;
          // }
        }).onError((error, stackTrace) {
          emit(LoginFailure(msgErorr: error.toString()));
        });
      } on FirebaseAuthException catch (e) {
        emit(LoginFailure(msgErorr: e.toString()));
      }
    }
  }
}
