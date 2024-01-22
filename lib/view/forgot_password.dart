import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../res/colors.dart';
import '../res/components/auth_button.dart';
import 'otp_verification.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  static String verify = "";
  static int? token;
  static String email="";
  static String password="";
  static String confirmPassword="";


  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  FocusNode passwordFocusNode = FocusNode();
   bool _obsecureText = true;

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  

  FocusNode passwordFocusNode1 = FocusNode();
   bool _obsecureText1 = true;

  final TextEditingController _passwordController1 = TextEditingController();
  FocusNode passwordFocusNode2 = FocusNode();
  bool _obsecureText2 = true;

  bool loading=false;
  final auth=FirebaseAuth.instance;
  static String countryCode = "+91";

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
            controller: _phoneNumberController,
            style: const TextStyle(color: Colors.white54),
            focusNode: passwordFocusNode,
            decoration: InputDecoration(
                hintText: 'Enter registered phone number',
                hintStyle:const TextStyle(color: Colors.white54),
                labelText: 'Enter registered phone number',
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
            controller: _emailController,
            style: const TextStyle(color: Colors.white54),
            onChanged: (value){
              ForgotPassword.email = value;
            },
            decoration: InputDecoration(
                hintText: 'Enter Registered email id',
                hintStyle:const TextStyle(color: Colors.white54),
                labelText: 'Enter Registered email id',
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
            onChanged: (value){
              ForgotPassword.password=value;
            },
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
            onChanged: (value){
              ForgotPassword.confirmPassword=value;
            },
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

        AuthButton(
          title: 'Submit',
          loading: loading,
          onPress: ()async {
            var phoneNumber = countryCode+_phoneNumberController.text.toString();
          setState(() {
            loading=true;
          });

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
              phoneNumber
          ) ));


          await auth.verifyPhoneNumber(
            phoneNumber: phoneNumber,
              verificationCompleted: (_){
                debugPrint("verification completed");
                setState(() {
                  loading=false;
                });
              },
              verificationFailed: (e){
                debugPrint("error occured");setState(() {
                  loading=false;
                });
              },
              codeSent: (vId,token){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("OTP : $token") ));
                ForgotPassword.verify=vId;
                ForgotPassword.token=token;
              debugPrint("token "+token.toString());
              debugPrint("verifiation id "+vId);
              setState(() {
                loading=false;
              });
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => OtpVerification(),));
              },
              codeAutoRetrievalTimeout: (e){

              }
          );
        },
        ),
      ],
  ),
)
      ),
    );
  }
}
