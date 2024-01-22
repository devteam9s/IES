import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/complaints_list_provider.dart';
import '../res/colors.dart';
import 'Home.dart';

class Complaints extends StatefulWidget{
  const Complaints({super.key});

  @override
  State<StatefulWidget> createState() {
    return ComplaintsState();
  }
}

class ComplaintsState extends State<Complaints>{

  final GlobalKey<ExpansionTileCardState> card =  GlobalKey();
  ComplaintList complaintList = ComplaintList();

  @override
  void initState() {
    complaintList = Provider.of<ComplaintList>(context,listen: false);
    var body ={"p_operator_id":Home.customerId};
    complaintList.getComplaintList(body);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CustomColors.appThemeColor,
      body: Consumer<ComplaintList>(
        builder: (context, snap, child) {
          return snap.isLoading?const Center(child: Text("Loading")):
          snap.isLoading==false&&snap.isNoData?const Center(child: Text("No Data Found")):
          snap.isLoading==false&&snap.isError?const Center(child: Text("Something went wrong")):
          ListView.builder(
            itemCount: snap.data?.data!.length,
              itemBuilder:(BuildContext context,int index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTileCard(
                    baseColor: CustomColors.cardColor,
                    expandedColor: CustomColors.cardColor,
                      title: Row(
                        children: [
                          Text("ID : ${snap.data!.data![index].id!}",style:const TextStyle(color: Colors.white,fontSize: 18),),
                          SizedBox(width:width*0.3 ,),
                          Text("Status : ${snap.data!.data![index].status!}",style:const TextStyle(color: Colors.white,fontSize: 17),)
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text("Issue : "+snap.data!.data![index].issue!,style:const TextStyle(color: Colors.white,fontSize: 20),),
                      ),
                    children: [
                      const Divider(
                        thickness: 1.0,
                        height: 1.0,
                        indent: 10,
                        endIndent: 15,
                        color: Colors.blueGrey,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20,bottom: 10,top: 10),
                            child: Text(snap.data!.data![index].description!,style:const TextStyle(color: Colors.white,fontSize: 20),),
                          )),
                    ],
                  ),
                );
              }
          );
        }
      ),
    );
  }
}