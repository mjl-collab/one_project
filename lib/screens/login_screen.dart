import 'package:flutter/material.dart';
import 'package:one_project/screens/attendance_screen.dart';
import 'package:one_project/screens/bottom_nav_screen.dart';
import 'package:one_project/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../providers/login_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isLoginError = context.watch<LoginProvider>().isLoginError;
    final isLoading = context.watch<LoginProvider>().isLoading;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 225),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  width: 400.0,
                  height: 400.0,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 10,
                    child: Form(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Form(
                                child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 50, left: 20, right: 20),
                                  child: TextFormField(
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                        hintText: 'Email',
                                        border: OutlineInputBorder(),
                                        hintStyle: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 50, left: 20, right: 20),
                                  child: TextFormField(
                                      controller: passwordController,
                                      obscureText: _isObscure,
                                      decoration: InputDecoration(
                                          hintText: 'Password',
                                          hintStyle: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500),
                                          border: const OutlineInputBorder(),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _isObscure
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: const Color(0xFF0D2E62),
                                            ),
                                            onPressed: () {},
                                          ))),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                isLoginError
                                    ? const Padding(
                                        padding: EdgeInsets.only(bottom: 15),
                                        child: Text(
                                          'Email or password is incorrect',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14,
                                          ),
                                        ),
                                      )
                                    : Container(),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: SizedBox(
                                      width: 200.0,
                                      height: 50.0,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          login();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const BottomNavPage()),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        child: !isLoading
                                            ? const Text(
                                                'Sign in',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 18,
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            : const SizedBox(
                                                width: 15,
                                                height: 15,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 3.0,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void login() async {
    context
        .read<LoginProvider>()
        .login(emailController.text, passwordController.text)
        .then((value) {
      if (value == true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AttendancePageScreen()),
        );
      }
    });
  }
}

class ClipClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final highPoint = size.height - 40;
    Path path = Path();

    path.lineTo(0, 450); // height of clip
    path.lineTo(1500, 0); //width of clip
    //path.lineTo(size.width - 500, size.height - 500);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
