import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  Background({this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/image/banner.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          child!
        ],
      ),
    );
  }
}
