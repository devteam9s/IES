import 'dart:io';
import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NotificationServices{

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();


  void requestNotificationPermission()async{

    NotificationSettings settings =await messaging.requestPermission(
      sound: true,
      provisional:true ,
      criticalAlert: true,
      carPlay: true,
      badge: true,
      announcement:true ,
      alert: true,
    );

    if(settings.authorizationStatus==AuthorizationStatus.authorized){
      debugPrint("User granted permissin");
    }else if(settings.authorizationStatus==AuthorizationStatus.provisional){
      debugPrint("User granted provisional permissin");
    }else{
      AppSettings.openAppSettings();
      debugPrint("User denied permissin");
    }

  }

  void initLocalNotifications(BuildContext context,RemoteMessage message)async{

    var androidInitializationSetting = const AndroidInitializationSettings("@drawable/souk_logo");
    var iosInitializationSetting = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
        android: androidInitializationSetting,
        iOS: iosInitializationSetting
    );

    await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (payload){
        handleMessage(context, message);
    });

  }

  void firebaseInit(BuildContext context){

    FirebaseMessaging.onMessage.listen((message) {

      if(Platform.isAndroid){
        initLocalNotifications(context, message);
      }

      debugPrint(message.notification?.title.toString());
      debugPrint(message.notification?.body.toString());

      if(Platform.isAndroid){
        initLocalNotifications(context,message);
        showNotification(message);
      }else{
        showNotification(message);
      }
    });

  }

  Future<void> showNotification(RemoteMessage message)async{

    AndroidNotificationChannel channel=AndroidNotificationChannel(Random.secure().nextInt(10000).toString(), "High Importance",importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: "Your channel discription",
      importance: Importance.high,
      priority: Priority.high,
      ticker: "ticker",
    );

    DarwinNotificationDetails darwinNotificationDetails=const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true
    );

    NotificationDetails notificationDetails=NotificationDetails(android: androidNotificationDetails,
        iOS:darwinNotificationDetails );

    Future.delayed(Duration.zero,() {
      _flutterLocalNotificationsPlugin.show(
          1,
          message.notification?.title.toString(),
          message.notification?.body.toString(),
          notificationDetails
      );
    },);
  }

  Future<String> getDeviceToken()async{
    var sp =await SharedPreferences.getInstance();

    String? token = await messaging.getToken();
    sp.setString("deviceID", token.toString());
    return token!;

  }

  void isTokenRefresh()async{
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }


  Future<void> setupInteractMessage(BuildContext context)async{
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    //when app is terminated
    if(initialMessage!=null){
      handleMessage(context, initialMessage);
    }

    //when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });

  }

  void handleMessage(BuildContext context,RemoteMessage message){
    if(message.data["type"]=='msj'){
      // Navigator.push(context, MaterialPageRoute(builder: (context) => MessageScreen(),));
    }
  }



}