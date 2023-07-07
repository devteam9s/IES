import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ies_flutter_application/view/sensor_details.dart';

import '../res/colors.dart';

class SensorList extends StatefulWidget{
  final int? index;
  final isAdmin;
  const SensorList({super.key,this.index,required this.isAdmin});

  @override
  State<StatefulWidget> createState() {
    return SensorListState();
  }
}

class SensorListState extends State<SensorList>{

  List sensor = ["Sensor-1","Sensor-2","Sensor-3","Sensor-4","Sensor-5","Sensor-6","Sensor-7","Sensor-8"];

  String? _systemTag;
  String? _sensorTag;
  late bool _value=false;


  List systemTag = ["tag-1","tag-2","tag-3","tag-4","tag-5","tag-6",];
  List sensorTag = ["tag-1","tag-2","tag-3","tag-4","tag-5","tag-6",];
  List isActive = ["True","False"];

  @override
  Widget build(BuildContext context) {
    final width= MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CustomColors.appThemeColor,
      appBar: AppBar(
        backgroundColor: CustomColors.appBarColor,
        elevation: 5,
        shadowColor: Colors.black54,
        title:Text("System-${widget.index}"),
        centerTitle: true,
        actions: [
          widget.isAdmin?IconButton(
              onPressed: () {
                addSensor(width);
              },
              icon: const Icon(Icons.add)):SizedBox(),
          SizedBox(width: 15,)
        ],
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

  void addSensor(width) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          backgroundColor: CustomColors.cardColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: width*0.1,),
              Text("Add Earth Pits",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 25,
                  )),
              SizedBox(width: width*0.03,),
              IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, icon:const Icon(Icons.close,color: Colors.white,))
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: width*0.85,
            child: Column(
              children: [
                // TextFormField(
                //   decoration: InputDecoration(
                //       enabledBorder: OutlineInputBorder(
                //         borderSide:
                //         const BorderSide(width: 3, color: Colors.white),
                //         borderRadius: BorderRadius.circular(15),
                //       ),
                //       labelText: 'Enter Customer ID',
                //       labelStyle: GoogleFonts.roboto(
                //         color: Colors.white,
                //         fontSize: 17,
                //       ),
                //       hintText: 'Enter Customer ID',
                //       hintStyle: GoogleFonts.roboto(
                //         color: Colors.white,
                //         fontSize: 17,
                //       ),
                //       // Set border for focused state
                //       focusedBorder: OutlineInputBorder(
                //         borderSide:
                //         const BorderSide(width: 3, color: Colors.white),
                //         borderRadius: BorderRadius.circular(15),
                //       )),
                //   style: GoogleFonts.roboto(
                //     color: Colors.white,
                //     fontSize: 17,
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.only(top: width*0.03),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                        color: Colors.white, style: BorderStyle.solid, width: width*0.009),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      underline: const SizedBox(),
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                      dropdownColor: CustomColors.appThemeColor,
                      isExpanded: true,
                      hint:Text("Select System ID",style: GoogleFonts.roboto(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w400)),
                      value: _systemTag,
                      items:systemTag.map((e) {
                        return DropdownMenuItem<String>(
                            value: e,
                            child: Text(e)
                        );
                      }
                      ).toList() ,
                      onChanged: (value){
                        setState(() {
                          _systemTag=value!;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: width*0.03),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                        color: Colors.white, style: BorderStyle.solid, width: width*0.009),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      underline: const SizedBox(),
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                      dropdownColor: CustomColors.appThemeColor,
                      isExpanded: true,
                      hint:Text("Select Sensor ID",style: GoogleFonts.roboto(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w400)),
                      value: _sensorTag,
                      items:sensorTag.map((e) {
                        return DropdownMenuItem<String>(
                            value: e,
                            child: Text(e)
                        );
                      }
                      ).toList() ,
                      onChanged: (value){
                        setState(() {
                          _sensorTag=value!;
                        });
                      },
                    ),
                  ),
                ),
                StatefulBuilder(
                    builder: (context,setState) {
                      return Container(
                          margin: EdgeInsets.only(top: width*0.03),
                          height: width*0.155,
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                                color: Colors.white, style: BorderStyle.solid, width: width*0.009),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: width*0.02,),
                              Text("Is Active?",style: GoogleFonts.roboto(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400)),
                              SizedBox(width: width*0.26,),
                              Text(_value==false?"No":"Yes",style: TextStyle(color:_value==false?Colors.red:Colors.green ),),
                              Switch(
                                inactiveThumbColor: Colors.red,
                                inactiveTrackColor: Colors.white,
                                activeColor: Colors.green,
                                activeTrackColor: Colors.white,
                                value: _value,
                                onChanged: (result){
                                  setState(() {
                                    _value=result;
                                    debugPrint(_value.toString());
                                  });
                                },
                                autofocus: true,
                              ),
                            ],
                          )
                      );
                    }
                ),
                Container(
                    height: width*0.15,
                    margin: EdgeInsets.only(top: width*0.06),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                            color: Colors.white, style: BorderStyle.solid, width: width*0.009),
                        color: Colors.green
                    ),
                    child: Center(child: Text("Save",style:GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 20,
                    ) ,))
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}