import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ies_flutter_application/data/network/base_apiServices.dart';
import 'package:ies_flutter_application/data/network/network_apiService.dart';
import 'package:ies_flutter_application/models/customer_systems.dart';
import 'package:ies_flutter_application/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/PitStatusModel.dart';
import '../models/admin_dash_board_model.dart';
import '../models/admin_systems.dart';
import '../models/complaints_list_model.dart';
import '../models/complaints_list_model_admin.dart';
import '../models/customer_list_model.dart';
import '../models/mqtt_rest_api_data.dart';
import '../models/notification_list_model.dart';
import '../models/sensor_model.dart';
import '../models/sensor_report_model.dart';
import '../models/user_dashboard_model.dart';
import '../providers/customert_list_provider.dart';

class RestApi{

  BaseApiServices _apiServices = NetworkApiServices();

  Future<SensorModel> getDashBoardData(var systemId)async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          ApiEndPoints.customerSensors, systemId);
      return SensorModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }


  Future<CustomerSystems>  getSystemsBasedOnUserId(var body)async{
    try{
      dynamic response=await _apiServices.getPostApiResponse(ApiEndPoints.customerSystems, body);
      return CustomerSystems.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<AdminSystemsModel>  getSystemsBasedOnCustomerId(var body)async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(ApiEndPoints.adminSystems, body);
      return AdminSystemsModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }


  Future<SensorModel> getSensorsBasedOnSystemId(var systemId)async {

    try{
      dynamic response=await _apiServices.getPostApiResponse(ApiEndPoints.customerSensors, systemId);
      return SensorModel.fromJson(response);

    }catch(e){
      rethrow;
    }

  }

  Future<UserDashBoardModel> getUserDashBoardData(var id)async{
    try{
      dynamic response= await _apiServices.getGetApiResponse("${ApiEndPoints.userDashBoardData}?p_operator_id=$id");
      return UserDashBoardModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<AdminDashBoardModel> getAdminDashBoardData()async{
    try{
      dynamic response= await _apiServices.getGetApiResponse(ApiEndPoints.useadminDashBoardData);
      return AdminDashBoardModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<CustomerListModel> getCustomersList(data)async{

    try{
      dynamic response= await _apiServices.getPostApiResponse(ApiEndPoints.getCustomerList,data);
      return CustomerListModel.fromJson(response);
    }catch(e){
      rethrow;
    }

  }

  Future<ComplaintListModel> getComplaints(data)async{

    try{
      dynamic response= await _apiServices.getPostApiResponse(ApiEndPoints.getComplaints,data);
      return ComplaintListModel.fromJson(response);
    }catch(e){
      rethrow;
    }

  }

  Future<AdminComplaintListModel> getAdminComplaints(data)async{

    try{
      dynamic response= await _apiServices.getPostApiResponse(ApiEndPoints.getAdminComplaints,data);
      return AdminComplaintListModel.fromJson(response);
    }catch(e){
      rethrow;
    }

  }

  Future<SensorReportModel>getListOfGeneratedReports(data)async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(ApiEndPoints.getReportGenerated, data);
      return SensorReportModel.fromJson(response);

    }catch(e){
      rethrow;
    }
  }
  
  Future<NotificationListModel>getNotificationList(data)async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(ApiEndPoints.getNotificationList, data);
      return NotificationListModel.fromJson(response);
    }catch(e,stacktrace){
      debugPrint(e.toString());
      debugPrint(stacktrace.toString());
      throw stacktrace;
    }
  }

  Future<PitStatusModel>getPitStatus(data)async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(ApiEndPoints.getPitStatus, data);
      debugPrint("response : "+response.toString());
      return PitStatusModel.fromJson(response);
    }catch(e,stacktrace){
      debugPrint(e.toString());
      debugPrint(stacktrace.toString());
      throw stacktrace;
    }
  }

  Future<MqttRestApiData>getMqttDataFromRestApi(data)async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(ApiEndPoints.getMqttRestApiData, data);
      debugPrint("response : "+response.toString());
      return MqttRestApiData.fromJson(response);
    }catch(e,stacktrace){
      debugPrint(e.toString());
      debugPrint(stacktrace.toString());
      throw stacktrace;
    }
  }


}
