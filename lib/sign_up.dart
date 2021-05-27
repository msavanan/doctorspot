import 'package:doctorspot/header.dart';
import 'package:doctorspot/userForm/user_text_form_field.dart';
import 'package:doctorspot/userForm/validator.dart';
import 'package:flutter/material.dart';

import 'db/db.dart';
import 'homePage.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double spacer = height / 40;

    return Scaffold(
      body: Background(
        child: Expanded(
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.only(
                  left: width * 0.05, right: width * 0.05, top: height * 0.05),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(height: spacer),
                      UserTextField(
                        controller: _firstNameController,
                        hintTxt: 'First Name',
                        labelTxt: 'First Name*',
                        validator:
                            nameValidator, //(firstName) => firstName.isEmpty ? '*Required' : null,
                      ),
                      Container(height: spacer),
                      UserTextField(
                        controller: _lastNameController,
                        hintTxt: 'Last Name',
                        labelTxt: 'Last Name*',
                        validator:
                            nameValidator, //(firstName) => firstName.isEmpty ? '*Required' : null,
                      ),
                      Container(height: spacer),
                      UserTextField(
                        controller: _emailController,
                        hintTxt: 'E-mail',
                        labelTxt: 'E-mail*',
                        validator: emailValidator,
                      ),
                      Container(height: spacer),
                      UserTextField(
                        controller: _passwordController,
                        hintTxt: 'Passsword',
                        labelTxt: 'Passsword*',
                        validator: passwordValidator,
                        obscureTxt: true,
                      ),
                      Container(height: spacer),
                      Center(
                        child: Container(
                            height: 50,
                            width: width * 0.6,
                            child: ElevatedButton(
                                onPressed: () async {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);

                                  if (currentFocus.hasFocus) {
                                    currentFocus.unfocus();
                                  }

                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      await UserDatabase.instance
                                          .insert('userProfile', {
                                        'email': _emailController.text,
                                        'firstName': _firstNameController.text,
                                        'lastName': _lastNameController.text,
                                        'password': _passwordController.text
                                      });
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return HomePage();
                                      }));
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "User already exists!")));
                                    }
                                  }
                                },
                                child: Text(
                                  'Log In',
                                  style: TextStyle(),
                                ))),
                      ),
                      Container(height: spacer),
                      Container(height: 10),
                      GestureDetector(
                          onTap: () {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (currentFocus.hasFocus) {
                              currentFocus.unfocus();
                            }
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return HomePage();
                            }));
                          },
                          child: Center(
                              child: Text(
                            'Sign in',
                            //style: TextStyle(fontSize: 18,                        ),
                          ))),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
