import 'package:doctorspot/db/db.dart';
import 'package:doctorspot/header.dart';
import 'package:doctorspot/sign_in.dart';
import 'package:doctorspot/sign_up.dart';
import 'package:doctorspot/userForm/user_text_form_field.dart';
import 'package:doctorspot/userForm/validator.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _signInKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double spacer = height / 40;

    return SafeArea(
      child: Background(
        child: Expanded(
          child: Form(
            key: _signInKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: width * 0.05,
                        right: width * 0.05,
                        top: height * 0.05),
                    child: Column(children: [
                      UserTextField(
                        hintTxt: 'E-mail',
                        labelTxt: 'E-mail*',
                        validator: emailValidator,
                        controller: _emailController,
                      ),
                      Container(height: spacer),
                      UserTextField(
                        hintTxt: 'Passsword',
                        labelTxt: 'Passsword*',
                        validator: passwordValidator,
                        obscureTxt: true,
                        controller: _passwordController,
                      ),
                      Container(height: spacer),
                    ]),
                  ),
                  Container(height: spacer),
                  ElevatedButton(
                      onPressed: () async {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (currentFocus.hasFocus) {
                          currentFocus.unfocus();
                        }
                        if (_signInKey.currentState!.validate()) {
                          bool userExist = await UserDatabase.instance
                              .searchQuery(
                                  'userProfile', _emailController.text);
                          if (userExist) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SignIn(email: _emailController.text);
                            }));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Sign up failed, do you already have an account?")));

                            /*Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SignUp();
                            }));*/
                          }
                        }
                      },
                      child: Container(
                          height: 50,
                          width: width * 0.5,
                          child: Center(
                            child: Text(
                              'Log In',
                              textAlign: TextAlign.center,
                              style: TextStyle(),
                            ),
                          ))),
                  Container(height: spacer),
                  GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return SignUp();
                        }));
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontFamily: 'roboto'),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
