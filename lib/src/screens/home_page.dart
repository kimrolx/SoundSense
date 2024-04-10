import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:record/record.dart';
import 'package:soundsense/src/constants/colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:vibration/vibration.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSwitched = false;
  double _maxDbValue = 0.0;

  DateTime? _startTime;
  bool _isDialogShown = false;

  final _recorder = AudioRecorder();
  Timer? _timer;

  final List<FlSpot> _volumeSpots = [];
  double _currentVolume = 0;

  @override
  void initState() {
    super.initState();
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
            Timer.periodic(const Duration(milliseconds: 10), (timer) async {
          final amplitude = await _recorder.getAmplitude();
          final rawVolume = amplitude.current.toDouble();

          double dbValue;

          if (rawVolume <= -125) {
            dbValue = 30;
          } else if (rawVolume >= 0) {
            dbValue = 120;
          } else {
            dbValue = (rawVolume + 30) * (50 / 20) + 25;
          }

          setState(() {
            _currentVolume = dbValue;
            _volumeSpots.add(FlSpot(_volumeSpots.length.toDouble(), dbValue));
          });

          if (dbValue >= 67 && !_isDialogShown) {
            _startTime ??= DateTime.now();

            if (DateTime.now().difference(_startTime!).inSeconds >= 3) {
              _showCustomDialogAndVibrate();
              _startTime = null;
            }
          } else {
            _startTime = null;
          }

          if (dbValue > _maxDbValue) {
            setState(() {
              _maxDbValue = dbValue;
            });
          }
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
      _maxDbValue = 0.0;
    });
  }

  Future<void> _showCustomDialogAndVibrate() async {
    _isDialogShown = true;

    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(pattern: [500, 10000], repeat: 0);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const MyDialogWidget();
      },
    ).then((_) {
      Vibration.cancel();
      _isDialogShown = false;
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
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Max dbReached: ${_maxDbValue.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
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
                    ),
                  ),
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
                        minimum: 0,
                        maximum: 120,
                        showLabels: true,
                        showAxisLine: true,
                        showTicks: true,
                        axisLabelStyle: const GaugeTextStyle(fontSize: 0),
                        axisLineStyle: const AxisLineStyle(
                            thickness: 0.2,
                            thicknessUnit: GaugeSizeUnit.factor),
                        tickOffset: 0.32,
                        labelOffset: 5,
                        labelsPosition: ElementsPosition.outside,
                        ticksPosition: ElementsPosition.outside,
                        minorTicksPerInterval: 0,
                        majorTickStyle: const MajorTickStyle(
                          length: 0.1,
                          lengthUnit: GaugeSizeUnit.factor,
                          thickness: 1.5,
                        ),
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                            widget: Text(
                              '0db',
                              style: TextStyle(
                                  fontSize: width * 0.05,
                                  fontWeight: FontWeight.w500),
                            ),
                            angle: 140,
                            positionFactor: 1.25,
                          ),
                          GaugeAnnotation(
                            widget: Text(
                              '120db',
                              style: TextStyle(
                                  fontSize: width * 0.05,
                                  fontWeight: FontWeight.w500),
                            ),
                            angle: 40,
                            positionFactor: 1.25,
                          ),
                          GaugeAnnotation(
                            widget: Text(
                              '${_currentVolume.toStringAsFixed(2)} dB',
                              style: TextStyle(
                                  fontSize: width * 0.05,
                                  fontWeight: FontWeight.bold),
                            ),
                            angle: 90,
                            positionFactor: 0.6,
                          ),
                        ],
                        ranges: [
                          myGauge(0, 15, Colors.green, width, height),
                          myGauge(15, 35, Colors.lightGreen, width, height),
                          myGauge(35, 55, Colors.yellow, width, height),
                          myGauge(55, 75, Colors.orange, width, height),
                          myGauge(75, 95, Colors.redAccent, width, height),
                          myGauge(95, 120, Colors.red, width, height),
                          // Add other ranges here
                        ],
                        pointers: [NeedlePointer(value: _currentVolume)],
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

GaugeRange myGauge(double startValue, double endValue, Color color,
    double width, double height) {
  return GaugeRange(
    startValue: startValue,
    endValue: endValue,
    color: color,
    sizeUnit: GaugeSizeUnit.factor,
    labelStyle: GaugeTextStyle(fontFamily: 'Times', fontSize: width * 0.035),
    startWidth: 0.4,
    endWidth: 0.4,
  );
}

class MyDialogWidget extends StatelessWidget {
  const MyDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Dialog(
      child: Container(
        height: height * 0.35,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(249, 229, 161, 1.0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Gap(height * 0.05),
            Container(
              width: width,
              height: height * 0.25,
              color: const Color.fromRGBO(232, 188, 185, 1.0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset('assets/icons/horn_alert.svg'),
                        Text(
                          'High Level Noise Warning',
                          style: GoogleFonts.poppins(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Gap(height * 0.02),
                    Text(
                      'This area is subject to high noise levels that could potentially harm your hearing.',
                      style: GoogleFonts.inter(
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Gap(height * 0.01),
                    Text(
                      'For your safety, it\'s strongly recommended to use protective ear equipment while present.',
                      style: GoogleFonts.inter(
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     SvgPicture.asset('assets/icons/Alarm_duotone.svg'),
                    //     ElevatedButton(
                    //       onPressed: () {
                    //         Navigator.pop(context);
                    //       },
                    //       style: ElevatedButton.styleFrom(
                    //           backgroundColor:
                    //               const Color.fromRGBO(249, 229, 161, 1.0),
                    //           foregroundColor: white,
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(50),
                    //           ),
                    //           padding: EdgeInsets.symmetric(
                    //             horizontal: width * 0.1,
                    //             vertical: height * 0.025,
                    //           )),
                    //       child: Text(
                    //         'Close',
                    //         style: GoogleFonts.inter(
                    //           fontSize: width * 0.04,
                    //           fontWeight: FontWeight.w700,
                    //         ),
                    //       ),
                    //     ),
                    //     SvgPicture.asset('assets/icons/Alarm_duotone.svg'),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
