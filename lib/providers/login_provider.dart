import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginProvider extends ChangeNotifier {
  bool isLoginError = false;
  bool isLoading = false;

  //Post Method
  Future<bool> login(String email, String password) async {
    isLoading = true;
    notifyListeners();
    final response = await http.post(
      Uri.parse('https://demo.ast.com.ph/api/employees/accounts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    isLoading = false;
    if (response.statusCode == 200 || response.statusCode == 201) {
      //final loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
      isLoginError = false;
      notifyListeners();
      return true;
    } else {
      isLoginError = true;
      notifyListeners();
      return false;
    }
  }
  // Future<Response?> login(String email, String password) async {
  //   var dio = Dio();
  //   try {
  //     var response =
  //         await dio.post('https://demo.ast.com.ph/api/employees/accounts',
  //             data: {"email": email, "password": password},
  //             options: Options(
  //               headers: {
  //                 'Content-Type': 'application/json',
  //                 'Accept': 'application/json',
  //               },
  //             ));
  //     print(response.data);
  //     return response;
  //   } catch (e) {
  //     isLoginError = true;
  //   }
  //   return null;
  // }
}
