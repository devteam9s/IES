import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ies_flutter_application/view/sensor_details.dart';

import '../res/colors.dart';

class SensorList extends StatefulWidget{
  final int? index;
  const SensorList({super.key,this.index});

  @override
  State<StatefulWidget> createState() {
    return SensorListState();
  }
}

class SensorListState extends State<SensorList>{

  List sensor = ["Sensor-1","Sensor-2","Sensor-3","Sensor-4","Sensor-5","Sensor-6","Sensor-7","Sensor-8"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.appThemeColor,
      appBar: AppBar(
        backgroundColor: CustomColors.appBarColor,
        elevation: 5,
        shadowColor: Colors.black54,
        title:Text("System-${widget.index}"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 0),
        child: Text("Connected Sensors",style: GoogleFonts.roboto(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400)),),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: sensor.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context) => SensorDetails(),));
                  },
                  leading: Icon(Icons.sensors,color: Colors.greenAccent[200],size: 25),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.white54,size: 20),
                  title: Text(sensor[index],style: GoogleFonts.roboto(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),),
                ),
                const Divider(color: Colors.white,indent: 10,endIndent: 10,thickness: 1,),
              ],
            ),
          );
        },
      ),
    );
  }
}