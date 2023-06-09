import 'package:adoptme/screens/home_page.dart';
import 'package:adoptme/services/authService.dart';
import 'package:adoptme/theme/theme_helper.dart';
import 'package:adoptme/widgets/header_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:hexcolor/hexcolor.dart';

import '../main.dart';
import 'forgot_password_page.dart';
import 'login_page.dart';
import 'profile_page.dart';
import 'set_profile_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final double _headerHeight = 250;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _headerHeight,
              child: HeaderWidget(
                  _headerHeight,
                  true,
                  const AssetImage(
                      "assets/images/logo.png")), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  margin: const EdgeInsets.fromLTRB(
                      20, 0, 20, 10), // This will be the login form
                  child: Column(
                    children: [
                      const Text(
                        'Hello',
                        style: TextStyle(
                            fontSize: 60, fontWeight: FontWeight.bold),
                      ),
                      // ignore: prefer_const_constructors
                      Text(
                        'Create a new account',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 20.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'email field must not be empty';
                                    }
                                    return null;
                                  },
                                  controller: emailController,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Email', 'Enter your email'),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              Container(
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'password field must not be empty';
                                    }
                                    return null;
                                  },
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Password', 'Enter your password'),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              Container(
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  controller: confirmPasswordController,
                                  obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration(
                                      "Confirm Password*",
                                      "Enter your password"),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Confirm your password';
                                    }
                                    if (value != passwordController.text) {
                                      return 'Password not Match';
                                    }

                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Text(
                                      'Sign Up'.toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      AuthService().SignUp(
                                          context,
                                          emailController.text.trim(),
                                          passwordController.text.trim());
                                    }
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(TextSpan(children: [
                                  TextSpan(text: "Already have an account? "),
                                  TextSpan(
                                    text: 'Login',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()));
                                      },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).accentColor),
                                  ),
                                ])),
                              ),
                              const Text(
                                "Or create account using social media",
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                child: FaIcon(
                                  FontAwesomeIcons.facebook,
                                  size: 35,
                                  color: HexColor("#3E529C"),
                                ),
                                onTap: () {
                                  AuthService()
                                      .SignInWithFacebook(context)
                                      .then(
                                          (value) => Get.to(const HomePage()));
                                },
                              ),
                            ],
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
