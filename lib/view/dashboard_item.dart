import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ies_flutter_application/models/PitStatusModel.dart';
import 'package:ies_flutter_application/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/pit_status_providers.dart';
import '../providers/user_dash_board_provider.dart';
import '../res/colors.dart';

class DashboardItem extends StatefulWidget {
  final String customerID;
  final String displayTitle;
  final String filter;

  const DashboardItem(
      {super.key,
      required this.customerID,
      required this.displayTitle,
      required this.filter});

  @override
  State<DashboardItem> createState() => _DashboardItemState();
}

class _DashboardItemState extends State<DashboardItem> {
  PitStatusProvider? pitStatusProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pitStatusProvider = Provider.of<PitStatusProvider>(context, listen: false);
    SharedPreferences.getInstance().then((value) {
      Map data = {
        "customer_id_param": value.getString(Constants.CUSTOMER_ID),
        "status_filter": widget.filter == "All" ? null : widget.filter
      };
      debugPrint("Data : ${data}");
      pitStatusProvider?.getPitStatus(data);
    });
  }

  showPitStatusAlert(width, PitStatusModel pitStatus, String displayTitle) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: CustomColors.cardColor,
              title: Text(
                "${displayTitle}",
                style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                width: width * 0.3,
                height: width,
                child: ListView.builder(
                    itemCount: pitStatus.pitStatus!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.sensors_outlined,
                            color: Colors.greenAccent[200], size: 28),
                        // trailing: const Icon(Icons.arrow_forward_ios_outlined,
                        //     color: Colors.white54, size: 20),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Text(
                            "${pitStatus.pitStatus![index].sensorTag}",
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      );
                    }),
              ),
            );
          });
        }).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Consumer<PitStatusProvider>(builder: (context, snap, child) {
      return InkWell(
        onTap: () {
          if (widget.filter == "All") {
            // send to next page.
            showPitStatusAlert(width, snap.allPitModel!, widget.displayTitle);
          } else {
            if (widget.filter == "Inactive") {
              showPitStatusAlert(
                  width, snap.inactivePitModel!, widget.displayTitle);
            } else if (widget.filter == "Active") {
              // showPitStatusAlert(
              //     width, snap.activePitModel!, widget.displayTitle);
            } else {
              showPitStatusAlert(
                  width, snap.criticalPitModel!, widget.displayTitle);
            }
          }
          /*pitStatusProvider?.getPitStatus(data);
            showPitStatusAlert(width,"Active earth pits");*/
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          width: double.infinity,
          height: width * 0.4,
          decoration: const BoxDecoration(
              color: CustomColors.cardColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: width * 0.03),
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: widget.filter == "Active"
                      ? Colors.green[800]
                      : widget.filter == "Inactive"
                          ? Colors.red[800]
                          : widget.filter == "Critical"
                              ? Colors.yellow[800]
                              : Colors.blueAccent[800],
                  child: const ImageIcon(
                    AssetImage(
                      "assets/earth_pit.png",
                    ),
                    size: 35,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  widget.filter == "All"
                      ? (pitStatusProvider!.allPitModel != null &&
                              pitStatusProvider!.allPitModel!.pitStatus != null
                          ? pitStatusProvider!.allPitModel!.pitStatus!.length
                              .toString()
                          : "0")
                      : widget.filter == "Active"
                          ? (pitStatusProvider!.allPitModel != null &&
                                  pitStatusProvider!
                                          .activePitModel!.pitStatus !=
                                      null&&
                      pitStatusProvider!.allPitModel != null &&
                      pitStatusProvider!
                          .criticalPitModel!.pitStatus !=
                          null
                              ? "${snap.activePitModel!.pitStatus!.length + snap.criticalPitModel!.pitStatus!.length}"
                              : "0"
                  )
                          : widget.filter == "Inactive"
                              ? (pitStatusProvider!.inactivePitModel != null &&
                                      pitStatusProvider!
                                              .inactivePitModel!.pitStatus !=
                                          null
                                  ? pitStatusProvider!
                                      .inactivePitModel!.pitStatus!.length
                                      .toString()
                                  : "0")
                              : (pitStatusProvider!.criticalPitModel != null &&
                                      pitStatusProvider!
                                              .criticalPitModel!.pitStatus !=
                                          null
                                  ? pitStatusProvider!
                                      .criticalPitModel!.pitStatus!.length
                                      .toString()
                                  : "0"),
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
                    "${widget.displayTitle}",
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
      );
    });
  }
}
