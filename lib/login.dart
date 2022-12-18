import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mad/home.dart';
import 'package:mad/register.dart';

import 'const.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool _isLoading = false;
  void login() async {
    final auth = FirebaseAuth.instance;
    UserCredential userCredential;
    try {
      setState(() {
        _isLoading = true;
      });

      userCredential = await auth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      setState(() {
        _isLoading = false;
      });
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    } on PlatformException catch (err) {
      var message = 'An error occured, please check your credentials!';

      if (err.message != null) {
        message = err.message!;
      }

      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } on FirebaseAuthException catch (err) {
      print(err);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          err.message.toString(),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Theme.of(context).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "M.A.D",
                      style: TextStyle(
                          color: Color(0xff1D2322),
                          fontFamily: 'other',
                          fontWeight: FontWeight.bold,
                          fontSize: 40),
                    ),
                    Text(
                      "Welcomes You!",
                      style: TextStyle(
                          color: Color(0xff1D2322),
                          fontFamily: 'other',
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
                    ),
                    Text(
                      "Check your Speech Analytics",
                      style: TextStyle(
                          color: Color(0xff5A5A5A),
                          fontSize: 14,
                          fontFamily: 'other'),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    _isLoading
                        ? CircularProgressIndicator()
                        : Container(
                            height: MediaQuery.of(context).size.height / 2,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Color(0xffdfe2e2),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0, top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Color(0xff1D2322),
                                        fontFamily: 'other',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    child: TextField(
                                      controller: email,
                                      onChanged: (value) {},
                                      keyboardType: TextInputType.emailAddress,
                                      style:
                                          TextStyle(color: Color(0xFF7A8C99)),
                                      textAlign: TextAlign.left,
                                      decoration: kTextFieldDecoration.copyWith(
                                          contentPadding:
                                              EdgeInsets.only(left: 20),
                                          hintText: "Email Or Username"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    child: TextField(
                                      controller: password,
                                      onChanged: (value) {},
                                      obscureText: true,
                                      keyboardType: TextInputType.text,
                                      style:
                                          TextStyle(color: Color(0xFF7A8C99)),
                                      textAlign: TextAlign.left,
                                      decoration: kTextFieldDecoration.copyWith(
                                          contentPadding:
                                              EdgeInsets.only(left: 20),
                                          hintText: "Password"),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Forgot Pasword?",
                                        style: TextStyle(
                                            color: Color(0xff1D2322),
                                            fontFamily: 'other',
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 30,
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      if (email.text.trim().isEmpty ||
                                          password.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Please Enter Correct Details")));
                                      } else {
                                        login();
                                      }
                                    },
                                    elevation: 0,
                                    hoverElevation: 0,
                                    focusElevation: 0,
                                    highlightElevation: 0,
                                    minWidth: 340,
                                    height: 55,
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      "Log In",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'other',
                                          fontSize: 16),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Register()));
                                      },
                                      child: Text(
                                        "Don't have an account yet? SignUp",
                                        style: TextStyle(
                                            color: Color(0xffF24E8A),
                                            fontFamily: 'other',
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            )));
  }
}
