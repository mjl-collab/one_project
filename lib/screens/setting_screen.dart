import 'package:one_project/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 20,
              color: const Color.fromARGB(255, 9, 50, 111),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 45,
                  ),
                  child: const Text(
                    'Settings',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ],
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.black,
                size: 30,
              ),
              title: const Text(
                'Profile',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
            const ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.black,
                size: 30,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5),
              ),
            )
          ],
        ),
      ),
    );
  }
}
