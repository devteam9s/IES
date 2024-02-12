import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ies_flutter_application/models/customer_systems.dart';
import 'package:ies_flutter_application/providers/systems_provider.dart';
import 'package:ies_flutter_application/res/colors.dart';
import 'package:ies_flutter_application/view/sensor_details.dart';
import 'package:ies_flutter_application/view/sensor_list.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../res/components/add_systems.dart';
import '../view_model/add_system_and_sensors.dart';
import 'Home.dart';

class SystemList extends StatefulWidget {
  final bool isAdmin;
  final int index;
  final String? operatorID;
  const SystemList({Key? key,required this.isAdmin,required this.index,this.operatorID}) : super(key: key);

  static var site;
  @override
  State<SystemList> createState() => _SystemListState();
}

class _SystemListState extends State<SystemList> {



  List systems = ["System-1","System-2","System-3","System-4","System-5","System-6","System-7","System-8"];
  List sensor = ["Sensor-1","Sensor-2","Sensor-3","Sensor-4","Sensor-5","Sensor-6","Sensor-7","Sensor-8"];


  List systemTag = ["tag-1","tag-2","tag-3","tag-4","tag-5","tag-6",];
  List sensorTag = ["tag-1","tag-2","tag-3","tag-4","tag-5","tag-6",];

  AddSensorsAndSystems? addSym;
  SystemsProvider? postMdl;
  Map? body;

  String? systmId;

  @override
  void initState() {
    debugPrint("Inside init state...");
    debugPrint("Customer id : ${Home.customerId}");

    super.initState();
    postMdl = Provider.of<SystemsProvider>(context, listen: false);
    addSym = Provider.of<AddSensorsAndSystems>(context,listen: false);
    body ={"customer_id_param":Home.customerId};
    debugPrint(body.toString());
    postMdl?.getSystemsBasedOnId(body);

  }



  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CustomColors.appThemeColor,
      appBar: widget.isAdmin&&widget.index==1?AppBar(
        backgroundColor: CustomColors.appBarColor,
        elevation: 5,
        shadowColor: Colors.black54,
        title:Text("Systems"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                addSystems(width);
              },
              icon: const Icon(Icons.add)),
          SizedBox(width: width * 0.02),
        ],
        ):null,
      body: Consumer<SystemsProvider>(
        builder: (context,snap,child){
          return snap.isLoading?Center(child: Text("Loading")):
          snap.isLoading==false&&snap.isNoData?Center(child: Text("No Data Found")):
          snap.isLoading==false&&snap.isError?Center(child: Text("Something went wrong")):
          ListView.builder(
            shrinkWrap: true,
            itemCount: snap.systems?.data?.system?.length,
            itemBuilder: (context, index) {
              System item=snap.systems!.data!.system![index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    ListTile(
                      onTap: (){
                        systmId=snap.systems!.data!.system![index].id;
                        var opID = snap.systems!.data!.system![index].operatorId;
                        SystemList.site = snap.systems!.data!.system![index].systemTag;
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SensorList(index: index+1,isAdmin: widget.isAdmin,systemID: systmId,operatorID: opID,),));
                      },
                      leading: Icon(Icons.settings,color: Colors.greenAccent[200],size: 25),
                      trailing: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.white54,size: 20),
                      title: Text(item.systemTag.toString(),style: GoogleFonts.roboto(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),),
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
          operatorId: widget.operatorID, // It is a operator ID
        );
      },
    );
  }


}
