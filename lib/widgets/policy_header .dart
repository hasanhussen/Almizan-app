import 'package:flutter/material.dart';

class PolicyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/img/bg.jpg"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      alignment: Alignment.center,
      child: const Text(
        "سياسة الخصوصية",
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }
}
