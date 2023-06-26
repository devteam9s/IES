import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
        title: const Text("Details of sensor"),
        backgroundColor: CustomColors.appThemeColor,
        elevation: 0,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SfCartesianChart(
                // Initialize category axis
                title: ChartTitle(text: "Voltage",textStyle: TextStyle(color: Colors.white)),
                primaryXAxis: CategoryAxis(),
                series: [
                  LineSeries<VoltageData, String>(
                    // Bind data source
                      dataSource:  <VoltageData>[
                        VoltageData('Jan', 35),
                        VoltageData('Feb', 28),
                        VoltageData('Mar', 34),
                        VoltageData('Apr', 32),
                        VoltageData('May', 40),
                        VoltageData('jun', 38)

                      ],
                      xValueMapper: (VoltageData volt, _) => volt.year,
                      yValueMapper: (VoltageData volts, _) => volts.volts,
                    color: Colors.white
                  ),
                ]
            ),
            SfCartesianChart(
              // Initialize category axis
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(text: "Resistance",textStyle: TextStyle(color: Colors.white)),
                series: [
                  ColumnSeries<VoltageData, String>(
                    // Bind data source
                      dataSource:  <VoltageData>[
                        VoltageData('Jan', 35),
                        VoltageData('Feb', 28),
                        VoltageData('Mar', 34),
                        VoltageData('Apr', 32),
                        VoltageData('May', 40),
                        VoltageData('jun', 38)

                      ],
                      xValueMapper: (VoltageData volt, _) => volt.year,
                      yValueMapper: (VoltageData volts, _) => volts.volts,
                    color: Colors.white,
                  ),
                ],
            ),
          ],
        ),
      ),
    );
  }


}

class VoltageData {
  VoltageData(this.year, this.volts);
  final String year;
  final double volts;
}

