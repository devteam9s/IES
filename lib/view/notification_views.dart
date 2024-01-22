import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/notification_list_provider.dart';
import '../res/colors.dart';
import 'Home.dart';
import 'login.dart';

class NotificationView extends StatefulWidget{
  const NotificationView({super.key});

  @override
  State<StatefulWidget> createState() {
    return NotificationViewState();
  }
}

class NotificationViewState extends State<NotificationView>{

  final GlobalKey<ExpansionTileCardState> card =  GlobalKey();
  NotificationListProvider notificationListProvider = NotificationListProvider();
  String? deviceID;

  Future<void> getDeviceID()async{
    var sp =await SharedPreferences.getInstance();
    deviceID = sp.getString('deviceID');
    debugPrint("Device ID $deviceID");
  }

  @override
  void initState() {

    notificationListProvider = Provider.of<NotificationListProvider>(context,listen: false);

    var body ={"operator_id_param":Home.operatorID};

    notificationListProvider.getNotificationList(body);

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CustomColors.appThemeColor,
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.only(left: 20),
          child: const CircleAvatar(
            backgroundColor: CustomColors.appThemeColor,
            child:  Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
        ),
        title:const Text("Notifications"),
        backgroundColor: CustomColors.appBarColor,

      ),
      body: Consumer<NotificationListProvider>(
          builder: (context, snap, child) {
            // if(snap.data!=null&&snap.data!.notifications!=null&&snap.data!.notifications!.isNotEmpty){
            //   notificationListProvider.getNotificationFlag(Home.customerId);
            // }
            return snap.isLoading?const Center(child: Text("Loading",style:const TextStyle(color: Colors.white,fontSize: 17),)):
            snap.isLoading==false&&snap.isNoData?const Center(child: Text("No Data Found",style:const TextStyle(color: Colors.white,fontSize: 17),)):
            snap.isLoading==false&&snap.isError?const Center(child: Text("Something went wrong",style:const TextStyle(color: Colors.white,fontSize: 17),)):
            ListView.builder(
                itemCount: snap.data?.notifications!.length,
                itemBuilder:(BuildContext context,int index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: CustomColors.cardColor,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sensor tag : ${snap.data!.notifications![index].topic!.split("/")[1]}",style:const TextStyle(color: Colors.white,fontSize: 17),),
                            SizedBox(height: width*0.01,),
                            Text("Value : ${snap.data!.notifications![index].payload}",style:const TextStyle(color: Colors.white,fontSize: 17),),
                            SizedBox(height: width*0.01,),
                            Text("${snap.data!.notifications![index].dateTime}",style:const TextStyle(color: Colors.white,fontSize: 17),),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            );
          }
      ),
    );
  }
}