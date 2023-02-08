import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';
import '../../../providers/user_provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      alignment: Alignment.bottomLeft,
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
      ),
      child: RichText(
        text: TextSpan(
            text: 'Hello, ',
            style: const TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontFamily: "Ubuntu",
            ),
            children: [
              TextSpan(
                text: user.name,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
      ),
    );
  }
}
