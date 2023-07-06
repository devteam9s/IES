import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(automaticallyImplyLeading: false,
        title: Center(child: Text(
          "Evaluate Performance", style: TextStyle(color: Colors.white),)),
        backgroundColor: Colors.green,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          Text("From date:"),
          SizedBox(height: 5,),
          SizedBox(
              height: 40,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.7,
              child: fromDate()),
          //CustomInputField(label: "From date", prefixIcon:Icons.arrow_drop_down_circle_outlined,controller: fromDateController,),
          SizedBox(height: 5,),
          Text("To date:"),
          SizedBox(height: 5,),
          SizedBox(
              height: 40,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.7,
              child: toDate()),
          SizedBox(height: 10,),
          InkWell(onTap: () {
            /*  if(toDateController.text.isNotEmpty&&fromDateController.text.isNotEmpty){
              getReport();
            }else{
              ToastUtils.showToast("Please select date", context);
            }*/
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
                child: Text(
                  "SUBMIT",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
          ),
          Container(height: 0.1,),

        ],
      ),
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
        hintText: "From date",
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
        hintText: "To date",
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

  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  Future _selectDate(BuildContext context, String toORfrom) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: toORfrom == "from" ? selectedFromDate : selectedToDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        if (toORfrom == "from") {
          selectedFromDate = picked;
          fromDateController?.text =
              DateFormat('yyyy-MM-dd').format(selectedFromDate);
          return;
        }
        if (toORfrom == "to") {
          selectedToDate = picked;
          toDateController?.text =
              DateFormat('yyyy-MM-dd').format(selectedToDate);
          return;
        }
      });
  }
}
