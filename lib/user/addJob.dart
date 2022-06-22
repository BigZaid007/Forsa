import 'package:cook_app/cubit/cubit.dart';
import 'package:cook_app/cubit/states.dart';
import 'package:cook_app/http/crud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddJob extends StatelessWidget {



  TextEditingController txtTitle=TextEditingController();
  TextEditingController txtContent=TextEditingController();
  Crud crud =Crud();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<Appcubit>(
      create: (BuildContext context) => Appcubit(),
      child: BlocConsumer<Appcubit,appState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit=Appcubit.get(context);
          return Scaffold(
            appBar: AppBar(

              title: Text('Add job'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Make a Job Offer',style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.black
                  ),),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                    child: TextFormField(
                      controller: txtTitle,
                      decoration: InputDecoration(
                        label: Text('Job Title'),
                        hintText: 'ex:Flutter Developer',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      //textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.multiline,
                      maxLines: 12,
                      controller: txtContent,
                      decoration: InputDecoration(

                        contentPadding: EdgeInsets.only(bottom: 100,left: 6,top: -50),
                          label: Text('Job Requirements'),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )
                      ),
                    ),
                  ),

                  SizedBox(height: 100,),
                  GestureDetector(
                    onTap: () async {
                      await cubit.addJob(crud, context, txtTitle.text, txtContent.text);
                    },
                    child: Container(
                      width: 180,
                      height: 50,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Add Job',style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 30
                      ),),
                    ),
                  )

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
