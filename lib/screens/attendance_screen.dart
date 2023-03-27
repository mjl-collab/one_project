import 'dart:async';
import 'package:one_project/screens/attendance_history_screen.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:one_project/providers/attendance_provider.dart';
import 'package:one_project/screens/attendance_request_screen.dart';

class AttendancePageScreen extends StatefulWidget {
  const AttendancePageScreen({super.key});

  @override
  State<AttendancePageScreen> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePageScreen> {
  @override
  void initState() {
    //reset the time in/timeout at the end of the day
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final now = DateTime.now();
    //   Timer(
    //       DateTime(now.year, now.month, now.day + 1, 0, 0, 0)
    //           .difference(DateTime.now()), () {
    //     context.read<AttendanceProvider>().getTodayAttendance();
    //   });
    // });

    final attendanceProvider =
        Provider.of<AttendanceProvider>(context, listen: false);

    attendanceProvider.checkDate();
    attendanceProvider.getAttendanceRequest();
    attendanceProvider.getAttendanceHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attendanceProvider =
        Provider.of<AttendanceProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: (const Text(
          'Attendance',
          style: TextStyle(fontFamily: 'Poppins'),
        )),
        centerTitle: true,
        actions: [
          PopupMenuButton(itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: const Text(
                  'Request',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
                ),
                onTap: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AttendanceRequest()),
                    );
                  });
                },
              ),
              PopupMenuItem(
                child: const Text(
                  'History',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
                ),
                onTap: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AttendanceHistory()),
                    );
                  });
                },
              )
            ];
          })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Column(children: [
                    Text(
                      'Attendance',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    )
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Material(
                    elevation: 8.0,
                    shape: const CircleBorder(),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () async {
                        final currentDayAttendance =
                            attendanceProvider.currentDayAttendance;
                        if (currentDayAttendance == null) {
                          await attendanceProvider.createCurrentDayAttendance();
                        } else {
                          await attendanceProvider.endCurrentAttendance();
                          attendanceProvider.clearCurrentDay();
                        }
                      },
                      child: CircleAvatar(
                        radius: 100.0,
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              gradient: attendanceProvider.isCheckedIn ==
                                          null ||
                                      attendanceProvider.isCheckedIn == false
                                  ? const LinearGradient(colors: <Color>[
                                      Color(0xFF42A5F5),
                                      Color.fromARGB(255, 27, 131, 235),
                                    ])
                                  : const LinearGradient(colors: <Color>[
                                      Color.fromARGB(255, 245, 66, 66),
                                      Color.fromARGB(255, 235, 27, 27),
                                    ])),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  attendanceProvider.isCheckedIn == null ||
                                          attendanceProvider.isCheckedIn ==
                                              false
                                      ? 'CLICK TIME IN'
                                      : 'CLICK TIME OUT',
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //Cards
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 12, 30, 12),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      height: 120.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.blueGrey,
                              blurRadius: 0.2,
                              offset: Offset(1, 1))
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //Start Time
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.arrow_forward_rounded,
                                color: Color.fromARGB(255, 48, 106, 192),
                              ),
                              Text(
                                context
                                        .watch<AttendanceProvider>()
                                        .currentDayAttendance
                                        ?.startTime ??
                                    "--:--",
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1),
                              ),
                              const Text(
                                'Time In',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Colors.black54),
                              )
                            ],
                          ),
                          //End Time
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.arrow_back_rounded,
                                color: Color.fromARGB(255, 48, 106, 192),
                              ),
                              Text(
                                context
                                        .watch<AttendanceProvider>()
                                        .currentDayAttendance
                                        ?.endTime ??
                                    "--:--",
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1),
                              ),
                              const Text(
                                'Time Out',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Colors.black54),
                              )
                            ],
                          ),
                          //Working Hours
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: const [
                          //     Icon(
                          //       Icons.arrow_forward_rounded,
                          //       color: Color.fromARGB(255, 48, 106, 192),
                          //     ),
                          //     Icon(
                          //       Icons.timelapse_outlined,
                          //       color: Color.fromARGB(255, 48, 106, 192),
                          //     ),
                          //     Text(
                          //       '--',
                          //       style: TextStyle(
                          //           fontFamily: 'Poppins',
                          //           fontSize: 15,
                          //           fontWeight: FontWeight.w700,
                          //           letterSpacing: 1),
                          //     ),
                          //     Text(
                          //       'Working Hrs',
                          //       style: TextStyle(
                          //           fontFamily: 'Poppins',
                          //           fontWeight: FontWeight.w500,
                          //           fontSize: 13,
                          //           color: Colors.black54),
                          //     )
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                //Today
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                //   child: Card(
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10.0),
                //     ),
                //     child: Container(
                //         height: 120.0,
                //         decoration: BoxDecoration(
                //           color: Colors.white,
                //           boxShadow: const [
                //             BoxShadow(
                //                 color: Colors.blueGrey,
                //                 blurRadius: 0.2,
                //                 offset: Offset(1, 1))
                //           ],
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         child: Column(
                //           children: [
                //             Expanded(
                //               child: Container(
                //                 color: Colors.orange,
                //                 child: Row(
                //                   children: const [
                //                     Expanded(
                //                       flex: 1,
                //                       child: Center(
                //                         child: Text(
                //                           'Date',
                //                           style: TextStyle(
                //                               fontFamily: 'Poppins',
                //                               color: Colors.white,
                //                               fontWeight: FontWeight.w500),
                //                         ),
                //                       ),
                //                     ),
                //                     Expanded(
                //                       flex: 1,
                //                       child: Center(
                //                         child: Text(
                //                           'Time In',
                //                           style: TextStyle(
                //                               fontFamily: 'Poppins',
                //                               color: Colors.white,
                //                               fontWeight: FontWeight.w500),
                //                         ),
                //                       ),
                //                     ),
                //                     Expanded(
                //                       flex: 1,
                //                       child: Center(
                //                         child: Text(
                //                           'Time Out',
                //                           style: TextStyle(
                //                               fontFamily: 'Poppins',
                //                               color: Colors.white,
                //                               fontWeight: FontWeight.w500),
                //                         ),
                //                       ),
                //                     ),
                //                     Expanded(
                //                       flex: 1,
                //                       child: Center(
                //                         child: Text(
                //                           'Working Hrs',
                //                           style: TextStyle(
                //                               fontFamily: 'Poppins',
                //                               color: Colors.white,
                //                               fontWeight: FontWeight.w500),
                //                         ),
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //             Row(
                //               children: [
                //                 Column(
                //                   crossAxisAlignment: CrossAxisAlignment.center,
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   children: const [
                //                     Icon(
                //                       Icons.arrow_forward_rounded,
                //                       color: Color.fromARGB(255, 48, 106, 192),
                //                     ),
                //                     Icon(
                //                       Icons.timelapse_outlined,
                //                       color: Color.fromARGB(255, 48, 106, 192),
                //                     ),
                //                     Text(
                //                       '--',
                //                       style: TextStyle(
                //                           fontFamily: 'Poppins',
                //                           fontSize: 15,
                //                           fontWeight: FontWeight.w700,
                //                           letterSpacing: 1),
                //                     ),
                //                     Text(
                //                       'Working Hrs',
                //                       style: TextStyle(
                //                           fontFamily: 'Poppins',
                //                           fontWeight: FontWeight.w500,
                //                           color: Colors.black54),
                //                     )
                //                   ],
                //                 ),
                //               ],
                //             ),
                //           ],
                //         )),
                //   ),
                // ),
              ],
            ),
            //Cards
          ],
        ),
      ),
    );
  }
}
