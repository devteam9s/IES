import 'package:flutter/material.dart';

import '../res/colors.dart';
import '../res/components/auth_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  FocusNode passwordFocusNode = FocusNode();
   bool _obsecureText = true;

  final TextEditingController _passwordController = TextEditingController();

  FocusNode passwordFocusNode1 = FocusNode();
   bool _obsecureText1 = true;

  final TextEditingController _passwordController1 = TextEditingController();
  FocusNode passwordFocusNode2 = FocusNode();
  bool _obsecureText2 = true;

  final TextEditingController _passwordController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: CustomColors.appThemeColor,

          body:         SingleChildScrollView(
  child:   Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 50,),
        Text("Reset Password",style: TextStyle(fontSize: 18,color: Colors.white),),
        const SizedBox(height: 40,),
        Container(
          margin: const EdgeInsets.only(left: 25,right: 25),
          child: TextFormField(
            controller: _passwordController,
            obscureText: _obsecureText,
            style: const TextStyle(color: Colors.white54),
            focusNode: passwordFocusNode,
            obscuringCharacter: "*",
            decoration: InputDecoration(
                hintText: 'Enter Current Password',
                hintStyle:const TextStyle(color: Colors.white54),
                labelText: 'Current Password',
                labelStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.lock_open_rounded,color: Colors.white54,),
                suffixIcon: InkWell(
                    onTap: (){
                      _obsecureText = !_obsecureText;
                    },
                    child: Icon(
                      _obsecureText ?  Icons.visibility_off_outlined :
                      Icons.visibility,
                      color: Colors.white54,
                    )),
                enabledBorder: OutlineInputBorder(
                  borderRadius:  BorderRadius.circular(50.0),
                  borderSide: const BorderSide(width: 2, color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:  BorderRadius.circular(50.0),
                  borderSide:const BorderSide(width: 2, color: Colors.white),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius:  BorderRadius.circular(50.0),
                  borderSide:const BorderSide(width: 2, color: Colors.red),
                ),
                border: OutlineInputBorder(
                  borderRadius:  BorderRadius.circular(50.0),
                  borderSide: const BorderSide(width: 2, color: Colors.white),
                )
            ),
            validator: (value){
              if(value!.isEmpty){
                return "Enter Current Password";
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 10,),
        Container(
          margin: const EdgeInsets.only(left: 25,right: 25),
          child: TextFormField(
            controller: _passwordController1,
            obscureText: _obsecureText1,
            style: const TextStyle(color: Colors.white54),
            focusNode: passwordFocusNode1,
            obscuringCharacter: "*",
            decoration: InputDecoration(
                hintText: 'New Password',
                hintStyle:const TextStyle(color: Colors.white54),
                labelText: 'New Password',
                labelStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.lock_open_rounded,color: Colors.white54,),
                suffixIcon: InkWell(
                    onTap: (){
                      _obsecureText = !_obsecureText;
                    },
                    child: Icon(
                      _obsecureText1 ?  Icons.visibility_off_outlined :
                      Icons.visibility,
                      color: Colors.white54,
                    )),
                enabledBorder: OutlineInputBorder(
                  borderRadius:  BorderRadius.circular(50.0),
                  borderSide: const BorderSide(width: 2, color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:  BorderRadius.circular(50.0),
                  borderSide:const BorderSide(width: 2, color: Colors.white),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius:  BorderRadius.circular(50.0),
                  borderSide:const BorderSide(width: 2, color: Colors.red),
                ),
                border: OutlineInputBorder(
                  borderRadius:  BorderRadius.circular(50.0),
                  borderSide: const BorderSide(width: 2, color: Colors.white),
                )
            ),
            validator: (value){
              if(value!.isEmpty){
                return "Enter New Password";
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 10,),
        Container(
          margin: const EdgeInsets.only(left: 25,right: 25),
          child: TextFormField(
            controller: _passwordController2,
            obscureText: _obsecureText2,
            style: const TextStyle(color: Colors.white54),
            focusNode: passwordFocusNode2,
            obscuringCharacter: "*",
            decoration: InputDecoration(
                hintText: 'Confirm new Password',
                hintStyle:const TextStyle(color: Colors.white54),
                labelText: 'Confirm new Password',
                labelStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.lock_open_rounded,color: Colors.white54,),
                suffixIcon: InkWell(
                    onTap: (){
                      _obsecureText2= !_obsecureText2;
                    },
                    child: Icon(
                      _obsecureText2?  Icons.visibility_off_outlined :
                      Icons.visibility,
                      color: Colors.white54,
                    )),
                enabledBorder: OutlineInputBorder(
                  borderRadius:  BorderRadius.circular(50.0),
                  borderSide: const BorderSide(width: 2, color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:  BorderRadius.circular(50.0),
                  borderSide:const BorderSide(width: 2, color: Colors.white),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius:  BorderRadius.circular(50.0),
                  borderSide:const BorderSide(width: 2, color: Colors.red),
                ),
                border: OutlineInputBorder(
                  borderRadius:  BorderRadius.circular(50.0),
                  borderSide: const BorderSide(width: 2, color: Colors.white),
                )
            ),
            validator: (value){
              if(value!.isEmpty){
                return "Enter Confirm New Password";
              }
              return null;
            },
          ),
        ),


        const SizedBox(height: 15,),

        AuthButton(title: 'Submit', onPress: () {

                },),
      ],
  ),
)
      ),
    );
  }
}
