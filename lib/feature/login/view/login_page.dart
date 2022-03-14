import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_login/feature/login/view/profile_page.dart';
import 'package:google_login/product/utils/auth_funct.dart';
import 'package:google_login/product/utils/validator/validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  bool _isCircular = false;
  void changeIsCircular() {
    _isCircular = !_isCircular;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        body: FutureBuilder(
            future: Authentication().initializeFirebase(context: context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Login'),
                    Form(
                        key: _formkey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              focusNode: _focusEmail,
                              validator: (value) => Validator().validateEmail(email: value),
                            ),
                            TextFormField(
                              controller: _passwordController,
                              focusNode: _focusPassword,
                              validator: (value) => Validator().validatePassword(password: value),
                              decoration: InputDecoration(
                                errorBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.red)),
                              ),
                            ),
                            if (_isCircular)
                              CircularProgressIndicator()
                            else
                              Row(
                                children: [
                                  Expanded(
                                      child: ElevatedButton(
                                    onPressed: () async {
                                      _focusEmail.unfocus();
                                      _focusPassword.unfocus();

                                      setState(() {
                                        changeIsCircular();
                                      });
                                      if (_formkey.currentState!.validate()) {
                                        User? user = await Authentication().emailSignIn(
                                            email: _emailController.text, password: _passwordController.text);
                                      }

                                      setState(() {
                                        changeIsCircular();
                                      });
                                    },
                                    child: Text('Sign In'),
                                  ))
                                ],
                              )
                          ],
                        )),
                    ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            changeIsCircular();
                          });
                          User? user = await Authentication().signInWithGoogle();
                          setState(() {
                            changeIsCircular();
                          });
                          if (user != null) {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: ((context) => ProfilePage(user: user))));
                          }
                        },
                        child: Text('google sign in'))
                  ],
                );
              }
              return SizedBox();
            }),
      ),
    );
  }
}
