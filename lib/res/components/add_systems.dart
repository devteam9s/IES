import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ies_flutter_application/providers/system_provider_admin.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/customert_list_provider.dart';
import '../../providers/systems_provider.dart';
import '../../view_model/add_system_and_sensors.dart';
import '../colors.dart';

class AddSystems extends StatefulWidget {
  final String? operatorId;
  final VoidCallback? onPress;

  const AddSystems({super.key, this.operatorId, this.onPress});

  @override
  State<AddSystems> createState() => _AddSystemsState();
}

class _AddSystemsState extends State<AddSystems> {

  String? operatorID;

  bool _value = false;

  AddSensorsAndSystems? addSym;
  SystemsProvider? postMdl;
  AdminSystemsProvider? adminSystemsProvider;

  var body;

  TextEditingController? systemtagController;
  String? systemTag;

  var customerId;

  @override
  void initState() {
    super.initState();
    postMdl = Provider.of<SystemsProvider>(context, listen: false);
    addSym = Provider.of<AddSensorsAndSystems>(context, listen: false);
    getCustomerID();
  }

  void getCustomerID()async{
    var sp = await SharedPreferences.getInstance();
    customerId = sp.getString("CustomerId")!;
    adminSystemsProvider = Provider.of<AdminSystemsProvider>(context, listen: false);

    widget.operatorId==null?
    body ={"customer_id":customerId}:body ={"operator_id":widget.operatorId};

    widget.operatorId==null?adminSystemsProvider?.getSystemsBasedOnCustomerId(body): postMdl?.getSystemsBasedOnId(body);
    debugPrint(customerId);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      backgroundColor: CustomColors.cardColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width * 0.1,
          ),
          Text("Add System",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 25,
              )),
          SizedBox(
            width: width * 0.02,
          ),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ))
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: width * 0.8,
        child: Column(
          children: [
            widget.operatorId == null
                ? Container(
                    margin: EdgeInsets.only(top: width * 0.03),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                          color: Colors.white,
                          style: BorderStyle.solid,
                          width: width * 0.009),
                    ),
                    child: Consumer<CustomerListProvider>(
                        builder: (context, snap, child) {
                      return DropdownButton(
                        underline: const SizedBox(),
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                        dropdownColor: CustomColors.appThemeColor,
                        isExpanded: true,
                        hint: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Select Customer",
                              style: GoogleFonts.roboto(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400)),
                        ),
                        value: operatorID,
                        items: snap.data?.data!.map((e) {
                          return DropdownMenuItem<String>(
                              value: e.operatorId, child: Text(e.contactName!));
                        }).toList(),
                        onChanged: (value) {
                          debugPrint(value);
                          setState(() {
                            operatorID = value;
                          });
                        },
                      );
                    }),
                  )
                : const SizedBox(
                    width: 0,
                    height: 0,
                  ),
            SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: systemtagController,
              onChanged: (value) {
                systemTag = value;
              },
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 3, color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Enter system tag',
                  labelStyle: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  hintText: 'system tag',
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
            StatefulBuilder(builder: (context, setState) {
              return Container(
                  margin: EdgeInsets.only(top: width * 0.03),
                  height: width * 0.155,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                        color: Colors.white,
                        style: BorderStyle.solid,
                        width: width * 0.009),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Text("Is Active?",
                          style: GoogleFonts.roboto(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                      SizedBox(
                        width: width * 0.26,
                      ),
                      Text(
                        _value == false ? "No" : "Yes",
                        style: TextStyle(
                            color: _value == false ? Colors.red : Colors.green),
                      ),
                      Expanded(
                        child: Switch(
                          inactiveThumbColor: Colors.red,
                          inactiveTrackColor: Colors.white,
                          activeColor: Colors.green,
                          activeTrackColor: Colors.white,
                          value: _value,
                          onChanged: (result) {
                            setState(() {
                              _value = result;
                              debugPrint(_value.toString());
                            });
                          },
                          autofocus: true,
                        ),
                      )
                    ],
                  ));
            }),
            InkWell(
              onTap: () {
                addSym
                    ?.addSystems(
                        context,
                        customerId,
                        widget.operatorId != null ? widget.operatorId! : operatorID!,
                        _value.toString(),
                         systemTag!,
                )
                    .then((value) {
                  widget.operatorId == null?
                  adminSystemsProvider?.getSystemsBasedOnCustomerId(body):
                  postMdl?.getSystemsBasedOnId(body);

                });
              },
              child: Container(
                  height: width * 0.15,
                  margin: EdgeInsets.only(top: width * 0.06),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                          color: Colors.white,
                          style: BorderStyle.solid,
                          width: width * 0.009),
                      color: Colors.green),
                  child: Center(
                      child: Text(
                    "Save",
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ))),
            ),
          ],
        ),
      ),
    );
  }
}
