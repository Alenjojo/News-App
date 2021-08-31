import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Pages/BaseLayer.dart';
import 'package:news_app/Pages/Home.dart';
import 'package:news_app/services/auth.dart';
import 'package:news_app/services/snack_bar_service.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: 'sign-up-form');
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late String _snackBarText;
  AuthMethod authMethod = new AuthMethod();



  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 40),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Sign Up.',
                          style: TextStyle(
                              fontSize: 80.0, fontWeight: FontWeight.bold),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  TextFormField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    // validator: (String value) {
                    //   if (value.isEmpty) {
                    //     return 'full-name cannot be empty';
                    //   }
                    //   return null;
                    // },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    // validator: (String value) {
                    //   if (value.isEmpty) {
                    //     return 'email cannot be empty';
                    //   }
                    //   return null;
                    // },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    // validator: (String value) {
                    //   if (value.isEmpty) {
                    //     return 'password cannot be empty';
                    //   }
                    //   return null;
                    // },
                    obscureText: true,
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
                          'Sign Up',
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
                            .signupwithemailandpassword(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                            _fullNameController.text.trim())
                            .then((val) => setState(() {

                          if(val == null){
                            final snackBar = SnackBar(content: Text('Invalid Input'));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }else if(val == 'The password provided is too weak'){
                            final snackBar = SnackBar(content: Text('The password provided is too weak'));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }else if(val == 'The account already exists for that email'){
                            final snackBar = SnackBar(content: Text('The account already exists for that email'));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }else{
                            final snackBar = SnackBar(content: Text('User Registered'));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BaseLayer()),
                            );
                          }
                        }));

                        // if (_snackBarText  != null) {
                        //   SnackBarService.instance
                        //       .showSnackBar(scaffoldKey, _snackBarText);
                        //
                        // } else {
                        //   SnackBarService.instance
                        //       .showSnackBar(scaffoldKey, _snackBarText);
                        // }
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
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
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
