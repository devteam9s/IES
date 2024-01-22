import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../res/colors.dart';
import '../webservice/change_password.dart';
import 'forgot_password.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {

  ChangePassword changePassword = ChangePassword();

  FocusNode passwordFocusNode = FocusNode();
  bool _obsecureText = true;

  final TextEditingController _otpController = TextEditingController();

  bool loading=false;
  final auth=FirebaseAuth.instance;

  var code="";
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    debugPrint("This is otp verification page"+ForgotPassword.verify);

    return SafeArea(
      child: Scaffold(
          backgroundColor: CustomColors.appThemeColor,

          body: SingleChildScrollView(
            child:   Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50,),
                Text("Verify Phone Number",style: TextStyle(fontSize: 18,color: Colors.white),),
                const SizedBox(height: 40,),
                Container(
                  margin: const EdgeInsets.only(left: 25,right: 25),
                  child: TextFormField(
                    controller: _otpController,
                    style: const TextStyle(color: Colors.white54),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: 'Enter OTP',
                        hintStyle:const TextStyle(color: Colors.white54),
                        labelText: 'Enter OTP',
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
                  ),
                ),
                const SizedBox(height: 25,),
                InkWell(
                  onTap: ()async{
                    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: ForgotPassword.verify, smsCode: _otpController.text.toString());
                    await auth.signInWithCredential(credential).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please wait....") ));
                      changePassword.changePassword(context, ForgotPassword.email, ForgotPassword.password, ForgotPassword.confirmPassword);
                    }).onError((error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong OTP") ));
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 25,right: 25),
                    width: double.infinity,
                    height: width*0.12,
                    decoration: BoxDecoration(
                        color:Color(0xff6610f2),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: loading?Container(
                        padding: EdgeInsets.only(left: 150,right: 150),
                        child: const CircularProgressIndicator(color: Colors.white))
                        :const Center(child: Text("Veryfy",style: TextStyle(
                        color:Colors.white,fontSize: 23),)),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
