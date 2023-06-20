import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ies_flutter_application/res/colors.dart';
import 'package:ies_flutter_application/view/sensor_details.dart';

class SensorList extends StatefulWidget {
  // int index;
  const SensorList({Key? key}) : super(key: key);

  @override
  State<SensorList> createState() => _SensorListState();
}

class _SensorListState extends State<SensorList> {

  List sensors = ["Sensor-1","Sensor-2","Sensor-3","Sensor-4","Sensor-5","Sensor-6","Sensor-7","Sensor-8"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.appThemeColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("List of sensors"),backgroundColor: CustomColors.appThemeColor,elevation: 0,
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
        itemCount: sensors.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context) => SensorDetails(),));
                  },
                  leading: const Icon(Icons.sensors,color: Colors.greenAccent,size: 25),
                  title: Text(sensors[index],style: GoogleFonts.roboto(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),),
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
