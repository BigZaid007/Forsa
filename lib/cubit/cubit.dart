import 'package:bloc/bloc.dart';
import 'package:cook_app/cubit/states.dart';
import 'package:cook_app/main.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../HomeScreen.dart';
import '../http/crud.dart';
import '../http/links.dart';

class Appcubit extends Cubit<appState>
{
  Appcubit() : super(initalState());



  static Appcubit get(context) => BlocProvider.of(context);

  bool isLoading=false;




  signUp(BuildContext context,Crud crud,String user,String email,String password) async
  {
    isLoading=true;
    emit(LoadingSignUpState());
    var response=await crud.postData(signUpLink, {
      "username":user,
      "email":email,
      "password":password
    });

    isLoading=false;

    if(response['status']=='success')
    {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      isLoading=true;
      emit(SignUpSuccesfullyState());
    }

  }


  login(BuildContext context,Crud crud,String email,String password) async
  {
    isLoading=true;
    emit(LoadingLoginState());
    var response=await crud.postData(LoginLink, {
      "email":email,
      "password":password
    });

    isLoading=false;

    if(response['status']=='success')
    {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      sharedPreferences.setString('id', response['data']['id'].toString());
      emit((sharedState()));
      isLoading=true;
      emit(LoginSuccesfullyState());
    }

  }

  signOut() async
  {

    sharedPreferences.clear();
    emit(SignoutState());
  }

  getAlljobs(Crud crud) async
  {
    var response=await crud.getData(ViewAlljobs);
    emit(GetAllJobsState());
    return response;
  }

  addJob(Crud crud,BuildContext context,String title,String content) async
  {
    var response=await crud.postData(Addjob, {
      "title":title,
      "content":content,
      "user_id":'20'});
    if(response['status']=='success')
    {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      // sharedPreferences.setString('id', response['data']['id'].toString());
      // emit((sharedState()));
      // isLoading=true;
      emit(AddJobSuccess());
    }
    else
      print('Error');
  }




}