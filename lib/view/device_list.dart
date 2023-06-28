import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ies_flutter_application/res/colors.dart';
import 'package:ies_flutter_application/view/sensor_details.dart';

class DeviceList extends StatefulWidget {
  // int index;
  const DeviceList({Key? key}) : super(key: key);

  @override
  State<DeviceList> createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {

  List devices = ["Device-1","Device-2","Device-3","Device-4","Device-5","Device-6","Device-7","Device-8"];
  List sensor = ["Sensor-1","Sensor-2","Sensor-3","Sensor-4","Sensor-5","Sensor-6","Sensor-7","Sensor-8"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.appThemeColor,
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text("List of sensors"),backgroundColor: CustomColors.appThemeColor,elevation: 0,
      //   bottom: const PreferredSize(
      //     preferredSize: Size.fromHeight(1),
      //     child: Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 10),
      //       child: Divider(
      //         color: Colors.white,
      //         height: 1,
      //         thickness: 1,
      //       ),
      //     ),
      //   ),
      // ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: devices.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                ListTile(
                  onTap: (){
                    sensorList(index);
                    // Navigator.push(context, MaterialPageRoute(builder:(context) => SensorDetails(),));
                  },
                  leading: Icon(Icons.settings,color: Colors.greenAccent[200],size: 25),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.white54,size: 20),
                  title: Text(devices[index],style: GoogleFonts.roboto(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),),
                ),
                const Divider(color: Colors.white,indent: 10,endIndent: 10,thickness: 1,),
              ],
            ),
          );
        },
      ),
    );
  }

  void sensorList(int index) {
    showDialog(
        context: context,
        barrierColor: Colors.black87,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
            backgroundColor: CustomColors.cardColor,
            title: Text("Device-${index+1}\nConnected sensors",textAlign: TextAlign.center,style: GoogleFonts.roboto(color: Colors.white,fontSize: 25,)),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: sensor.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder:(context) => SensorDetails(),));
                          },
                          leading: Icon(Icons.sensors,color: Colors.greenAccent,size: 25),
                          trailing: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.white54,size: 20),
                          title: Row(
                            children: [
                              Text(sensor[index],style: GoogleFonts.roboto(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),),
                              SizedBox(width: 20,),
                              Icon(Icons.circle,color: (index%2==0)?Colors.green:Colors.red,size: 15,)
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: Colors.white,
                            height: 1,
                            thickness: 1,
                          ),
                        ),
                      ],
                    );
                  },
              ),
            ),
          );
        },
    );
  }
}
