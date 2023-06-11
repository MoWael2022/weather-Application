import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/busniss_logic/profile_cubit/profile_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/constant/StringManager.dart';

import '../../constant/color.dart';

class ProfileCubit extends Cubit<StateProfile> {
  ProfileCubit() : super(initial());


  Gradient gradient =  const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        colors.maindark,
        colors.mainDarkToLight,
      ]);
  String theme ="Dark Mood";
  bool value =true ;
  Color text = colors.textDark;
  Color main = colors.mainDarkToLight;

  getColor(bool val)async{

   if(val==false){
     gradient =  const LinearGradient(
         begin: Alignment.topCenter,
         end: Alignment.bottomCenter,
         colors: [
           colors.mainLight,
           colors.mainLightToDark,
         ]);
     theme ="Light Mood";
     text = colors.textDark;

   }else {
     gradient =  const LinearGradient(
         begin: Alignment.topCenter,
         end: Alignment.bottomCenter,
         colors: [
           colors.maindark,
           colors.mainDarkToLight,
         ]);
     theme ="Dark Mood";
     text = colors.textLight;

   }
  }


  Future<String> returnUrl() async{
    Reference ref = FirebaseStorage.instance.ref();
    final result = await ref.listAll();
    if (result.items.isEmpty == false ){
      Reference firstImageRef = result.items.first;
      String url = await firstImageRef.getDownloadURL();
      emit(ImageState());
      return url ;
    }else{
      emit(ImageState());
      return StringManager.imageAdd;
    }
  }

  setImage()async{
    Reference ref = FirebaseStorage.instance.ref();
    final result = await ref.listAll();
    if(result.items.isEmpty == false ){
      Reference firstImageRef = result.items.first;
      await firstImageRef.delete();
    }
    File ?file;
    var pickedImage = ImagePicker();
    var Image = await pickedImage.getImage(source: ImageSource.gallery);
    if(Image != null){
      file = File(Image!.path);
      var imageName = basename(Image.path);
      ref = FirebaseStorage.instance.ref('$imageName');
      await ref.putFile(file!);
      var url =await ref.getDownloadURL();
      emit(AddImageState());
    };
  }

  deleteImage ()async{
    Reference ref = FirebaseStorage.instance.ref();
    final result = await ref.listAll();
    if(result.items.isEmpty == false ){
      Reference firstImageRef = result.items.first;
      await firstImageRef.delete();

      emit(DeleteImageState());
    }
  }

}
