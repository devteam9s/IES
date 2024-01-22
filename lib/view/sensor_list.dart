import 'dart:async';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ies_flutter_application/view/system_list.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/mqtt_data_rest_provider.dart';
import '../providers/mqtt_state.dart';
import '../providers/sensor_provider.dart';
import '../res/colors.dart';
import '../utils/utils.dart';
import '../view_model/add_system_and_sensors.dart';

class SensorList extends StatefulWidget{
  final int? index;
  final isAdmin;
  final systemID;
  final operatorID;
  final String? topic1;

  const SensorList({super.key,this.index,required this.isAdmin,this.systemID,this.topic1,this.operatorID});

  static var pit;

  @override
  State<StatefulWidget> createState() {
    return SensorListState();
  }
}

class SensorListState extends State<SensorList>{

  late bool _value=false;


  List isActive = ["True","False"];

  SensorProvider? getSensors;
  AddSensorsAndSystems? addSensors;
  MqttHandler mqttHandler = MqttHandler();
  MqttDataRestProvider mqttDataRestProvider = MqttDataRestProvider();
  var body;

  String? sensorTag;
  String? customerId;
  int _expandedTileIndex = -1;


  TextEditingController sensorController = TextEditingController();


  @override
  void initState() {
    debugPrint("sym id : ${widget.systemID}");
    body ={"p_system_id":widget.systemID};
    getSensors=Provider.of<SensorProvider>(context,listen: false);
    addSensors = Provider.of<AddSensorsAndSystems>(context,listen: false);
    mqttHandler = Provider.of<MqttHandler>(context,listen: false);
    mqttDataRestProvider = Provider.of<MqttDataRestProvider>(context,listen: false);


    getSensors?.getSensorsBasedOnSystem(body);
    getCustomerID();
    super.initState();


  }

  void getCustomerID()async{
    var sp = await SharedPreferences.getInstance();
    customerId = sp.getString("CustomerId")!;
    debugPrint(customerId);
  }

  @override
  Widget build(BuildContext context) {
    final width= MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CustomColors.appThemeColor,
      appBar: AppBar(
        backgroundColor: CustomColors.appBarColor,
        elevation: 5,
        shadowColor: Colors.black54,
        title:Text(SystemList.site+" - Connected Pits"),
        centerTitle: true,
        actions: [
          widget.isAdmin?IconButton(
              onPressed: () {
                addSensor(width);
              },
              icon: const Icon(Icons.add)):const SizedBox(),
          const SizedBox(width: 15,)
        ],
      ),
      body: Consumer<SensorProvider>(
        builder: (context, snap, child) {
          return snap.isLoading?const Center(child: Text("Loading")):
          snap.isNoData?const Center(child: Text("No Data Found")):
          snap.isError?const Center(child: Text("Something went wrong")):
          ListView.builder(
            key: Key(_expandedTileIndex.toString()),
            shrinkWrap: true,
            itemCount: snap.sensor?.data?.sensor?.length,
            itemBuilder: (context, index) {
              return  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(height: 14,),
                    ExpansionTileCard(
                      trailing: const Icon(Icons.keyboard_arrow_down_sharp,color: Colors.white,size: 25),
                      leading: Icon(Icons.sensors,color: Colors.greenAccent[200],size: 25),
                      key: Key(index.toString()),
                      initiallyExpanded: (index == _expandedTileIndex),
                      animateTrailing: true,
                        baseColor: CustomColors.cardColor,
                        expandedColor: CustomColors.cardColor,
                        title: Text(snap.sensor!.data!.sensor![index].topic!.split("/")[1],style: GoogleFonts.roboto(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400)),
                      children: [
                        pitResistance(),
                        pitVoltage(),
                        pitCurrent()
                      ],
                      onExpansionChanged: (value){
                        var sensor = snap.sensor!.data!.sensor![index];
                        _handleTileTap(index,sensor,value);
                      },
                    ),
                  ],
                ),
              );
            },
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
            height: width*0.6,
            child: Column(
              children: [
                TextFormField(
                  controller: sensorController,
                  onChanged: (value){
                    sensorTag = value;
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 3, color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: 'Enter sensor tag',
                      labelStyle: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                      hintText: 'Sensor tag',
                      hintStyle: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                      // Set border for focused state
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 3, color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      )),
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 17,
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
                              Expanded(
                                child: Switch(
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
                              ),
                            ],
                          )
                      );
                    }
                ),
                SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    addSensors?.addSensors(
                        context,
                      widget.systemID,
                        sensorTag!,
                      _value.toString(),
                        customerId!,
                      widget.operatorID
                    ).then((value) {
                      getSensors?.getSensorsBasedOnSystem(body);
                    });
                  },
                  child: Container(
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  Widget pitResistance(){

    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Text(
            "Resistance :",
            style: GoogleFonts.roboto(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w400),
          ),
          Consumer<MqttDataRestProvider>(builder:
              (BuildContext context, value, Widget? child) {
            return Padding(
              padding: const EdgeInsets.only(left: 20),
              child: value.isLoading
                  ? Utils().isLoading(CustomColors.cardColor,
                  CustomColors.appBarColor)
                  : Text(
                value.pData==null||value.pData!.latestValues==null||
                value.pData!.latestValues==null?"0.00":
                value.pData!.latestValues!.r != null ? value.pData!.latestValues!.r.toString() : "0.00",
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: value.pData==null&&value.pData?.latestValues==null&&
                    value.pData?.latestValues!.r == null
                        ? Colors.white
                        : double.parse(value.pData!.latestValues!.r
                        .toString()) <=
                        2
                        ? Colors.green
                        : double.parse(value.pData!.latestValues!.r
                        .toString()) >
                        2 &&
                        double.parse(value.pData!.latestValues!.r
                            .toString()) <=
                            3
                        ? Colors.yellow
                        : double.parse(value.pData!.latestValues!.r
                        .toString()) >
                        3
                        ? Colors.red
                        : null,
                    fontWeight: FontWeight.w400),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget pitVoltage(){
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Text(
            "Voltage :",
            style: GoogleFonts.roboto(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w400),
          ),
          Consumer<MqttDataRestProvider>(builder:
              (BuildContext context, value, Widget? child) {
            return Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: value.isLoading
                  ? Utils().isLoading(CustomColors.cardColor,
                  CustomColors.appBarColor)
                  : Text(
                value.pData==null||value.pData!.latestValues==null||
                    value.pData!.latestValues==null?"0.00":
                value.pData!.latestValues!.r != null ? value.pData!.latestValues!.v.toString() : "0.00",
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: value.pData==null&&value.pData?.latestValues==null&&
                        value.pData?.latestValues!.r == null
                        ? Colors.white
                        : double.parse(value.pData!.latestValues!.v
                        .toString()) <=
                        2
                        ? Colors.green
                        : double.parse(value.pData!.latestValues!.v
                        .toString()) >
                        2 &&
                        double.parse(value.pData!.latestValues!.v
                            .toString()) <=
                            3
                        ? Colors.yellow
                        : double.parse(value.pData!.latestValues!.v
                        .toString()) >
                        3
                        ? Colors.red
                        : null,
                    fontWeight: FontWeight.w400),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget pitCurrent(){
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Text(
            "Current : ",
            style: GoogleFonts.roboto(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w400),
          ),
          Consumer<MqttDataRestProvider>(builder:
              (BuildContext context, value, Widget? child) {
            return Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: value.isLoading
                  ? Utils().isLoading(CustomColors.cardColor,
                  CustomColors.appBarColor)
                  : Text(
                value.pData==null||value.pData!.latestValues==null||
                value.pData!.latestValues==null?"0.00":
                value.pData!.latestValues!.r != null ? value.pData!.latestValues!.c.toString() : "0.00",
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: value.pData==null&&value.pData?.latestValues==null&&
                        value.pData?.latestValues!.r == null
                        ? Colors.white
                        : double.parse(value.pData!.latestValues!.c
                        .toString()) <=
                        2
                        ? Colors.green
                        : double.parse(value.pData!.latestValues!.c
                        .toString()) >
                        2 &&
                        double.parse(value.pData!.latestValues!.c
                            .toString()) <=
                            3
                        ? Colors.yellow
                        : double.parse(value.pData!.latestValues!.c
                        .toString()) >
                        3
                        ? Colors.red
                        : null,
                    fontWeight: FontWeight.w400),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _handleTileTap(int index,sensor,newState) {

    String topic = sensor.topic;
    var data = {
      "topics":topic
    };

    setState(() {
      debugPrint("topic = $topic");
      _expandedTileIndex = index;
      mqttDataRestProvider.getMqttData(data);
    });

    // if(newState) {
    //   setState(() {
    //     if(oldTopic!=null){
    //       mqttHandler.disConnect(oldTopic);
    //     }
    //     _expandedTileIndex = index;
    //     mqttHandler.connect(sensor.topic!);
    //   });
    // }else {
    //   setState(() {
    //     _expandedTileIndex = -1;
    //   });
    // }
  }


}