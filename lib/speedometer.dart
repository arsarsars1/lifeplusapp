import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Speedmeter extends StatefulWidget {
  @override
  _SpeedmeterState createState() => _SpeedmeterState();
}

class _SpeedmeterState extends State<Speedmeter> {
  ///lIVE SPEED FUNCTION

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVehicleSpeed();
    NeedlePointer;
  }

  ///Speed Function
  double speedInMps;
  double speedInKph;
  var speed;
  int finalSpeed;
  var geolocator = Geolocator();
  var locationOptions =
      LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

  Future<void> getVehicleSpeed() async {
    try {
      geolocator.getPositionStream((locationOptions)).listen((position) async {
        speedInMps = await position.speed;
        setState(() {
          speedInKph = speedInMps * 1.609344;
          speed = speedInKph.round();

          print(speedInKph.round());
        });
      });
    } catch (e) {
      print(e);
    }
  }

  ///End Speed Function

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
              child: Container(
                  child: SfRadialGauge(axes: <RadialAxis>[
        RadialAxis(minimum: 0, maximum: 150, ranges: <GaugeRange>[
          GaugeRange(startValue: 0, endValue: 50, color: Colors.green),
          GaugeRange(startValue: 50, endValue: 100, color: Colors.orange),
          GaugeRange(startValue: 100, endValue: 150, color: Colors.red)
        ], pointers: <GaugePointer>[
          NeedlePointer(value: speedInKph)
        ], annotations: <GaugeAnnotation>[
          GaugeAnnotation(
              widget: Container(
                  child: Text("$speed km/h",
                      style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold))),
              angle: 90,
              positionFactor: 0.5)
        ])
      ])))),
    );
  }
}
