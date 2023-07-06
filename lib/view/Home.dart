import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ies_flutter_application/view/system_list.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../res/colors.dart';
import 'customers_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAdmin = false;
  int _index = 0;
  String? _systemTag;
  String? _sensorTag;


  List systemTag = ["tag-1","tag-2","tag-3","tag-4","tag-5","tag-6",];
  List sensorTag = ["tag-1","tag-2","tag-3","tag-4","tag-5","tag-6",];
  List isActive = ["True","False"];



  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CustomColors.appThemeColor,
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.only(left: 20),
          child: CircleAvatar(
            backgroundColor: CustomColors.appThemeColor,
            child: isAdmin
                ? (_index == 0
                    ? const Icon(
                        Icons.home,
                        color: Colors.white,
                      )
                    : _index == 1
                        ? const Icon(Icons.people, color: Colors.white)
                        : Icon(Icons.settings, color: Colors.white)
            )
                : (_index == 0
                    ? const Icon(
                        Icons.home,
                        color: Colors.white,
                      )
                    : _index == 1
                        ? const Icon(Icons.settings, color: Colors.white)
                        : Icon(Icons.report, color: Colors.white)),
          ),
        ),
        actions: [
          InkWell(
              onTap: () {},
              child: const Icon(
                Icons.notifications,
              )),
          const SizedBox(
            width: 11,
          ),
          InkWell(
              onTap: () {},
              child: const Icon(
                Icons.help_outline,
              )),
          isAdmin && _index == 1
              ? IconButton(
                  onPressed: () {
                    addCustomer(width);
                  },
                  icon: const Icon(Icons.add))
              : const SizedBox(
                  width: 0,
                  height: 0,
                ),
          isAdmin && _index == 2
              ? IconButton(
              onPressed: () {
                addSystems(width);
              },
              icon: const Icon(Icons.add))
              : const SizedBox(
            width: 0,
            height: 0,
          ),
          SizedBox(width: width * 0.03),
        ],
        backgroundColor: CustomColors.appBarColor,
        elevation: 5,
        shadowColor: Colors.black54,
        title: isAdmin
            ? (_index == 0
                ? const Text("Home")
                : _index == 1
                    ? const Text("Customers")
                    : const Text("Systems"))
            : (_index == 0
                ? const Text("Home")
                : _index == 1
                    ? const Text("Systems")
                    : const Text("Reports")),
      ),
      body: isAdmin
          ? (_index == 0
              ? adminDashBoard(width)
              : _index == 1
                  ? CustomerList(
                      isAdmin: isAdmin,
                      index: _index,
                    )
                  : SystemList(
                      isAdmin: isAdmin,
                      index: _index,
                    ))
          : (_index == 0
              ? userDashBoard(width)
              : _index == 1
                  ? SystemList(
                      isAdmin: isAdmin,
                      index: _index,
                    )
                  : null),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white70,
        selectedItemColor: Colors.white,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          isAdmin
              ? const BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: "Customer",
                )
              : const BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "Systems",
                ),
          isAdmin
              ? const BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "Systems",
                )
              : const BottomNavigationBarItem(
                  icon: Icon(Icons.report), label: "Reports"),
        ],
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        backgroundColor: CustomColors.appBarColor,
        elevation: 10,
      ),
    );
  }

  Widget userDashBoard(width) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: SizedBox(
                  width: double.infinity,
                  // child:Text(
                  //   "Hello User ,\nWelcome to IES Mobile App",
                  //   style: GoogleFonts.roboto(fontSize: 20, color: Colors.blueGrey[200],fontWeight:FontWeight.w300),
                  // ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                height: width * 0.5,
                decoration: const BoxDecoration(
                    color: CustomColors.cardColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      child: Icon(
                        Icons.sensors,
                        size: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        "20",
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          "No. of sensors ",
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                height: width * 0.5,
                decoration: const BoxDecoration(
                    color: CustomColors.cardColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      child: Icon(
                        Icons.device_unknown,
                        size: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        "11",
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          "Active earth pits ",
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                height: width * 0.5,
                decoration: const BoxDecoration(
                    color: CustomColors.cardColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: width * 0.4,
                      child: SfRadialGauge(
                        axes: [
                          RadialAxis(
                            useRangeColorForAxis: true,
                            showTicks: true,
                            minimum: 0,
                            maximum: 180,
                            interval: 20,
                            canScaleToFit: true,
                            ranges: [
                              GaugeRange(
                                startValue: 0,
                                endValue: 60,
                                startWidth: 10,
                                endWidth: 10,
                                color: Colors.green,
                              ),
                              GaugeRange(
                                startValue: 60,
                                endValue: 120,
                                startWidth: 10,
                                endWidth: 10,
                                color: Colors.yellow,
                              ),
                              GaugeRange(
                                startValue: 120,
                                endValue: 180,
                                startWidth: 10,
                                endWidth: 10,
                                color: Colors.red,
                              ),
                            ],
                            pointers: const [
                              NeedlePointer(
                                value: 120,
                                needleEndWidth: 5,
                                animationType: AnimationType.bounceOut,
                                animationDuration: 2000,
                                enableAnimation: true,
                              ),
                            ],
                            annotations: [
                              GaugeAnnotation(
                                widget: Container(
                                    child: const Text('120V',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue))),
                                angle: 90,
                                positionFactor: 0.7,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Average Voltage ",
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                height: width * 0.5,
                decoration: const BoxDecoration(
                    color: CustomColors.cardColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: width * 0.4,
                      child: SfRadialGauge(
                        axes: [
                          RadialAxis(
                            useRangeColorForAxis: true,
                            minimum: 0,
                            maximum: 180,
                            canScaleToFit: true,
                            labelOffset: 20,
                            ranges: [
                              GaugeRange(
                                  startValue: 0,
                                  endValue: 60,
                                  startWidth: 15,
                                  endWidth: 15,
                                  color: Colors.green,
                                  rangeOffset: 10),
                              GaugeRange(
                                  startValue: 60,
                                  endValue: 120,
                                  startWidth: 15,
                                  endWidth: 15,
                                  color: Colors.yellow,
                                  rangeOffset: 10),
                              GaugeRange(
                                  startValue: 120,
                                  endValue: 180,
                                  startWidth: 15,
                                  endWidth: 15,
                                  color: Colors.red,
                                  rangeOffset: 10),
                            ],
                            pointers: const [
                              MarkerPointer(
                                value: 100,
                                animationType: AnimationType.bounceOut,
                                animationDuration: 2000,
                                enableAnimation: true,
                                color: Colors.blue,
                              ),
                            ],
                            annotations: [
                              GaugeAnnotation(
                                widget: Container(
                                    child: const Text('100 ohm',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue))),
                                angle: 90,
                                positionFactor: 0.7,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Average Resistance ",
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget adminDashBoard(width) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  // child:Text(
                  //   "Hello Admin ,\nWelcome to IES Mobile App",
                  //   style: GoogleFonts.roboto(fontSize: 20, color: Colors.blueGrey[200],fontWeight:FontWeight.w300),
                  // ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                height: width * 0.5,
                decoration: const BoxDecoration(
                    color: CustomColors.cardColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      child: Icon(
                        Icons.people,
                        size: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        "22",
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          "Total No. of customers",
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                height: width * 0.5,
                decoration: const BoxDecoration(
                    color: CustomColors.cardColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                        radius: 40,
                        child: Icon(Icons.people, size: 40),
                        backgroundColor: Colors.green),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        "15",
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          "Active Customers ",
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void addCustomer(width) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          backgroundColor: CustomColors.cardColor,
          title: Text("Add Customer",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 25,
              )),
          content: SizedBox(
            width: double.maxFinite,
            height: width * 0.8,
            child: Column(
              children: [
                TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 3, color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Enter Customer ID',
                        labelStyle: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                        hintText: 'Enter Customer ID',
                        hintStyle: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                        // Set border for focused state
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 3, color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        )),
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 17,
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

  void addSystems(width) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          backgroundColor: CustomColors.cardColor,
          title: Text("Add System",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 25,
              )),
          content: SizedBox(
            width: double.maxFinite,
            height: width ,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 3, color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: 'Enter Customer ID',
                      labelStyle: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                      hintText: 'Enter Customer ID',
                      hintStyle: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                      // Set border for focused state
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 3, color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      )),
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 17,
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
                      hint:Text("Is Active?",style: GoogleFonts.roboto(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w400)),
                      value: _sensorTag,
                      items:isActive.map((e) {
                        return DropdownMenuItem<String>(
                            value: e,
                            child: Text(e)
                        );
                      }
                      ).toList() ,
                      onChanged: (value){
                        setState(() {

                        });
                      },
                    ),
                  ),
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
