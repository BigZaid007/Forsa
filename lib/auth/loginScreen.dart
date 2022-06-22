import 'package:cook_app/auth/signupScreen.dart';
import 'package:cook_app/http/crud.dart';
import 'package:cook_app/http/links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';


class loginScreen extends StatelessWidget {

  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();
  GlobalKey<FormState> formkey =GlobalKey();
  Crud crud=Crud();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<Appcubit>(create: (context)=>Appcubit(),
      child: BlocConsumer<Appcubit,appState>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=Appcubit.get(context);
          return SafeArea(
            child: Scaffold(
              backgroundColor: Color(0xFFf0f0f0),
              body:Form(
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
                              const Text('Sign In to continue',style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                color: Colors.blue
                              )),
                              const SizedBox(height: 30,),
                              myInputField(emailController, 'Enter Email',Icons.person,false,(val){},'Email'),
                              myInputField(passController, 'Enter Password',Icons.lock_open,true,(val){},'Password'),

                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: GestureDetector(
                                  onTap: () async{

                                    print('fucking tapping');
                                    if (formkey.currentState!.validate())
                                    {
                                      await cubit.login(context, crud,emailController.text, passController.text);
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
                                    child: const Text('Login',style: TextStyle(
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
                                    const Text('''Don`t have an account?'''),
                                    const SizedBox(width: 5,),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>signUpScreen()));
                                      },
                                      child: Text('Sign Up',style: TextStyle(
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

        validator: (val){
          if(val==null || val.isEmpty)
            return '$text Cannot be Empty';

          if ( val.length > 20)
            return '$text is too long';

          if ( val.length < 4)
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
}
