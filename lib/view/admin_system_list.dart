import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ies_flutter_application/models/customer_systems.dart';
import 'package:ies_flutter_application/providers/systems_provider.dart';
import 'package:ies_flutter_application/res/colors.dart';
import 'package:ies_flutter_application/view/sensor_details.dart';
import 'package:ies_flutter_application/view/sensor_list.dart';
import 'package:ies_flutter_application/view/system_list.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/admin_systems.dart';
import '../providers/system_provider_admin.dart';
import '../res/components/add_systems.dart';
import '../view_model/add_system_and_sensors.dart';

class AdminSystemList extends StatefulWidget {
  final bool isAdmin;
  final int index;
  final String? customerID;
  const AdminSystemList({Key? key,required this.isAdmin,required this.index,this.customerID}) : super(key: key);

  @override
  State<AdminSystemList> createState() => _AdminSystemListState();
}

class _AdminSystemListState extends State<AdminSystemList> {



  List systems = ["System-1","System-2","System-3","System-4","System-5","System-6","System-7","System-8"];
  List sensor = ["Sensor-1","Sensor-2","Sensor-3","Sensor-4","Sensor-5","Sensor-6","Sensor-7","Sensor-8"];


  List systemTag = ["tag-1","tag-2","tag-3","tag-4","tag-5","tag-6",];
  List sensorTag = ["tag-1","tag-2","tag-3","tag-4","tag-5","tag-6",];

  AddSensorsAndSystems? addSym;
  AdminSystemsProvider? postMdl;
  Map? body;

  String? systemId;

  var customerId;

  @override
  void initState() {
    debugPrint("Inside init state...");
    super.initState();
    addSym = Provider.of<AddSensorsAndSystems>(context,listen: false);
    getCustomerID(context);
  }

  void getCustomerID(context)async{
    //
    var sp = await SharedPreferences.getInstance();
    customerId = sp.getString("CustomerId")!;
    postMdl = Provider.of<AdminSystemsProvider>(context, listen: false);
    body ={"customer_id":customerId};
    postMdl?.getSystemsBasedOnCustomerId(body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.appThemeColor,
      body: Consumer<AdminSystemsProvider>(
        builder: (context,snap,child){
          return snap.isLoading?Center(child: Text("Loading")):
          snap.isNoData?Center(child: Text("No Data Found")):
          snap.isError?Center(child: Text("Something went wrong")):
          ListView.builder(
            shrinkWrap: true,
            itemCount:snap.systems?.data?.system==null? 0:snap.systems?.data?.system?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    ListTile(
                      onTap: (){
                        systemId=snap.systems!.data!.system![index].id;
                        var opID = snap.systems!.data!.system![index].operatorId;
                        SystemList.site = snap.systems!.data!.system![index].systemTag;
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SensorList(index: index+1,isAdmin: widget.isAdmin,systemID: systemId,operatorID: opID,),));
                      },
                      leading: Icon(Icons.settings,color: Colors.greenAccent[200],size: 25),
                      trailing: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.white54,size: 20),
                      title: Text(snap.systems!.data!.system![index].systemTag!,
                        style: GoogleFonts.roboto(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),),
                    ),
                    const Divider(color: Colors.white,indent: 10,endIndent: 10,thickness: 1,),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void addSystems(width) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) {
        return AddSystems(
          operatorId: widget.customerID,
        );
      },
    );
  }

}
