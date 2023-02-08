import 'dart:convert';
import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/global_variables.dart';
import '../../../providers/user_provider.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
      );
      debugPrint("Checkpoint 1");

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      debugPrint("Checkpoint 2");

      debugPrint(res.body);

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
              context,
              'Account created! Login with the same credentials',
            );
          });
      debugPrint("Checkpoint 3");
    } catch (e) {
      debugPrint("Checkpoint 4");
      debugPrint(e.toString());
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
    required bool keepSignedIn,
  }) async {
    try {
      debugPrint("Checkpoint 1");
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      debugPrint("Checkpoint 2");

      debugPrint(res.body);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          if (keepSignedIn) {
            final prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
              context,
              BottomBar.routeName,
              (route) => false,
            );
          }
        },
      );
      debugPrint("Checkpoint 3");
    } catch (e) {
      debugPrint("Checkpoint 4");
      debugPrint(e.toString());
      showSnackBar(context, e.toString());
    }
  }

  void getUserData({
    required BuildContext context,
  }) async {
    try {
      debugPrint("Checkpoint 1");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/api/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }

      // debugPrint(res.body);
      //
      // httpErrorHandle(
      //   response: res,
      //   context: context,
      //   onSuccess: () async {
      //     if (keepSignedIn) {
      //       final prefs = await SharedPreferences.getInstance();
      //       Provider.of<UserProvider>(context, listen: false).setUser(res.body);
      //       await prefs.setString(
      //           'x-auth-token', jsonDecode(res.body)['token']);
      //       Navigator.pushNamedAndRemoveUntil(
      //         context,
      //         HomeScreen.routeName,
      //             (route) => false,
      //       );
      //     }
      //   },
      // );
      // debugPrint("Checkpoint 3");
    } catch (e) {
      debugPrint("Checkpoint 4");
      debugPrint(e.toString());
      // showSnackBar(context, e.toString());
    }
  }
}
