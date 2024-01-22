import 'package:flutter/material.dart';
class AuthButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;

  const AuthButton({Key? key,required this.title,this.loading=false,required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(left: 25,right: 25),
        width: double.infinity,
        height: width*0.12,
        decoration: BoxDecoration(
            color:title=="LOG IN"?Colors.white:Color(0xff6610f2),
          borderRadius: BorderRadius.circular(20)
        ),
        child: loading?Container(
          padding: EdgeInsets.only(left: 150,right: 150),
            child: const CircularProgressIndicator(color: Colors.white))
            :Center(child: Text(title,style: TextStyle(
            color:title=="LOG IN"?Colors.black:Colors.white,fontSize: 23),)),
      ),
    );
  }
}
