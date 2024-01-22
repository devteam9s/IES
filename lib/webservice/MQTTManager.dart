//
//
//
// import 'package:flutter/cupertino.dart';
// import 'package:ies_flutter_application/providers/mqtt_state.dart';
// import 'package:mqtt_client/mqtt_client.dart';
// import 'package:mqtt_client/mqtt_server_client.dart';
//
// class MQTTManager{
//
//   final MQTTAppState _currentState;
//   MqttServerClient? _client;
//   final String _identifier;
//   final String _host;
//   final String _topic;
//
//   MQTTManager({
//     required String host,
//     required String topic,
//     required String identifier,
//     required MQTTAppState state,}):_identifier=identifier,_host=host,_topic=topic,_currentState=state;
//
//   void initializeMQTTClient(){
//     _client=MqttServerClient(_host,_identifier);
//     _client!.port=1883;
//     _client!.keepAlivePeriod=60;
//     _client!.onDisconnected = onDisconnected;
//     _client!.secure = false;
//     _client!.logging(on: true);
//     _client!.onConnected = onConnected;
//     _client!.onSubscribed = onSubscribed;
//
//     final MqttConnectMessage connMess = MqttConnectMessage()
//           .withClientIdentifier(_identifier)
//           .withWillTopic('willTopic')
//           .withWillMessage('My willMessage')
//           .startClean()
//           .withWillQos(MqttQos.atLeastOnce);
//
//     debugPrint("Mqtt client connecting....");
//
//     _client!.connectionMessage=connMess;
//   }
//
//
//   void connect()async{
//     assert(_client!=null);
//     try{
//       debugPrint("Start client connecting....");
//       _currentState.setAppConnectionState(MQTTAppConnectionState.connecting);
//       await _client!.connect();
//     }on Exception catch (e){
//       debugPrint("Client exception $e");
//       disConnect();
//     }
//   }
//
//   void disConnect(){
//     debugPrint("Disconnected");
//     _client!.disconnect();
//   }
//
//   void publish(String message){
//     final MqttClientPayloadBuilder builder=MqttClientPayloadBuilder();
//     builder.addString(message);
//   }
//
//   void onSubscribed(String topic){
//     debugPrint('EXAMPLE::Subscription confirmed for topic $topic');
//   }
//
//   void onDisconnected(){
//     debugPrint("EXAMPLE::OnDisconnected client callback - Client disconnection ");
//     if(_client!.connectionStatus!.returnCode==MqttConnectReturnCode.noneSpecified){
//       debugPrint('EXAMPLE::OnDisconnected callback is solicited, this is correct');
//     }
//     _currentState.setAppConnectionState(MQTTAppConnectionState.disconnected);
//   }
//
//   void onConnected(){
//     _currentState.setAppConnectionState(MQTTAppConnectionState.connected);
//     debugPrint("Client connected");
//
//     _client!.subscribe(_topic, MqttQos.atLeastOnce);
//     _client!.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
//       final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
//
//       // final MqttPublishMessage recMess = c![0].payload;
//       final String pt =
//       MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
//       _currentState.setReceivedText(pt);
//       debugPrint(
//           'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
//       debugPrint('');
//     });
//     debugPrint(
//         'EXAMPLE::OnConnected client callback - Client connection was sucessful');
//   }
// }