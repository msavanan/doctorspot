import 'package:doctorspot/header.dart';
import 'package:doctorspot/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class UserProfile extends StatelessWidget {
  UserProfile({this.user});
  final User? user;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Background(
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('First Name: ${user!.firstName} '),
            Container(
              height: height * 0.05,
            ),
            Text('Last Name: ${user!.lastName}'),
            Container(
              height: height * 0.05,
            ),
            Text('E-mail: ${user!.email}'),
            Container(
              height: height * 0.05,
            ),
            Text('Address: ${user!.address} '),
            Container(
              height: height * 0.05,
            ),
            Text(
                "Location: ${user!.location!.latitude?.toStringAsPrecision(6) ?? 0} , ${user!.location!.longitude?.toStringAsPrecision(6) ?? 0}"),
          ],
        ),
      ),
    );
  }
}
