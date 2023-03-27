import 'package:one_project/screens/attendance_history_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/attendance_provider.dart';

class AttendanceRequest extends StatefulWidget {
  const AttendanceRequest({super.key});

  @override
  State<AttendanceRequest> createState() => _AttendanceRequestState();
}

class _AttendanceRequestState extends State<AttendanceRequest> {
  @override
  void initState() {
    final attendanceProvider =
        Provider.of<AttendanceProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var attendanceRequest =
        context.watch<AttendanceProvider>().attendanceRequest;

    return Scaffold(
      appBar: AppBar(
        title: (const Text(
          'Attendance Request',
        )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 65,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    // width: 140,
                    // height: 45,
                    child: context.watch<AttendanceProvider>().isLoadingSync
                        ? const Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                color: Color(0xFF1660AA),
                              ),
                            ),
                          )
                        : ElevatedButton.icon(
                            onPressed: () {
                              final attendanceProvider =
                                  Provider.of<AttendanceProvider>(context,
                                      listen: false);
                              attendanceProvider.sync();
                            },
                            style: ElevatedButton.styleFrom(),
                            //icon data for elevated button
                            label: const Text(
                              'Sync',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ), //label text
                            icon: const Icon(Icons.sync),
                          ),
                  ),
                  SizedBox(width: 15.0),
                ],
              ),
            ),
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
                              color: Colors.black, fontWeight: FontWeight.w500),
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
                              color: Colors.black, fontWeight: FontWeight.w500),
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
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    //Status
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          'Status',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //List of Attendance of User
            ListView.builder(
                itemCount: attendanceRequest.length,
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
                                  attendanceRequest[index].date,
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
                                  attendanceRequest[index].startTime,
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
                                  attendanceRequest[index].endTime ?? "--:--",
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            //Status
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Column(
                                    children: attendanceRequest[index].isSynced
                                        ? <Widget>[
                                            const Text(
                                              'Sync',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            //Status Approval
                                            const Text(
                                              'Decline',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ]
                                        : <Widget>[
                                            const Text(
                                              'Not Sync',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            //Status Approval
                                            const Text(
                                              'Pending',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ]),
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
