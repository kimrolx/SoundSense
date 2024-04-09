import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:soundsense/src/constants/colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSwitched = false;

  final _recorder = AudioRecorder();
  Timer? _timer;

  final List<FlSpot> _volumeSpots = [];
  double _currentVolume = 0;

  @override
  void initState() {
    super.initState();
    startRecording();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recorder.dispose();
    super.dispose();
  }

  Future<void> startRecording() async {
    if (await _recorder.hasPermission()) {
      if (!await _recorder.isRecording()) {
        const recordConfig = RecordConfig(
          encoder: AudioEncoder.aacLc,
          sampleRate: 44100,
          bitRate: 128000,
        );

        await _recorder.startStream(recordConfig);

        _timer =
            Timer.periodic(const Duration(milliseconds: 20), (timer) async {
          final amplitude = await _recorder.getAmplitude();
          final rawVolume = amplitude.current.toDouble();

          double dbValue;

          if (rawVolume <= -150) {
            dbValue = 0;
          } else if (rawVolume >= -1) {
            dbValue = 120;
          } else {
            dbValue = (rawVolume + 30) * (50 / 30) + 30;
          }
          setState(() {
            _currentVolume = dbValue;
            _volumeSpots.add(FlSpot(_volumeSpots.length.toDouble(), dbValue));
          });
          print("Volume: $_currentVolume");
        });
      }
    }
  }

  Future<void> stopRecording() async {
    await _recorder.stop();
    _timer?.cancel();
    _timer = null;

    setState(() {
      _volumeSpots.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ivoryWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.015,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    //* Switch Button
                    width: width * 0.325,
                    height: height * 0.145,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(184, 106, 138, 1.0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Transform.scale(
                      scale: 1.5,
                      child: Switch(
                        value: isSwitched,
                        onChanged: (value) async {
                          setState(() {
                            isSwitched = value;
                          });
                          isSwitched
                              ? await startRecording()
                              : await stopRecording();
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.325,
                    height: height * 0.145,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(184, 106, 138, 1.0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
              Container(
                //* Line Chart
                width: width * 0.85,
                height: height * 0.35,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(233, 188, 185, 0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: LineChart(
                  LineChartData(
                      minY: 0,
                      maxY: 120.0,
                      lineBarsData: [
                        LineChartBarData(
                          spots: _volumeSpots,
                          isCurved: true,
                        ),
                      ],
                      titlesData: const FlTitlesData(
                        bottomTitles: AxisTitles(
                          axisNameWidget: Text('Noise Level'),
                        ),
                      )),
                ),
              ),
              Container(
                //* Radial Gauge
                width: width * 0.85,
                height: height * 0.25,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(184, 106, 138, 1.0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SfRadialGauge(
                  axes: [
                    RadialAxis(
                      showLabels: false,
                      showAxisLine: false,
                      showTicks: false,
                      minimum: 0,
                      maximum: 120,
                      ranges: [
                        myGauge(0, 30, Colors.green, 'Quiet', width, height),
                        myGauge(30, 60, Colors.yellow, 'Moderately Quiet',
                            width, height),
                        myGauge(60, 90, Colors.orange, 'Loud', width, height),
                        myGauge(
                            90, 120, Colors.red, 'Very Loud', width, height),
                      ],
                      pointers: [
                        NeedlePointer(value: _currentVolume),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

GaugeRange myGauge(double startValue, double endValue, Color color,
    String label, double width, double height) {
  return GaugeRange(
    startValue: startValue,
    endValue: endValue,
    color: color,
    label: label,
    sizeUnit: GaugeSizeUnit.factor,
    labelStyle: GaugeTextStyle(fontFamily: 'Times', fontSize: width * 0.035),
    startWidth: 0.4,
    endWidth: 0.4,
  );
}
