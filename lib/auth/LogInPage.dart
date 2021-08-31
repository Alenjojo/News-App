import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Pages/BaseLayer.dart';
import 'package:news_app/Pages/Home.dart';
import 'package:news_app/services/auth.dart';
import 'package:news_app/services/snack_bar_service.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: 'sign-in-form');
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late String _snackBarText;
  AuthMethod authMethod = new AuthMethod();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            body: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 40),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Log In.',
                                style: TextStyle(
                                    fontSize: 80.0,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'email cannot be empty';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'password cannot be empty';
                          }
                          return null;
                        },
                      ),
                      Spacer(),
                      InkWell(
                        child: Container(
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Color(0xff12ACB1),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Center(
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                          authMethod
                              .signinwithemailandpassword(_emailController.text,
                              _passwordController.text)
                              .then((val) async {
                                if(val == null){
                                  final snackBar = SnackBar(content: Text('Invalid Input'));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }else if(val == 'No user found for that email'){
                                  final snackBar = SnackBar(content: Text('No user found for that email'));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }else if(val == 'Wrong password provided for that user'){
                                  final snackBar = SnackBar(content: Text('Wrong password provided for that user'));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }else{
                                  final snackBar = SnackBar(content: Text('Logged In'));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => BaseLayer()),
                                  );
                                }
                          });

                          //   print(_snackBarText);
                          // if (_snackBarText != null) {
                          //     SnackBarService.instance
                          //         .showSnackBar(scaffoldKey, _snackBarText);
                          //   } else {
                          //     SnackBarService.instance
                          //         .showSnackBar(scaffoldKey, _snackBarText);
                          //   }
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: 40.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Center(
                            child: Text(
                              'Go Back',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
