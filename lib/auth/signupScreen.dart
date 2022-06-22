import 'dart:ffi';

import 'package:cook_app/HomeScreen.dart';
import 'package:cook_app/http/crud.dart';
import 'package:cook_app/http/links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';
import 'loginScreen.dart';

class signUpScreen extends StatelessWidget {


  TextEditingController userController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();
  //late String? Function(String?) valid;
  GlobalKey<FormState> formkey =GlobalKey();
  Crud crud=Crud();



  // signUp(BuildContext context) async
  // {
  //   var response=await crud.postData(signUpLink, {
  //     "username":userController.text,
  //     "email":emailController.text,
  //     "password":passController.text
  //   });
  //
  //   if(response['status']=='success')
  //     {
  //       Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
  //     }
  //
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<Appcubit>(create: (context)=>Appcubit(),
      child: BlocConsumer<Appcubit,appState>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=Appcubit.get(context);
          return SafeArea(
            child: Scaffold(

              body:cubit.isLoading?Center(child: CircularProgressIndicator(),): Form(

                key:formkey ,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        decoration: const BoxDecoration(
                            color: Color(0xFFf0f0f0),
                            image: DecorationImage(
                                image: AssetImage('images/intor.png'),fit: BoxFit.cover
                            )
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(35),
                            topLeft: Radius.circular(35),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 50,),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 3),
                                child: Center(
                                  child: Text('Welcome To Forsa!',style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700
                                  )),

                                ),
                              ),
                              const Text('Create Account',style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.blue
                              )),
                              const SizedBox(height: 30,),
                              myInputField(emailController, 'Enter Email',Icons.email,false,(val){},'Email'),
                              myInputField(userController, 'Enter Username',Icons.person,false,(val){},'Username'),
                              myInputField(passController, 'Enter Password',Icons.lock_open,true,(val){},'Password'),

                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: GestureDetector(
                                  onTap: () async{

                                    if (formkey.currentState!.validate())
                                    {
                                      await cubit.signUp(context, crud,emailController.text,userController.text, passController.text);
                                    }


                                  },
                                  child: Container(
                                    alignment: AlignmentDirectional.center,
                                    width: 160,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text('Register',style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 24
                                    ),),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    const Text('''Already have an account?'''),
                                    const SizedBox(width: 5,),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>loginScreen()));
                                      },
                                      child: Text('Login',style: TextStyle(
                                          color: Colors.blue
                                      ),),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },

      ),);
  }

  Widget myInputField(TextEditingController controller,String hint,IconData icon,secure,String? Function(String?) valid,String text) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
      child: TextFormField(

        validator:(valid){
          if(valid==null || valid.isEmpty)
            return '$text Cannot be Empty';

          if ( valid.length > 20)
            return '$text is too long';

          if ( valid.length < 4)
            return '$text is too short';

        },
        controller:controller,
        obscureText: secure,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: hint,
          suffixIcon: Icon(icon)
        ),

      ),
    );
  }

  validInput(String val,int max,int min,String input)
  {

    if(val.length>max)
      return '$input is too long';

    else if(val.length < min)
      return '$input is too short';

    if(val.isEmpty)
      return '$input cannot be empty';

  }
}
