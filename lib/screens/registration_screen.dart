import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home_screen.dart';
import 'login_screen.dart';


class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _email, _password;

  var _formkey = GlobalKey<FormState>();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
        backgroundColor: Colors.pink,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.all(16),
                alignment: Alignment.center,
                child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (item) {
                            return item.contains("@")
                                ? null
                                : "Enter valid Email";
                          },
                          onChanged: (item) {
                            setState(() {
                              _email = item;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: "Enter Email",
                              labelText: "Email",
                              labelStyle: new TextStyle(color: Colors.green),
                              focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.pink, width: 2.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          validator: (item) {
                            return item.length > 5
                                ? null
                                : "Password must be 6 characters";
                          },
                          onChanged: (item) {
                            setState(() {
                              _password = item;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: "Enter Password",
                              labelText: "Password",
                              labelStyle: new TextStyle(color: Colors.green),
                              focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.pink, width: 2.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          child: RaisedButton(
                            color: Colors.pink,
                            onPressed: () {
                              signup();
                            },
                            child: Text(
                              "Register", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            textColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => LoginScreen()));
                              },
                              child: Text("Login here", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.orange),), ),
                          alignment: Alignment.centerRight,
                        )
                      ],
                    )),
              ),
          ),
    );
  }

  void signup() {
    if (_formkey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((user) {
        // sign up
        setState(() {
          isLoading = false;
        });

        Fluttertoast.showToast(msg: "Register Success");

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => HomeScreen()),
            (Route<dynamic> route) => false);
      }).catchError((onError) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "error " + onError.toString());
      });
    }
  }
}
