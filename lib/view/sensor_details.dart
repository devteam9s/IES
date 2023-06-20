import 'package:flutter/material.dart';

import '../res/colors.dart';

class SensorDetails extends StatefulWidget {
  const SensorDetails({Key? key}) : super(key: key);

  @override
  State<SensorDetails> createState() => _SensorDetailsState();
}

class _SensorDetailsState extends State<SensorDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.appThemeColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Details of sensor"),backgroundColor: CustomColors.appThemeColor,elevation: 0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              color: Colors.white,
              height: 1,
              thickness: 1,
            ),
          ),
        ),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
