import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:one_project/providers/attendance_provider.dart';

class AttendanceHistory extends StatefulWidget {
  const AttendanceHistory({super.key});

  @override
  State<AttendanceHistory> createState() => _AttendanceHistoryState();
}

class _AttendanceHistoryState extends State<AttendanceHistory> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var attendanceHistory =
        context.watch<AttendanceProvider>().attendanceHistory;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attendance History',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Row(
                  children: const [
                    //Date
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          'Date',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    //Time In
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          'Time In',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    //Time Out
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          'Time Out',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    //Status
                  ],
                ),
              ),
            ),
            //List of Attendance of User
            ListView.builder(
                itemCount: attendanceHistory.length,
                // itemCount: 10,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: ((BuildContext context, int index) {
                  return SizedBox(
                      height: 80.0,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            //Date
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  attendanceHistory[index].date,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            //Time In
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  attendanceHistory[index].startTime,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            //Time Out
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  attendanceHistory[index].endTime ?? "--:--",
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
                }))
          ],
        ),
      ),
    );
  }
}
