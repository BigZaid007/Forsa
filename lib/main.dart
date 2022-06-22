import 'package:cook_app/auth/loginScreen.dart';
import 'package:cook_app/user/addJob.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeScreen.dart';

late SharedPreferences sharedPreferences;

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences=await SharedPreferences.getInstance();
  runApp(myApp());
}

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:AddJob()
    );
  }
}
 //sharedPreferences.getString('id')==null?loginScreen():HomeScreen()