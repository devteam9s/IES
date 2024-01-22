import 'package:flutter/material.dart';
import 'package:ies_flutter_application/view/Home.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/reports_provider.dart';
import '../providers/sensor_provider.dart';
import '../providers/systems_provider.dart';

class Reports extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  int touchedIndex = -1;
  bool isGragh = false;
  TextEditingController? fromDateController;
  TextEditingController? toDateController;
  var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  var now = DateTime.now();
  ReportsProvider reportsProvider = ReportsProvider();
  var fDate;
  var tDate;
  var fTime;
  var tTime;
  bool isData = false;
  SystemsProvider? postMdl;
  SensorProvider? getSensors;

  var _systemValue = null;
  String? systemID;
  var data;
  var _sensorValue = null;
  var id;

  @override
  void initState() {
    fDate = "From Date";
    tDate = "To Date";
    fTime = "From Time";
    tTime = "To Time";
    reportsProvider = Provider.of<ReportsProvider>(context, listen: false);
    postMdl = Provider.of<SystemsProvider>(context, listen: false);
    getSensors = Provider.of<SensorProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: !isData ? showColumn() : showReport());
  }

  Widget showColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text("Select System:"),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 40,
          alignment: Alignment.center,
          padding: const EdgeInsetsDirectional.only(start: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              border: Border.all(color:Colors.black.withOpacity(0.12))),
          child: Consumer<SystemsProvider>(builder: (context, snap, child) {
            var body = {"customer_id_param": Home.customerId};
            postMdl?.getSystemsBasedOnId(body);
            return snap.isLoading
                ? Center(child: Text("Loading"))
                : snap.isLoading == false && snap.isNoData
                    ? Center(child: Text("No Data Found"))
                    : snap.isLoading == false && snap.isError
                        ? Center(child: Text("Something went wrong"))
                        : DropdownButton(
                            isExpanded: true,
                            isDense: true,
                            underline: const SizedBox(),
                            value: _systemValue,
                            hint: const Text(
                              "Select Site",
                              style: TextStyle(fontSize: 17),
                            ),
                            items: snap.systems!.data!.system!.map((value) {
                              return DropdownMenuItem(
                                value: value.systemTag,
                                child: Text(value.systemTag!),
                                onTap: () {
                                  systemID = value.id!;
                                },
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                data = {"p_system_id": systemID};
                                _systemValue = value;
                                getSensors?.getSensorsBasedOnSystem(data);
                              });
                            });
          }),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text("Select Pit:"),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 40,
          alignment: Alignment.center,
          padding: const EdgeInsetsDirectional.only(start: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              border: Border.all(color: Colors.black.withOpacity(0.12))),
          child: Consumer<SensorProvider>(builder: (context, snap, child) {
            return snap.isLoading
                ? Text("Select pit")
                : snap.isLoading == false && snap.isNoData
                    ? const Center(child: Text("No Data Found"))
                    : snap.isLoading == false && snap.isError
                        ? Text("Select pit")
                        : DropdownButton(
                            isExpanded: true,
                            isDense: true,
                            underline: const SizedBox(),
                            value: _sensorValue,
                            hint: const Text(
                              "Select earth pit",
                              style: TextStyle(fontSize: 17),
                            ),
                            items: snap.sensor!.data!.sensor!.map((value) {

                              String pitName = value.topic!.split("/")[1];

                              return DropdownMenuItem(
                                value: pitName,
                                child: Text(pitName),
                                onTap: (){
                                  id = value.id;
                                  debugPrint("pit id : "+id);
                                },
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _sensorValue = value;
                              });
                            });
          }),
        ),
        const SizedBox(
          height: 20,
        ),
        const Center(child: Text("From date:")),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.7,
            child: fromDate()),
        const SizedBox(
          height: 5,
        ),
        const Text("To date:"),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.7,
            child: toDate()),
        const SizedBox(
          height: 10,
        ),
        const Text("From Time:"),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.7,
            child: fromTime()),
        const SizedBox(
          height: 10,
        ),
        const Text("To Time:"),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.7,
            child: toTime()),
        const SizedBox(
          height: 7,
        ),
        TextButton(
          onPressed: () {
            callGetMethod(id).then((value) {
              setState(() {
                isData = true;
              });
            });
          },
          child: Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 15, bottom: 15),
              decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(5.0)),
              child: const Text(
                "SUBMIT",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
        ),

      ],
    );
  }



  Widget showReport() {
    return Consumer<ReportsProvider>(
      builder: (context, snap, child) {
        return snap.isLoading
            ? const Center(child: Text("Loading"))
            : snap.isNoData
                ? const Center(child: Text("No Data Found"))
                : snap.isError
                    ? const Center(child: Text("Something went wrong"))
                    : SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columnSpacing: 35,
                          columns: const [
                            DataColumn(label: Text("SL.NO")),
                            DataColumn(label: Text("PIT")),
                            DataColumn(label: Text("Value")),
                            DataColumn(label: Text("Date")),
                            DataColumn(label: Text("Time")),
                          ],
                          rows: snap.data!.records!.map((element) {
                            var index = snap.data!.records!.indexOf(element);
                            return DataRow(cells: <DataCell>[
                              DataCell(Text("${index + 1}")),
                              DataCell(Text(element.topic!.split("/")[1].toString())),
                              DataCell(Text(element.payload.toString())),
                              DataCell(Text(element.dateTime.toString())),
                              DataCell(Text(element.time!.split(":")[0] +
                                  ":" +
                                  element.time!.split(":")[1])),
                            ]);
                          }).toList()),
                    );
      },
    );
  }

  Widget fromDate() {
    return TextField(
      controller: fromDateController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
        ),
        hintText: fDate,
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.5),
          fontWeight: FontWeight.w500,
        ),
        suffixIcon: Icon(
          Icons.arrow_drop_down_circle_outlined,
          color: Colors.black.withOpacity(0.5),
        ),
      ),
      obscureText: false,
      readOnly: true,
      onTap: () {
        _selectDate(context, "from");
      },
    );
  }

  Widget toDate() {
    return TextField(
      controller: toDateController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
        ),
        hintText: tDate,
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.5),
          fontWeight: FontWeight.w500,
        ),
        suffixIcon: Icon(
          Icons.arrow_drop_down_circle_outlined,
          color: Colors.black.withOpacity(0.5),
        ),
      ),
      obscureText: false,
      readOnly: true,
      onTap: () {
        _selectDate(context, "to");
      },
    );
  }

  Widget fromTime(){
    return TextField(
      controller: fromDateController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
        ),
        hintText: fTime,
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.5),
          fontWeight: FontWeight.w500,
        ),
        suffixIcon: Icon(
          Icons.arrow_drop_down_circle_outlined,
          color: Colors.black.withOpacity(0.5),
        ),
      ),
      obscureText: false,
      readOnly: true,
      onTap: () {
        _selectTime(context,'from');
      },
    );
  }

  Widget toTime(){
    return TextField(
      controller: fromDateController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
        ),
        hintText: tTime,
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.5),
          fontWeight: FontWeight.w500,
        ),
        suffixIcon: Icon(
          Icons.arrow_drop_down_circle_outlined,
          color: Colors.black.withOpacity(0.5),
        ),
      ),
      obscureText: false,
      readOnly: true,
      onTap: () {
        _selectTime(context,'to');
      },
    );
  }


  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  Future _selectDate(BuildContext context, String toORfrom) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: toORfrom == "from" ? selectedFromDate : selectedToDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        if (toORfrom == "from") {
          selectedFromDate = picked;
          fDate = DateFormat('yyyy-MM-dd').format(selectedFromDate);
          debugPrint(fDate);
          return;
        }
        if (toORfrom == "to") {
          selectedToDate = picked;
          tDate = DateFormat('yyyy-MM-dd').format(selectedToDate);
          debugPrint(tDate);
          return;
        }
      });
    }
  }

  Future _selectTime(BuildContext context, String toOrFrom)async{
    TimeOfDay selectedFromTime = TimeOfDay.now();
    TimeOfDay selectedToTime = TimeOfDay.now();

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: toOrFrom == 'from'?selectedFromTime:selectedToTime,
      builder: (context,child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    debugPrint("Time : "+pickedTime!.format(context).split(" ")[1]);

    if(pickedTime!=null){
      setState(() {
        if(toOrFrom == 'from'){
          String fromTime = pickedTime.format(context).split(" ")[0];
          fTime = "$fromTime:00";
          debugPrint("Selected From Time $fTime");
        }
        if(toOrFrom == 'to'){
          String toTime = pickedTime.format(context).split(" ")[0];
          tTime = "$toTime:00";
          debugPrint("Selected to Time $tTime");
        }
      });
    }
  }

  Future callGetMethod(String id) async {

    var body = {
      "sensor_id_param": id,
      "from_date_param": fDate,
      "to_date_param": tDate,
      "from_time_param": fTime,
      "to_time_param": tTime
    };

    await reportsProvider.getListOfSenesorData(body);
  }

}
