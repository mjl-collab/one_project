import 'package:flutter/material.dart';
import 'package:one_project/screens/attendance_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home Page'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(38, 20, 30, 15),
              child: Text(
                'Click the attendance',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Flexible(
            child: GridView.extent(
              primary: false,
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              maxCrossAxisExtent: 120.0,
              children: <Widget>[
                Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.all(8),
                  child: InkWell(
                    child: Center(child: Text('Attendance')),
                    splashColor: Colors.white,
                    onTap: () async {
                      //attendance
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AttendancePageScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
