import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ies_flutter_application/view/system_list.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/customert_list_provider.dart';
import '../res/colors.dart';

class CustomerList extends StatefulWidget {

  final bool isAdmin;
  final int index;
  const CustomerList({Key? key,required this.isAdmin,required this.index}) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {

  String? customerId;

  CustomerListProvider? customerListProvider;

  @override
  void initState() {

    getCustomerIDandList();
    super.initState();
  }

  void getCustomerIDandList()async{
    var sp = await SharedPreferences.getInstance();
    customerId = sp.getString("CustomerId")!;

    debugPrint(customerId);

    Map body={
      "customer_id":customerId
    };

    customerListProvider=Provider.of<CustomerListProvider>(context,listen: false);
    customerListProvider?.getCustomerList(body);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.appThemeColor,
      body: Consumer<CustomerListProvider>(
        builder: (context,snap,child) {
          return snap.isLoading?const Center(child: Text("Loading")):
          snap.isLoading==false&&snap.isNodata?Center(child: Text("No Data Found")):
          snap.isLoading==false&&snap.isError?Center(child: Text("Something went wrong")):
          ListView.builder(
            shrinkWrap: true,
            itemCount:snap.data?.data?.length ,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    ListTile(
                      onTap: (){
                        var operatorId=snap.data!.data![index].operatorId!;
                        Navigator.push(
                            context,MaterialPageRoute(builder:(context) => SystemList(
                          isAdmin: widget.isAdmin,index: widget.index,operatorID: operatorId
                        )
                          ,));
                      },
                      leading: const Icon(Icons.person,color: Colors.white,size: 25),
                      trailing: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.white54,size: 20),
                      title: Text(
                        snap.data!.data![index].contactName!,style: GoogleFonts.roboto(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),),
                    ),
                    const Divider(color: Colors.white,indent: 10,endIndent: 10,thickness: 1,),
                  ],
                ),
              );
            },
          );
        }
      ),
    );
  }
}
