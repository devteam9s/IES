import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ies_flutter_application/firebase_options.dart';
import 'package:ies_flutter_application/providers/admin_dash_board_provider.dart';
import 'package:ies_flutter_application/providers/complaint_list_provider_admin.dart';
import 'package:ies_flutter_application/providers/complaints_list_provider.dart';
import 'package:ies_flutter_application/providers/customert_list_provider.dart';
import 'package:ies_flutter_application/providers/mqtt_data_rest_provider.dart';
import 'package:ies_flutter_application/providers/mqtt_state.dart';
import 'package:ies_flutter_application/providers/notification_list_provider.dart';
import 'package:ies_flutter_application/providers/pit_status_providers.dart';
import 'package:ies_flutter_application/providers/reports_provider.dart';
import 'package:ies_flutter_application/providers/sensor_provider.dart';
import 'package:ies_flutter_application/providers/system_provider_admin.dart';
import 'package:ies_flutter_application/providers/systems_provider.dart';
import 'package:ies_flutter_application/providers/user_dash_board_provider.dart';
import 'package:ies_flutter_application/view/Home.dart';
import 'package:ies_flutter_application/view/splash_screen.dart';
import 'package:ies_flutter_application/view_model/add_system_and_sensors.dart';
import 'package:ies_flutter_application/view_model/login_logout_state.dart';
import 'package:provider/provider.dart';

void main()async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
  );

  FirebaseMessaging.onBackgroundMessage((message) {
    return _firebaseMessagingBackgroundHandler(message);
  },);
  runApp(const IesApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  await Firebase.initializeApp();
  debugPrint(message.notification?.title.toString());
  debugPrint(message.notification?.body.toString());
}


class IesApp extends StatelessWidget{
  const IesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SystemsProvider>( create: (context) => SystemsProvider()),
        ChangeNotifierProvider<AdminSystemsProvider>( create: (context) => AdminSystemsProvider()),
        ChangeNotifierProvider<SensorProvider>( create: (context) => SensorProvider()),
        ChangeNotifierProvider<UserDashBoardProvider>( create: (context) => UserDashBoardProvider()),
        ChangeNotifierProvider<LoginLogoutState>( create: (context) => LoginLogoutState()),
        ChangeNotifierProvider<AdminDashBoardProvider>( create: (context) => AdminDashBoardProvider()),
        ChangeNotifierProvider<AddSensorsAndSystems>( create: (context) => AddSensorsAndSystems()),
        ChangeNotifierProvider<MqttHandler>( create: (context) => MqttHandler()),
        ChangeNotifierProvider<CustomerListProvider>( create: (context) => CustomerListProvider()),
        ChangeNotifierProvider<ComplaintList>( create: (context) => ComplaintList()),
        ChangeNotifierProvider<ComplaintListAdmin>( create: (context) => ComplaintListAdmin()),
        ChangeNotifierProvider<ReportsProvider>( create: (context) => ReportsProvider()),
        ChangeNotifierProvider<NotificationListProvider>( create: (context) => NotificationListProvider()),
        ChangeNotifierProvider<PitStatusProvider>( create: (context) => PitStatusProvider()),
        ChangeNotifierProvider<MqttDataRestProvider>( create: (context) => MqttDataRestProvider()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "IES",
        home: SplashScreen(),
      ),
    );
  }
}