import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ies_flutter_application/utils/constant.dart';
import 'package:ies_flutter_application/view/dashboard_item.dart';
import 'package:ies_flutter_application/view/reports.dart';
import 'package:ies_flutter_application/view/system_list.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/admin_dash_board_provider.dart';
import '../providers/mqtt_state.dart';
import '../providers/notification_list_provider.dart';
import '../providers/pit_status_providers.dart';
import '../providers/sensor_provider.dart';
import '../providers/systems_provider.dart';
import '../providers/user_dash_board_provider.dart';
import '../res/colors.dart';
import '../res/components/add_systems.dart';
import '../view_model/add_system_and_sensors.dart';
import '../view_model/login_logout_state.dart';
import '../webservice/get_notification_flag.dart';
import '../webservice/notification_services.dart';
import '../webservice/raise_complaints.dart';
import 'admin_complaints_list.dart';
import 'admin_system_list.dart';
import 'complaints.dart';
import 'customers_list.dart';
import 'notification_views.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static String operatorID = "";
  static String customerId = "";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool? isAdmin = false;
  int _index = 0;
  String? _systemTag;
  String? _sensorTag;
  String? flag;

  AddSensorsAndSystems? addSym;
  SystemsProvider? postMdl;
  MqttHandler mqttHandler = MqttHandler();
  NotificationServices notificationServices = NotificationServices();
  String? customerID;
  SensorProvider? getSensors;
  NotificationListProvider notificationListProvider =
      NotificationListProvider();
  String? deviceID;
  GetNotificationFlag getNotificationFlag = GetNotificationFlag();
  String? name;
  PitStatusProvider? pitStatusProvider;

  SharedPreferences? sharedPreferences;

  List systemTag = [
    "tag-1",
    "tag-2",
    "tag-3",
    "tag-4",
    "tag-5",
    "tag-6",
  ];
  List sensorTag = [
    "tag-1",
    "tag-2",
    "tag-3",
    "tag-4",
    "tag-5",
    "tag-6",
  ];
  List isActive = ["True", "False"];

  @override
  void initState() {
    debugPrint("Inside init state...");
    super.initState();
    SharedPreferences.getInstance().then((value) {
      sharedPreferences = value;
      getCustomerID(context);

      postMdl = Provider.of<SystemsProvider>(context, listen: false);
      addSym = Provider.of<AddSensorsAndSystems>(context, listen: false);
      getSensors = Provider.of<SensorProvider>(context, listen: false);
      notificationListProvider =
          Provider.of<NotificationListProvider>(context, listen: false);
      pitStatusProvider = Provider.of<PitStatusProvider>(context, listen: false);

      notificationServices.requestNotificationPermission();
      notificationServices.firebaseInit(context);
      notificationServices.setupInteractMessage(context);

      name = sharedPreferences!.getString("name");

      Home.operatorID = sharedPreferences!.getString("OperatorID")!;

      getDeviceID();
      setState(() {

      });
    });

    Timer.periodic(const Duration(minutes: 1), (Timer t) => checkForNewSharedLists(t));

  }

  Future<void> getDeviceID() async {
    var sp = await SharedPreferences.getInstance();
    deviceID = sp.getString('deviceID');
  }

  void getCustomerID(context) async {
    String? role;
    sharedPreferences = await SharedPreferences.getInstance();

    customerID = sharedPreferences!.getString("CustomerId")!;

    role = sharedPreferences!.getString("Role");

    if (role == "customer") {
      isAdmin = true;
      setState(() {});
    } else {
      isAdmin = false;
      setState(() {});
    }
    final getData = Provider.of<UserDashBoardProvider>(context, listen: false);
    final getAdminData = Provider.of<AdminDashBoardProvider>(context, listen: false);

    notificationListProvider.getNotificationFlag(customerID!);

    getData.getUserDashBoardData(customerID);
    getAdminData.getAdminDashBoardData();

    Home.customerId = customerID!;
    debugPrint("Operator id : ${Home.operatorID} Customer Id : ${Home.customerId} ");
  }

  void checkForNewSharedLists(time){
    // do request here
    debugPrint("Time interval.....1 mins");
  }


  @override
  Widget build(BuildContext context) {


    final log = Provider.of<LoginLogoutState>(context, listen: false);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CustomColors.appThemeColor,
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.only(left: 20),
          child: CircleAvatar(
            backgroundColor: CustomColors.appThemeColor,
            child: isAdmin != null
                ? (isAdmin!
                    ? (_index == 0
                        ? const Icon(
                            Icons.home,
                            color: Colors.white,
                          )
                        : _index == 1
                            ? const Icon(Icons.people, color: Colors.white)
                            : _index == 2
                                ? const Icon(Icons.settings,
                                    color: Colors.white)
                                : const Icon(Icons.message,
                                    color: Colors.white))
                    : (_index == 0
                        ? const Icon(
                            Icons.home,
                            color: Colors.white,
                          )
                        : _index == 1
                            ? const Icon(Icons.settings, color: Colors.white)
                            : _index == 2
                                ? Icon(Icons.report, color: Colors.white)
                                : const Icon(Icons.message,
                                    color: Colors.white)))
                : const SizedBox(
                    height: 0,
                    width: 0,
                  ),
          ),
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationView(),
                    ));
              },
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: width * 0.04),
                    child: const Icon(
                      Icons.notifications,
                    ),
                  ),
                  Consumer<NotificationListProvider>(
                      builder: (context, snap, child) {
                    return snap.isFlagLoading
                        ? const SizedBox(
                            width: 0,
                            height: 0,
                          )
                        : snap.isFlagLoading == false && snap.isFlagHasNoData
                            ? const SizedBox(
                                width: 0,
                                height: 0,
                              )
                            : snap.isLoading == false && snap.isFlagError
                                ? const SizedBox(
                                    width: 0,
                                    height: 0,
                                  )
                                : snap.flag == "1"
                                    ? notificationIdentifier()
                                    : const SizedBox(
                                        width: 0,
                                        height: 0,
                                      );
                  })
                ],
              )),
          const SizedBox(
            width: 11,
          ),
          _index == 0
              ? InkWell(
                  onTap: () {
                    log.onBackPressed(context);
                  },
                  child: const Icon(
                    Icons.logout,
                  ))
              : const SizedBox(
                  width: 0,
                  height: 0,
                ),
          _index == 0
              ? const SizedBox(
                  width: 11,
                )
              : const SizedBox(
                  width: 0,
                  height: 0,
                ),
          isAdmin! && _index == 2
              ? IconButton(
                  onPressed: () {
                    addSystems(width);
                  },
                  icon: const Icon(Icons.add))
              : const SizedBox(
                  width: 0,
                  height: 0,
                ),
          !isAdmin! && _index == 3
              ? IconButton(
                  onPressed: () {
                    raiseTicket(this, width);
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
        title: isAdmin!
            ? (_index == 0
                ? const Text("Home")
                : _index == 1
                    ? const Text("Customers")
                    : _index == 2
                        ? const Text("Systems")
                        : const Text("Complaints"))
            : (_index == 0
                ? const Text("Home")
                : _index == 1
                    ? const Text("Systems")
                    : _index == 2
                        ? const Text("Generate Reports")
                        : const Text("Complaints")),
      ),
      body: isAdmin == null
          ? const SizedBox(
              width: 0,
              height: 0,
            )
          : (isAdmin!
              ? (_index == 0
                  ? adminDashBoard(width)
                  : _index == 1
                      ? CustomerList(
                          isAdmin: isAdmin!,
                          index: _index,
                        )
                      : _index == 2
                          ? AdminSystemList(
                              isAdmin: isAdmin!,
                              index: _index,
                              customerID: customerID,
                            )
                          : const AdminComplaintList())
              : (_index == 0
                  ? userDashBoard(width)
                  : _index == 1
                      ? SystemList(
                          isAdmin: isAdmin!,
                          index: _index,
                          operatorID: customerID)
                      : _index == 2
                          ? Reports()
                          : const Complaints())),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white70,
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          isAdmin!
              ? const BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: "Customer",
                )
              : const BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "Site",
                ),
          isAdmin!
              ? const BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "Site",
                )
              : const BottomNavigationBarItem(
                  icon: Icon(Icons.report), label: "Reports"),
          BottomNavigationBarItem(
              icon: const Icon(Icons.message),
              label: isAdmin! ? "Message" : "Complaint"),
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
    String cutomerId = sharedPreferences != null ? sharedPreferences!.getString(Constants.CUSTOMER_ID)! :"" ;
    debugPrint("CUstomer id from shared pref : ${cutomerId}");
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15,),

              Text("Welcome $name",style: GoogleFonts.roboto(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),),
              const SizedBox(height: 10,),

              DashboardItem(
                customerID: cutomerId,
                displayTitle: "No of earth pits",
                filter: "All",
              ),
              DashboardItem(
                customerID: cutomerId,
                displayTitle: "Active pits",
                filter: "Active",
              ),
              DashboardItem(
                customerID: cutomerId,
                displayTitle: "Critical earth pits",
                filter: "Critical",
              ),
              DashboardItem(
                customerID: cutomerId,
                displayTitle: "Inactive earth pits",
                filter: "Inactive",
              ),
              SizedBox(height: 15,),
            ],
          ),
        ));
  }

  Widget adminDashBoard(width) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child:
              Consumer<AdminDashBoardProvider>(builder: (context, snap, child) {
            return snap.isLoading
                ? const Center(child: Center(child: Text("Loading...")))
                : snap.isLoading == false && snap.isNoData
                    ? Center(child: Text("No Data Found"))
                    : snap.isLoading == false && snap.isError
                        ? Center(child: Text("Something went wrong"))
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: double.infinity,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                width: double.infinity,
                                height: width * 0.5,
                                decoration: const BoxDecoration(
                                    color: CustomColors.cardColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
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
                                        snap.data!.data!.totalCustomers
                                            .toString(),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
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
                                        snap.data!.data!.activeCustomers
                                            .toString(),
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
                          );
          }),
        ));
  }

  void addCustomer(width) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
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
                  margin: EdgeInsets.only(top: width * 0.03),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                        color: Colors.white,
                        style: BorderStyle.solid,
                        width: width * 0.009),
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
                      hint: Text("Select System ID",
                          style: GoogleFonts.roboto(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                      value: _systemTag,
                      items: systemTag.map((e) {
                        return DropdownMenuItem<String>(
                            value: e, child: Text(e));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _systemTag = value!;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: width * 0.03),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                        color: Colors.white,
                        style: BorderStyle.solid,
                        width: width * 0.009),
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
                      hint: Text("Select Sensor ID",
                          style: GoogleFonts.roboto(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                      value: _sensorTag,
                      items: sensorTag.map((e) {
                        return DropdownMenuItem<String>(
                            value: e, child: Text(e));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _sensorTag = value!;
                        });
                      },
                    ),
                  ),
                ),
                Container(
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
        return const AddSystems(
            // customerID: widget.customerID,
            );
      },
    );
  }

  raiseTicket(contex, width) {
    var body = {"operator_id": customerID};
    var data;

    var _systemValue = null;
    String? systemID;
    var _sensorValue = null;
    TextEditingController _emailController = TextEditingController();
    TextEditingController _pController = TextEditingController();
    TextEditingController _descController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text(
                "Raise complaint",
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                width: width * 0.3,
                height: width,
                child: ListView(
                  children: [
                    Container(
                      width: 200.0,
                      height: 50.0,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsetsDirectional.only(start: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: Colors.blueGrey)),
                      child: Consumer<SystemsProvider>(
                          builder: (context, snap, child) {
                        postMdl?.getSystemsBasedOnId(body);
                        return snap.isLoading
                            ? Center(child: Text("Loading"))
                            : snap.isLoading == false && snap.isNoData
                                ? Center(child: Text("No Data Found"))
                                : snap.isLoading == false && snap.isError
                                    ? Center(
                                        child: Text("Something went wrong"))
                                    : DropdownButton(
                                        isExpanded: true,
                                        isDense: true,
                                        underline: const SizedBox(),
                                        value: _systemValue,
                                        hint: const Text(
                                          "Select Site",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        items: snap.systems!.data!.system!
                                            .map((value) {
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
                                          });
                                        });
                      }),
                    ),
                    Container(
                      width: 200.0,
                      height: 50.0,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsetsDirectional.only(top: 20),
                      padding: const EdgeInsetsDirectional.only(start: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: Colors.blueGrey)),
                      child: Consumer<SensorProvider>(
                          builder: (context, snap, child) {
                        getSensors?.getSensorsBasedOnSystem(data);
                        return snap.isLoading
                            ? Text("Select site")
                            : snap.isLoading == false && snap.isNoData
                                ? const Center(child: Text("No Data Found"))
                                : snap.isLoading == false && snap.isError
                                    ? Text("Select site")
                                    : DropdownButton(
                                        isExpanded: true,
                                        isDense: true,
                                        underline: const SizedBox(),
                                        value: _sensorValue,
                                        hint: const Text(
                                          "Select earth pit",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        items: snap.sensor!.data!.sensor!
                                            .map((value) {
                                          String pitName =
                                              value.topic!.split("/")[1];
                                          return DropdownMenuItem(
                                            value: pitName,
                                            child: Text(pitName),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            _sensorValue = value;
                                          });
                                        });
                      }),
                    ),
                    Container(
                      width: 200.0,
                      height: 50.0,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsetsDirectional.only(top: 20),
                      padding: const EdgeInsetsDirectional.only(start: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: Colors.blueGrey)),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter email id ',
                        ),
                      ),
                    ),
                    Container(
                      width: 200.0,
                      height: 50.0,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsetsDirectional.only(top: 20),
                      padding: const EdgeInsetsDirectional.only(start: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: Colors.blueGrey)),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          maxLength: 25,
                          controller: _pController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Problem?',
                            counterText: "",
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 100.0,
                      alignment: Alignment.topLeft,
                      margin: EdgeInsetsDirectional.only(top: 20),
                      padding: const EdgeInsetsDirectional.only(start: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: Colors.blueGrey)),
                      child: TextFormField(
                        maxLines: 10,
                        minLines: 1,
                        controller: _descController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Brief Description...',
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime.now())
                            .then((pickedDate) {
                          if (pickedDate == null) {
                            return;
                          }
                          setState(() {
                            _selectedDate =
                                "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                          });
                        });
                      },
                      child: Container(
                          width: 200.0,
                          height: 50.0,
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsetsDirectional.only(top: 20),
                          padding: const EdgeInsetsDirectional.only(start: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              border: Border.all(color: Colors.blueGrey)),
                          child: Text(_selectedDate)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        RaiseComplaints()
                            .raiseComplaints(
                                context,
                                _systemValue,
                                _sensorValue,
                                _pController.text,
                                _descController.text,
                                _emailController.text,
                                _selectedDate,
                                customerID)
                            .then((value) {
                          Navigator.pop(context);
                        });
                      },
                      child: Container(
                          width: double.infinity,
                          height: width * 0.12,
                          decoration: BoxDecoration(
                              color: const Color(0xff6610f2),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(child: Text("Raise complaint"))),
                    )
                  ],
                ),
              ),
            );
          });
        }).then((value) {
      _selectedDate = "Select date";
    });
  }

  var _selectedDate = "Select date";

  Widget notificationIdentifier() {
    return Positioned(
      right: 1,
      top: 15,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.red[500],
          borderRadius: BorderRadius.circular(6),
        ),
        constraints: const BoxConstraints(
          minWidth: 12,
          minHeight: 12,
        ),
      ),
    );
  }
}
