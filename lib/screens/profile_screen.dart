import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 9, 50, 111),
        bottomOpacity: 0.0,
        elevation: 0.0,
        //centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
              fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 25,
                        top: 45,
                      ),
                      child: const Text(
                        'Name',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            letterSpacing: 0.5),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Juan Dela Cruz',
                        hintStyle: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            fontFamily: 'Poppins')),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 25,
                        top: 20,
                      ),
                      child: const Text(
                        'Email',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            letterSpacing: 0.5),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'juan@gmail.com',
                      hintStyle: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          fontSize: 15),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 25,
                        top: 20,
                      ),
                      child: const Text(
                        'Phone',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            letterSpacing: 0.5),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: '09662546394',
                        hintStyle: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins')),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 25,
                        top: 20,
                      ),
                      child: const Text(
                        'Address',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          letterSpacing: 0.5,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'New Cabalan Olongapo City',
                      hintStyle: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 25,
                        top: 20,
                      ),
                      child: const Text(
                        'Birthday',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            letterSpacing: 0.5),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'April 4, 2000',
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
