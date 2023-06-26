import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../res/colors.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {

  List customers = ["Customer-1","Customer-2","Customer-3","Customer-4","Customer-5","Customer-6","Customer-7","Customer-8"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.appThemeColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("List of Customers"),backgroundColor: CustomColors.appThemeColor,elevation: 0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              color: Colors.white,
              height: 1,
              thickness: 1,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: customers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                ListTile(
                  onTap: (){
                    
                  },
                  leading: const Icon(Icons.person,color: Colors.white,size: 25),
                  title: Text(customers[index],style: GoogleFonts.roboto(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),),
                ),
                // const Divider(color: Colors.white,indent: 10,endIndent: 10,),
              ],
            ),
          );
        },
      ),
    );
  }
}
