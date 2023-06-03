// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PromodoroApp(),
    );
  }
}

class PromodoroApp extends StatefulWidget {
  const PromodoroApp({Key? key}) : super(key: key);

  @override
  State<PromodoroApp> createState() => _PromodoroAppState();
}

class _PromodoroAppState extends State<PromodoroApp> {
  Duration duration = Duration(minutes: 25);
  Timer? repeatedTimer;
  bool isTimerStart = false;

  startTimer() {
    Duration newDuration = Duration(seconds: 1);
    repeatedTimer = Timer.periodic(newDuration, (timer) {
      setState(() {
        duration = duration - newDuration;

        if (duration == Duration(seconds: 0)) {
          repeatedTimer!.cancel();
          duration = Duration(minutes: 25);
          isTimerStart = false;
        }
      });
    });
    isTimerStart = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(78, 129, 139, 0.8),
        title: Text(
          "Promodoro ",
          style: TextStyle(
            fontSize: 32,
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(131, 216, 233, 0.8),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 132.0,
                  lineWidth: 16.0,
                  percent: (duration.inSeconds / 60) / 25,
                  backgroundColor: Color.fromRGBO(216, 233, 131, 0.8),
                  progressColor: Color.fromRGBO(233, 131, 216, 0.8),
                  animation: true,
                  animateFromLastPercent: true,
                  animationDuration: 1000,
                  center: Text(
                      "${duration.inMinutes.remainder(60).toString().padLeft(2, "0")} : ${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 64,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            SizedBox(
              height: 44,
            ),
            isTimerStart
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {
                            if (repeatedTimer!.isActive) {
                              setState(() {
                                repeatedTimer!.cancel();
                              });
                            } else {
                              startTimer();
                            }
                          },
                          child: Text(
                            repeatedTimer!.isActive ? "Stop" : "Resume",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromRGBO(216, 233, 131, 0.8)),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(14)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9))),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 44,
                      ),
                      SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {
                            repeatedTimer!.cancel();
                            setState(() {
                              duration = Duration(minutes: 25);
                              isTimerStart = false;
                            });
                          },
                          child: Text(
                            "CANCEL",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromRGBO(216, 233, 131, 0.8)),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(14)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9))),
                          ),
                        ),
                      ),
                    ],
                  )
                : ElevatedButton(
                    onPressed: () {
                      startTimer();
                    },
                    child: Text(
                      "START STUDYING",
                      style: TextStyle(fontSize: 22),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(233, 131, 216, 0.8)),
                      padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9))),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
