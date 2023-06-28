import 'package:flutter/material.dart';
import 'package:ies_flutter_application/res/colors.dart';
import 'package:ies_flutter_application/res/components/auth_button.dart';
import 'package:ies_flutter_application/view/Home.dart';

import '../utils/utils.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _logInKey = GlobalKey<FormState>();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  final ValueNotifier<bool> _obsecureText = ValueNotifier<bool>(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CustomColors.appThemeColor,
      body: Form(
        key: _logInKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: width*0.35,),
              SizedBox(
                width: width*0.3,
                height: width*0.3,
                child: Image.asset("assets/login.png"),
              ),
              const SizedBox(height: 10,),
              Container(
                margin: const EdgeInsets.only(left: 25,right: 25),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  focusNode: emailFocusNode,
                  style: const TextStyle(color: Colors.white54),
                  decoration:InputDecoration(
                      hintText: 'Email',
                      hintStyle:const TextStyle(color: Colors.white54),
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: Colors.white54),
                      prefixIcon: const Icon(Icons.email_outlined,color: Colors.white54,),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:  BorderRadius.circular(50.0),
                      borderSide: const BorderSide(width: 2, color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:  BorderRadius.circular(50.0),
                      borderSide:const BorderSide(width: 2, color: Colors.white),
                    ),
                      border: OutlineInputBorder(
                        borderRadius:  BorderRadius.circular(50.0),
                        borderSide: const BorderSide(width: 2, color: Colors.white),
                      )
                  ),
                  onFieldSubmitted: (valu){
                    Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                  },
                  validator:(value){
                    if(value!.isEmpty){
                      return "Enter Email";
                    }
                      return null;
                  },
                ),
              ),
              const SizedBox(height: 20,),
              ValueListenableBuilder(
                  valueListenable: _obsecureText,
                  builder:(context, value, child) {
                    return Container(
                      margin: const EdgeInsets.only(left: 25,right: 25),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: _obsecureText.value,
                        style: const TextStyle(color: Colors.white54),
                        focusNode: passwordFocusNode,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle:const TextStyle(color: Colors.white54),
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.white54),
                          prefixIcon: const Icon(Icons.lock_open_rounded,color: Colors.white54,),
                          suffixIcon: InkWell(
                              onTap: (){
                                _obsecureText.value = !_obsecureText.value ;
                              },
                              child: Icon(
                                  _obsecureText.value ?  Icons.visibility_off_outlined :
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
                            return "Enter Password";
                          }
                          return null;
                        },
                      ),
                    );
                  },
              ),
              const SizedBox(height: 5,),
              Container(
                  margin: const EdgeInsets.only(left: 25,right: 25),
                  alignment: Alignment.centerRight,
                  child: TextButton(onPressed:(){}, child:const Text("Forgot password?",style: TextStyle(fontSize: 17),))),
              const SizedBox(height: 15,),
              AuthButton(title: 'LOG IN', onPress: () {
                if(_logInKey.currentState!.validate()){
                  Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:(context) => const Home(),), (route) => false);
                }
              },),
              // const SizedBox(height: 15,),
              // AuthButton(title: 'SIGN UP', onPress: () {},),
            ],
          ),
        ),
      ),
    );
  }
}
