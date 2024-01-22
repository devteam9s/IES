import 'dart:async';
import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ies_flutter_application/utils/utils.dart';
import 'package:ies_flutter_application/view/sensor_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/mqtt_data.dart';
import '../providers/mqtt_state.dart';
import '../res/colors.dart';

enum MenuValues {
  resistance,
  voltage,
  current,
}

class SensorDetails extends StatefulWidget {
  final String topic;

  const SensorDetails({Key? key, required this.topic}) : super(key: key);

  @override
  State<SensorDetails> createState() => _SensorDetailsState();

}

class _SensorDetailsState extends State<SensorDetails> {
  MqttHandler mqttHandler = MqttHandler();
  MQTTData mqttData = MQTTData();
  bool current = false;
  bool voltage = false;
  bool resistance = false;

  final List<Color>? gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a)
  ];

  @override
  void initState() {
    mqttHandler = Provider.of<MqttHandler>(context,listen: false);
    // mqttHandler.connect(widget.topic);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: CustomColors.appThemeColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Details of ${SensorList.pit}"),
        backgroundColor: CustomColors.appThemeColor,
        elevation: 0,
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
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          //
          // mqttHandler.client.unsubscribe('${widget.topic}/voltage');
          // mqttHandler.client.unsubscribe('${widget.topic}/current');
          // mqttHandler.client.unsubscribe('${widget.topic}/resistance');
          mqttHandler.voltages.clear();
          mqttHandler.current.clear();
          mqttHandler.resistance.clear();
          mqttHandler.re = null;
          mqttHandler.ct = null;
          mqttHandler.vt = null;

          return false;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                width: double.infinity,
                height: width * 0.32,
                decoration: const BoxDecoration(
                    color: CustomColors.cardColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
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
                              Consumer<MqttHandler>(builder:
                                  (BuildContext context, value, Widget? child) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: value.reLoading
                                      ? Utils().isLoading(CustomColors.cardColor,
                                          CustomColors.appBarColor)
                                      : Text(
                                          value.re != null ? value.re! : "",
                                          style: GoogleFonts.roboto(
                                              fontSize: 20,
                                              color: value.re == null
                                                  ? Colors.white
                                                  : double.parse(value.re
                                                              .toString()) <=
                                                          2
                                                      ? Colors.green
                                                      : double.parse(value.re
                                                                      .toString()) >
                                                                  2 &&
                                                              double.parse(value.re
                                                                      .toString()) <=
                                                                  3
                                                          ? Colors.yellow
                                                          : double.parse(value.re
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
                        ),
                        Positioned(
                          right: 5,
                            child: getGraph()
                        )
                      ],
                    ),
                    Container(
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
                          Consumer<MqttHandler>(builder:
                              (BuildContext context, value, Widget? child) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: value.vtLoading
                                  ? Utils().isLoading(CustomColors.cardColor,
                                      CustomColors.appBarColor)
                                  : Text(
                                      value.vt != null ? value.vt! : "",
                                      style: GoogleFonts.roboto(
                                          fontSize: 20,
                                          color: value.vt == null
                                              ? Colors.white
                                              : double.parse(value.vt
                                                          .toString()) <=
                                                      2
                                                  ? Colors.green
                                                  : double.parse(value.vt
                                                                  .toString()) >
                                                              2 &&
                                                          double.parse(value.vt
                                                                  .toString()) <=
                                                              3
                                                      ? Colors.yellow
                                                      : double.parse(value.vt
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
                    ),
                    Container(
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
                          Consumer<MqttHandler>(builder:
                              (BuildContext context, value, Widget? child) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: value.ctLoading
                                  ? Utils().isLoading(CustomColors.cardColor,
                                      CustomColors.appBarColor)
                                  : Text(
                                      value.ct != null ? value.ct! : "",
                                      style: GoogleFonts.roboto(
                                          fontSize: 20,
                                          color: value.ct == null
                                              ? Colors.white
                                              : double.parse(value.ct
                                                          .toString()) <=
                                                      2
                                                  ? Colors.green
                                                  : double.parse(value.ct
                                                                  .toString()) >
                                                              2 &&
                                                          double.parse(value.ct
                                                                  .toString()) <=
                                                              3
                                                      ? Colors.yellow
                                                      : double.parse(value.ct
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
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              resistance? Padding(
                padding: const EdgeInsets.only(right: 25, left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: const Text(
                        "Resistance : ",
                        style: TextStyle(fontSize: 22, color: Colors.red),
                      ),
                    ),
                    IconButton(onPressed: (){
                      setState(() {
                        resistance = false;
                      });
                    }, icon: Icon(Icons.clear,color:Colors.red ,))
                  ],
                ),
              ):const SizedBox(width: 0,height: 0,),
              resistance?AspectRatio(
                  aspectRatio: 1.5,
                  child: Consumer<MqttHandler>(
                    builder: (BuildContext context, value, Widget? child) {
                      return Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: RotatedBox(
                                quarterTurns: 3,
                                child: Text(
                                  "Resistance",
                                  style: TextStyle(
                                      color: Colors.white60,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          SizedBox(
                            width: width * 0.9,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 10, left: 0, top: 25),
                              child: LineChart(
                                LineChartData(
                                    minY: 0,
                                    maxY: 30,
                                    lineBarsData: [
                                      LineChartBarData(
                                          spots: value.resistanceList.map((item) {
                                            return FlSpot(
                                                double.parse(
                                                    item.timeInterval!),
                                                double.parse(item.data!));
                                          }).toList(),
                                          isCurved: true,
                                          color: Colors.redAccent,
                                          barWidth: 3,
                                          belowBarData: BarAreaData(
                                              show: true,
                                              color: Colors.redAccent
                                                  .withOpacity(0.3))),
                                    ],
                                    gridData: FlGridData(
                                      checkToShowVerticalLine: (value){
                                        return true;
                                      },
                                      show: true,
                                      drawHorizontalLine: true,
                                      verticalInterval: 100,
                                      drawVerticalLine: true,
                                      getDrawingHorizontalLine: (value) {
                                        return const FlLine(
                                            color: Color(0xff37434d),
                                            strokeWidth: 1);
                                      },
                                      getDrawingVerticalLine: (value) {
                                        return const FlLine(
                                            color: Color(0xff37434d),
                                            strokeWidth: 1);
                                      },
                                    ),
                                    borderData: FlBorderData(
                                        border: const Border(
                                            bottom: BorderSide(),
                                            left: BorderSide(width: 2))),
                                    titlesData: FlTitlesData(
                                      bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            interval: 100,
                                            showTitles: true,
                                            getTitlesWidget: (item, meta) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0),
                                                child: Transform.rotate(
                                                    angle: 80.3,
                                                    child: Text(
                                                      formatUnixTimestamp(
                                                          item.toInt()),
                                                      style: const TextStyle(
                                                          color: Colors.white60,
                                                          fontSize: 10),
                                                    )),
                                              );
                                            },
                                          )),
                                      leftTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            reservedSize: 30,
                                            getTitlesWidget: (item,meta){
                                              debugPrint(item.toString());
                                              return Text(item.toString(),style: const TextStyle(
                                                  color: Colors.white60,
                                                  fontSize: 10),);
                                            }
                                          )),
                                      topTitles: const AxisTitles(
                                        sideTitles:
                                        SideTitles(showTitles: false),
                                      ),
                                      rightTitles: const AxisTitles(
                                          sideTitles:
                                          SideTitles(showTitles: false)),
                                    )),
                                curve: Curves.linear,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )):
              const SizedBox(width: 0,height: 0,),
              resistance? const Center(
                child: Text(
                  "Time : ",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white60,
                      fontWeight: FontWeight.bold),
                ),
              ):
              const SizedBox(width: 0,height: 0,),
              voltage? Padding(
                padding: const EdgeInsets.only(right: 25, left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Voltage : ",
                      style: TextStyle(fontSize: 22, color: Colors.cyanAccent),
                    ),
                    IconButton(onPressed: (){
                      setState(() {
                        voltage = false;
                      });
                    }, icon:const Icon(Icons.clear,color: Colors.cyanAccent,) )
                  ],
                ),
              ):const SizedBox(width: 0,height: 0,),
              voltage?AspectRatio(
                  aspectRatio: 1.5,
                  child: Consumer<MqttHandler>(
                    builder: (BuildContext context, value, Widget? child) {
                      return Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: RotatedBox(
                                quarterTurns: 3,
                                child: Text(
                                  "Voltage",
                                  style: TextStyle(
                                      color: Colors.white60,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          SizedBox(
                            width: width * 0.9,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 10, left: 0, top: 25),
                              child: LineChart(
                                LineChartData(
                                    minY: 0,
                                    maxY: 30,
                                    lineBarsData: [
                                      LineChartBarData(
                                          spots: value.voltageList.map((item) {
                                            return FlSpot(
                                                double.parse(
                                                    item.timeInterval!),
                                                double.parse(item.data!));
                                          }).toList(),
                                          isCurved: true,
                                          barWidth: 3,
                                          belowBarData: BarAreaData(
                                              show: true,
                                              color: Colors.blueAccent
                                                  .withOpacity(0.3))),
                                    ],
                                    gridData: FlGridData(
                                      checkToShowVerticalLine: (value){
                                        return true;
                                      },
                                      show: true,
                                      drawHorizontalLine: true,
                                      verticalInterval: 100,
                                      drawVerticalLine: true,
                                      getDrawingHorizontalLine: (value) {
                                        return const FlLine(
                                            color: Color(0xff37434d),
                                            strokeWidth: 1);
                                      },
                                      getDrawingVerticalLine: (value) {
                                        return const FlLine(
                                            color: Color(0xff37434d),
                                            strokeWidth: 1);
                                      },
                                    ),
                                    borderData: FlBorderData(
                                        border: const Border(
                                            bottom: BorderSide(),
                                            left: BorderSide(width: 2))),
                                    titlesData: FlTitlesData(
                                      bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            reservedSize: 35,
                                            interval: 100,
                                            showTitles: true,
                                            getTitlesWidget: (item, meta) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0),
                                                child: Transform.rotate(
                                                    angle: 80.3,
                                                    child: Text(
                                                      formatUnixTimestamp(
                                                          item.toInt()),
                                                      style: const TextStyle(
                                                          color: Colors.white60,
                                                          fontSize: 10),
                                                    )),
                                              );
                                            },
                                          )),
                                      leftTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                              showTitles: true,
                                              reservedSize: 30,
                                              getTitlesWidget: (item,meta){
                                                debugPrint(item.toString());
                                                return Text(item.toString(),style: const TextStyle(
                                                    color: Colors.white60,
                                                    fontSize: 10),);
                                              }
                                          )),
                                      topTitles: const AxisTitles(
                                        sideTitles:
                                        SideTitles(showTitles: false),
                                      ),
                                      rightTitles: const AxisTitles(
                                          sideTitles:
                                          SideTitles(showTitles: false)),
                                    )),
                                curve: Curves.linear,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )):
              const SizedBox(width: 0,height: 0,),
              voltage?const Center(
                child: Text(
                  "Time : ",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white60,
                      fontWeight: FontWeight.bold),
                ),
              ):
              const SizedBox(width: 0,height: 0,),
              current?Padding(
                padding: const EdgeInsets.only(right: 25, left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: const Text(
                        "Current : ",
                        style: TextStyle(fontSize: 22, color: Colors.green),
                      ),
                    ),
                    IconButton(onPressed: (){
                      setState(() {
                        current = false;
                      });
                    }, icon:Icon(Icons.clear,color: Colors.green))
                  ],
                ),
              ):const SizedBox(width: 0,height: 0,),
              current?AspectRatio(
                  aspectRatio: 1.5,
                  child: Consumer<MqttHandler>(
                    builder: (BuildContext context, value, Widget? child) {
                      return Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: RotatedBox(
                                quarterTurns: 3,
                                child: Text(
                                  "Current",
                                  style: TextStyle(
                                      color: Colors.white60,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          SizedBox(
                            width: width * 0.9,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 10, left: 0, top: 25),
                              child: LineChart(
                                LineChartData(
                                    minY: 0,
                                    maxY: value.currentMaxY,
                                    lineBarsData: [
                                      LineChartBarData(
                                          spots: value.currentList.map((item) {
                                            return FlSpot(
                                                double.parse(
                                                    item.timeInterval!),
                                                double.parse(item.data!));
                                          }).toList(),
                                          isCurved: true,
                                          barWidth: 3,
                                          color: Colors.green,
                                          belowBarData: BarAreaData(
                                              show: true,
                                              color: Colors.green
                                                  .withOpacity(0.3))),
                                    ],
                                    gridData: FlGridData(
                                      checkToShowVerticalLine: (value){
                                        return true;
                                      },
                                      show: true,
                                      drawHorizontalLine: true,
                                      verticalInterval: 100,
                                      drawVerticalLine: true,
                                      getDrawingHorizontalLine: (value) {
                                        return const FlLine(
                                            color: Color(0xff37434d),
                                            strokeWidth: 1);
                                      },
                                      getDrawingVerticalLine: (value) {
                                        return const FlLine(
                                            color: Color(0xff37434d),
                                            strokeWidth: 1);
                                      },
                                    ),
                                    borderData: FlBorderData(
                                        border: const Border(
                                            bottom: BorderSide(),
                                            left: BorderSide(width: 2))),
                                    titlesData: FlTitlesData(
                                      bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            reservedSize: 35,
                                            interval: 100,
                                            showTitles: true,
                                            getTitlesWidget: (item, meta) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0),
                                                child: Transform.rotate(
                                                    angle: 80.3,
                                                    child: Text(
                                                      formatUnixTimestamp(
                                                          item.toInt()),
                                                      style: const TextStyle(
                                                          color: Colors.white60,
                                                          fontSize: 10),
                                                    )),
                                              );
                                            },
                                          )),
                                      leftTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                              showTitles: true,
                                              reservedSize: 30,
                                              getTitlesWidget: (item,meta){
                                                debugPrint(item.toString());
                                                return Text(item.toString(),style: const TextStyle(
                                                    color: Colors.white60,
                                                    fontSize: 10),);
                                              }
                                          )),
                                      topTitles: const AxisTitles(
                                        sideTitles:
                                        SideTitles(showTitles: false),
                                      ),
                                      rightTitles: const AxisTitles(
                                          sideTitles:
                                          SideTitles(showTitles: false)),
                                    )),
                                curve: Curves.linear,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )):
              const SizedBox(width: 0,height: 0,),
              current?const Center(
                child: Text(
                  "Time : ",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white60,
                      fontWeight: FontWeight.bold),
                ),
              ):
              const SizedBox(width: 0,height: 0,),
            ],
          ),
        ),
      ),
    );
  }

  String formatUnixTimestamp(int unixTimestamp) {

    if (unixTimestamp == 0) {
      return "";
    }
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);

    // Format the DateTime object to "hh:mm" using the intl package
    String formattedTime = DateFormat('hh:mm:ss').format(dateTime);

    return formattedTime;
  }

  Widget getGraph(){
    return PopupMenuButton<MenuValues>(
      icon: const Icon(Icons.info_outline,color: Colors.white,),
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: MenuValues.resistance,
            child:Text("Resistance"),
          ),
          const PopupMenuItem(
            value: MenuValues.voltage,
            child:Text("Voltage"),
          ),
          const PopupMenuItem(
            value: MenuValues.current,
            child:Text("Current"),
          ),
        ];
      },
      onSelected: (items) {
        switch(items){
          case MenuValues.resistance:
            setState(() {
              resistance = true;
              current = false;
              voltage = false;
            });
           break;
          case MenuValues.voltage:
            setState(() {
              resistance = false;
              current = false;
              voltage = true;
            });
            break;
          case MenuValues.current:
            setState(() {
              resistance = false;
              current = true;
              voltage = false;
            });
            break;
        }
      },
    );
  }

}

