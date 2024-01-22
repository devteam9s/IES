import 'package:flutter/cupertino.dart';
import 'package:ies_flutter_application/models/mqtt_data.dart';
import 'package:intl/intl.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttHandler with ChangeNotifier {
  final ValueNotifier<String> date = ValueNotifier<String>("");
  final ValueNotifier<String> resistanceValue = ValueNotifier<String>("");
  final ValueNotifier<String> voltageValue = ValueNotifier<String>("");
  final ValueNotifier<String> currentValue = ValueNotifier<String>("");

  List voltages = [];
  List<String> current = [];
  List<MQTTData> currentList = List.empty(growable: true);
  List<MQTTData> voltageList = List.empty(growable: true);
  List<MQTTData> resistanceList = List.empty(growable: true);

  List<String> resistance = [];

  String? vt, ct, re, tm;
  bool reLoading = true;
  bool ctLoading = true;
  bool vtLoading = true;
  bool dateLoading = true;


  double currentMaxY = 30;
  double voltageMaxY = 30;
  double resistanceMaxY = 30;



  Future<Object> connect(String topic) async {
    MqttServerClient client= MqttServerClient.withPort("ies.soukhyatech.com", "mobile_client", 3000);

    currentList.clear();
    voltageList.clear();
    resistanceList.clear();

    reLoading = true;
    ctLoading = true;
    vtLoading = true;

    debugPrint(topic);
    client.logging(on: true);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;

    client.logging(on: true);

    client.setProtocolV311();

    final connMessage = MqttConnectMessage()
        .withWillTopic("willTopic")
        .withWillMessage("willMessage")
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    // debugPrint("Connecting to the server");

    client.connectionMessage = connMessage;

    try {
      await client.connect();
    } catch (e) {
      debugPrint("Exception : $e");
      client.disconnect();
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      // debugPrint('MQTT_LOGS::Mosquitto client connected');
    } else {
      // debugPrint ('MQTT_LOGS::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      return -1;
    }
    debugPrint('MQTT_LOGS::Subscribing to the test/lol topic');
    final topic1 = '$topic/V';
    final topic2 = '$topic/C';
    final topic3 = '$topic/R';

    // final topic1 = 'site1/pit1/V';
    // final topic2 = 'site1/pit1/C';
    // final topic3 = 'site1/pit1/R';
    // final topic4 = 'site1/pit1/time';

    client.subscribe(topic1, MqttQos.atMostOnce);
    client.subscribe(topic2, MqttQos.atMostOnce);
    client.subscribe(topic3, MqttQos.atMostOnce);

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;

      final topic = c[0].topic;

      debugPrint("---topic----- : $topic");

      if(topic==topic1){
        MQTTData vtMQTTdata = MQTTData();
        vt=MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        vtMQTTdata.data = vt;
        vtMQTTdata.timeInterval = getCurrentUnixTimestamp().toString();
        voltageList.add(vtMQTTdata);
        voltages.add(vt);
        if(double.parse(vtMQTTdata.data!)>=voltageMaxY) {
          voltageMaxY = (int.parse(vtMQTTdata.data!)) + 5;
        }else{
          voltageMaxY = voltageMaxY;
        }
        if(voltageList.length >= 10) {
          voltageList.removeAt(0);
        }
        vtLoading=false;
        notifyListeners();

      }
      else if(topic==topic2){

        ct=MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        current.add(ct!);
        MQTTData mqttData = MQTTData();
        mqttData.data = ct;
        mqttData.data = (double.parse(mqttData.data!)).toString();
        mqttData.timeInterval = getCurrentUnixTimestamp().toString();
        currentList.add(mqttData);

        if(double.parse(mqttData.data!)>=currentMaxY) {
          currentMaxY = (int.parse(mqttData.data!)) + 5;
        }else{
          currentMaxY = currentMaxY;
        }
        ctLoading = false;
        if(currentList.length >= 10) {
          currentList.removeAt(0);
        }
        debugPrint("max value is : ${currentMaxY}");
        notifyListeners();

      }else if(topic==topic3){
        MQTTData reMQTTdata = MQTTData();
        re=MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        reMQTTdata.data = re;
        reMQTTdata.timeInterval = getCurrentUnixTimestamp().toString();
        resistanceList.add(reMQTTdata);
        resistance.add(re!);
        if(double.parse(reMQTTdata.data!)>=resistanceMaxY) {
          resistanceMaxY = (double.parse(reMQTTdata.data!));
          debugPrint("new re value:"+resistanceMaxY.toString());
        }else{
          resistanceMaxY = resistanceMaxY;
          debugPrint("re max val: "+resistanceMaxY.toString());
        }
        if(resistanceList.length >= 10) {
          resistanceList.removeAt(0);
        }
        reLoading = false;
        notifyListeners();

      }else{

        tm=MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        debugPrint("---------time: $tm");
        date.value = tm!;
        dateLoading = false;
        notifyListeners();

      }


      debugPrint("type :" +vt.runtimeType.toString());


      notifyListeners();
      debugPrint("");
      debugPrint("values : $voltages");
      debugPrint("");

      debugPrint("");
      debugPrint('New data arrived: topic is <${c[0].topic}>, payload is $vt');
      debugPrint("");

      if(voltages.length==10){
        voltages.removeAt(0);
        notifyListeners();
      }

      if(current.length==10){
        current.removeAt(0);
      }
      if(resistance.length==10){
        resistance.removeAt(0);
      }
    });
    notifyListeners();

    return client;
  }

  Future<Object> disConnect(topic)async{

    MqttServerClient client= MqttServerClient.withPort("ies.soukhyatech.com", "mobile_client", 3000);
    debugPrint("Topic : ${topic} --");
    client.unsubscribe(topic);
    vtLoading = true;
    ctLoading = true;
    reLoading = true;
    notifyListeners();

    return client;
  }

  void onConnected() {
    // debugPrint('MQTT_LOGS:: Connected');
  }

  void onDisconnected() {
    debugPrint('MQTT_LOGS:: Disconnected');
  }

  void onSubscribed(String topic) {
    // debugPrint('MQTT_LOGS:: Subscribed topic: $topic');
  }

  void onSubscribeFail(String topic) {
    debugPrint('MQTT_LOGS:: Failed to subscribe $topic');
  }

  void onUnsubscribed(String? topic) {
    debugPrint('MQTT_LOGS:: Unsubscribed topic: $topic');
  }

  void pong() {
    debugPrint('MQTT_LOGS:: Ping response client callback invoked');
  }

  void connMessage() {}

  int getCurrentUnixTimestamp() {
    // Get the current time in UTC
    DateTime now = DateTime.now().toUtc();

    // Convert the DateTime to milliseconds since the Unix epoch
    int millisecondsSinceEpoch = now.millisecondsSinceEpoch;

    // Convert milliseconds to seconds
    int secondsSinceEpoch = (millisecondsSinceEpoch / 1000).round();
    debugPrint("Seconds since epoch .. " + secondsSinceEpoch.toString());
    return secondsSinceEpoch;
  }

}
