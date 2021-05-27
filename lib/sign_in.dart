import 'package:doctorspot/address_page.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  SignIn({this.email});
  final String? email;
  @override
  Widget build(BuildContext context) {
    return AddressBox(email: email);
  }
}
