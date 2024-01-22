import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/complaint_list_provider_admin.dart';
import '../providers/complaints_list_provider.dart';
import '../res/colors.dart';
import '../webservice/admin_tickets_status_update.dart';
import 'Home.dart';

class AdminComplaintList extends StatefulWidget{
  const AdminComplaintList({super.key});

  @override
  State<StatefulWidget> createState() {
    return AdminComplaintListState();
  }
}

class AdminComplaintListState extends State<AdminComplaintList>{

  final GlobalKey<ExpansionTileCardState> card =  GlobalKey();
  ComplaintListAdmin complaintList =  ComplaintListAdmin();
  UpdateTicketStatus updateTicketStatus = UpdateTicketStatus();
  TextEditingController remarksController = TextEditingController();
  var body;
  int? id;

  @override
  void initState() {
    complaintList = Provider.of<ComplaintListAdmin>(context,listen: false);
    body ={"p_customer_id":Home.customerId};
    complaintList.getAdminComplaintList(body);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CustomColors.appThemeColor,
      body: Consumer<ComplaintListAdmin>(
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
                        snap.data!.data![index].status=="pending"?
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20,bottom: 10,top: 10),
                              child:Text("Remarks : ",style:TextStyle(color: Colors.white,fontSize: 18),),
                            )):const SizedBox(width: 0,height: 0,),
                        snap.data!.data![index].status=="pending"?Padding(
                          padding: const EdgeInsets.only(left: 18,right: 18,bottom: 10),
                          child: TextFormField(
                            controller: remarksController,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(width: 3, color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // labelText: 'Remarks.....',
                                labelStyle: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                                // hintText: 'Remarks.....',
                                hintStyle: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                                // Set border for focused state
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(width: 3, color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            maxLines: 4,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ):const SizedBox(width: 0,height: 0,),
                        snap.data!.data![index].status=="pending"?
                        Container(
                          margin: EdgeInsets.only(bottom: 10,top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.greenAccent,
                            border: Border.all(
                                color: Colors.greenAccent,
                            ),
                          ),
                          child: TextButton(
                              onPressed: (){

                                updateTicketStatus.updateTicketStatus(context, Home.customerId, id.toString(),remarksController.text.toString()).then((value) {
                                  complaintList.getAdminComplaintList(body);
                                });
                              },
                              child:const Text("Mark as completed",style: TextStyle(color: Colors.blueGrey),)),
                        ):const SizedBox(width: 0,height: 0,),
                      ],
                      onExpansionChanged: (value){
                        id ??= snap.data!.data![index].id;
                      },
                    ),
                  );
                }
            );
          }
      ),
    );
  }
}