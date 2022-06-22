import 'package:cook_app/component/cardView.dart';
import 'package:cook_app/cubit/cubit.dart';
import 'package:cook_app/cubit/states.dart';
import 'package:cook_app/http/crud.dart';
import 'package:cook_app/http/links.dart';
import 'package:cook_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/loginScreen.dart';

class HomeScreen extends StatelessWidget {

  Crud crud=Crud();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<Appcubit>(create: (context)=>Appcubit(),
    child: BlocConsumer<Appcubit,appState>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=Appcubit.get(context);
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.cases),label: 'Jobs'),
                BottomNavigationBarItem(icon: Icon(Icons.cases),label: 'Jobs'),
                BottomNavigationBarItem(icon: Icon(Icons.cases),label: 'Jobs'),
              ],
            ),
            appBar: AppBar(
              title: Text('Home Page'),
              centerTitle: true,
              actions: [
                IconButton(onPressed: () async{
                  await cubit.signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginScreen()));

                }, icon: const Icon(Icons.exit_to_app)),
              ],
            ),
            body: Container(
              padding: EdgeInsets.all(6),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [

                 FutureBuilder(
                     future: cubit.getAlljobs(crud),
                     builder: (BuildContext context,AsyncSnapshot snapshot)
                 {
                   if(snapshot.hasData)
                   return  ListView.builder(
                     shrinkWrap: true,
                     itemBuilder: (BuildContext context,int index)
                     {
                       return CardView(title: snapshot.data['data'][index]['title'],
                           content: snapshot.data['data'][index]['content'], ontap: (){});
                     },
                     itemCount: snapshot.data['data'].length,
                     physics: const BouncingScrollPhysics(),
                     scrollDirection: Axis.vertical,

                   );

                   if(snapshot.connectionState==ConnectionState.waiting)
                     return Center(child: CircularProgressIndicator());

                   return Center(child: CircularProgressIndicator());
                 })
                ],
              ),
            )
          );
    },

    ),);
  }
}
