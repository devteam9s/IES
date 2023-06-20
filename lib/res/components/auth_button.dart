import 'package:flutter/material.dart';
class AuthButton extends StatelessWidget {
  String title;
  final bool loading;
  VoidCallback onPress;

  AuthButton({Key? key,required this.title,this.loading=false,required this.onPress}) : super(key: key);

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
        child: loading?CircularProgressIndicator(color: Colors.black,)
            :Center(child: Text(title,style: TextStyle(
            color:title=="LOG IN"?Colors.black:Colors.white,fontSize: 23),)),
      ),
    );
  }
}
